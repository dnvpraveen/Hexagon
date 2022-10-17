codeunit 50102 "Financial Data Export Mgt._HGN"
{
    var
        CompanyInformation: Record "Company Information";
        FileNameTxt: Label '%1_%2M%3.txt', Comment = '%1 - Business Unit, %2 - Year, %3 - Month', Locked = true;
        PeriodTxt: Label '%1M%2', Comment = '%1 - Year, %2 - Month', Locked = true;
        SheetNameTxt: Label '%1M%2', Comment = '%1 - Year, %2 - Month', Locked = true;
        ExcelFileNameTxt: Label '%1_%2M%3', Comment = '%1 - Business Unit, %2 - Year, %3 - Month', Locked = true;

    procedure CalcGL(GLAccount: Record "G/L Account"; StartingDate: Date; EndingDate: Date; var ExportBuffer: Record "Financial Data Exp. Buffer_HGN")
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
        if GLEntry.IsEmpty() then
            exit;
        CompanyInformation.Get();
        CompanyInformation.TestField("Intercompany Partner Dim_HGN");
        CompanyInformation.TestField("Product Category Dim_HGN");
        CompanyInformation.TestField("Custom2 Dim (Country)_HGN");
        CompanyInformation.TestField("Cost Center Dim_HGN");
        CompanyInformation.TestField("Entity No._HGN");
        CalcByDim(GLAccount, StartingDate, EndingDate, ExportBuffer);
    end;

    local procedure CalcByDim(GLAccount: Record "G/L Account"; StartingDate: Date; EndingDate: Date; var ExportBuffer: Record "Financial Data Exp. Buffer_HGN")
    var
        GLEntry: Record "G/L Entry";
        ICDimValue: Code[20];
        ProdCatDimValue: Code[20];
        Custom2DimValue: Code[20];
        CCDimValue: Code[20];
        Year: Integer;
        Month: Integer;
        IsClosingDate: Boolean;
        BeginningOfYear: Date;
    begin
        Year := Date2DMY(StartingDate, 3);
        Month := Date2DMY(StartingDate, 2);
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
        GLEntry.SetRange("Posting Date", 0D, EndingDate);
        BeginningOfYear := CalcDate('<-CY>', StartingDate);
        if GLEntry.FindSet() then
            repeat
                IsClosingDate := GLEntry."Posting Date" <> NormalDate(GLEntry."Posting Date");
                ICDimValue := GetDimValue(CompanyInformation."Intercompany Partner Dim_HGN", GLEntry."Dimension Set ID");
                ProdCatDimValue := '';
                Custom2DimValue := '';
                CCDimValue := '';
                if GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" then begin
                    ProdCatDimValue := GetDimValue(CompanyInformation."Product Category Dim_HGN", GLEntry."Dimension Set ID");
                    Custom2DimValue := GetDimValue(CompanyInformation."Custom2 Dim (Country)_HGN", GLEntry."Dimension Set ID");
                    CCDimValue := GetDimValue(CompanyInformation."Cost Center Dim_HGN", GLEntry."Dimension Set ID");
                end;
                FilterBufferByDim(ExportBuffer, Year, Month, GLAccount."No.", ICDimValue, ProdCatDimValue, Custom2DimValue, CCDimValue);
                if not ExportBuffer.FindFirst() then begin
                    InitBuffer(ExportBuffer, Year, Month, GLAccount."No.", ICDimValue, ProdCatDimValue, Custom2DimValue, CCDimValue, GLAccount.Name);
                    if GLEntry."Posting Date" < BeginningOfYear then
                        if GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" then
                            ExportBuffer."Initial Balance" := GLEntry.Amount
                        else
                            ExportBuffer."Initial Balance" := 0
                    else
                        if not IsClosingDate then
                            ExportBuffer."Net Change" := GLEntry.Amount;
                    ExportBuffer."Balance at Date" := ExportBuffer."Initial Balance" + ExportBuffer."Net Change";
                    ExportBuffer.Insert();
                end else begin
                    if GLEntry."Posting Date" < BeginningOfYear then
                        if GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" then
                            ExportBuffer."Initial Balance" += GLEntry.Amount
                        else
                            ExportBuffer."Initial Balance" := 0
                    else
                        if not IsClosingDate then
                            ExportBuffer."Net Change" += GLEntry.Amount;
                    ExportBuffer."Balance at Date" := ExportBuffer."Initial Balance" + ExportBuffer."Net Change";
                    ExportBuffer.Modify();
                end;
            until GLEntry.Next() = 0;
    end;

    local procedure GetDimValue(DimCode: Code[20]; DimSetID: Integer): Code[20]
    var
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        if DimensionSetEntry.Get(DimSetID, DimCode) then
            exit(DimensionSetEntry."Dimension Value Code")
        else
            exit('');
    end;

    local procedure FilterBufferByDim(var ExportBuffer: Record "Financial Data Exp. Buffer_HGN"; Year: Integer; Month: Integer; AccNo: Code[20]; ICDimValue: Code[20]; ProdCatDimValue: Code[20]; Custom2DimValue: Code[20]; CCDimValue: Code[20])
    begin
        ExportBuffer.Reset();
        ExportBuffer.SetRange(Year, Year);
        ExportBuffer.SetRange(Month, Month);
        ExportBuffer.SetRange("G/L Account No.", AccNo);
        ExportBuffer.SetRange("Intercompany Partner", ICDimValue);
        ExportBuffer.SetRange("Product Cat", ProdCatDimValue);
        ExportBuffer.SetRange("Custom2 Dim", Custom2DimValue);
        ExportBuffer.SetRange("Cost Center Dim", CCDimValue);
    end;

    local procedure InitBuffer(var ExportBuffer: Record "Financial Data Exp. Buffer_HGN"; Year: Integer; Month: Integer; AccNo: Code[20]; ICDimValue: Code[20]; ProdCatDimValue: Code[20]; Custom2DimValue: Code[20]; CCDimValue: Code[20]; AccountName: Text[100])
    begin
        ExportBuffer.Init();
        ExportBuffer.Year := Year;
        ExportBuffer.Month := Month;
        ExportBuffer."G/L Account No." := AccNo;
        ExportBuffer."Account Name" := AccountName;
        ExportBuffer."Intercompany Partner" := ICDimValue;
        ExportBuffer."Product Cat" := ProdCatDimValue;
        ExportBuffer."Custom2 Dim" := Custom2DimValue;
        ExportBuffer."Cost Center Dim" := CCDimValue;
    end;

    procedure ExportBufferToTxt(var FinExportBuffer: Record "Financial Data Exp. Buffer_HGN"; Year: Integer; Month: Integer)
    var
        TempBlob: Codeunit "Temp Blob";
        CR: Char;
        LF: Char;
        FileName: Text;
        Enter: Text;
        Period: Text;
        Sep: Char;
        OutStr: OutStream;
        InStr: InStream;
    begin
        CR := 13;
        LF := 10;
        if CompanyInformation."Separat. for Fin Exp File_HGN" = CompanyInformation."Separat. for Fin Exp File_HGN"::TAB then
            Sep := 9
        else
            Sep := 59;
        Enter := Format(CR) + Format(LF);
        FileName := StrSubstNo(FileNameTxt, CompanyInformation."Entity No._HGN", Year, Month);
        Period := StrSubstNo(PeriodTxt, Year, Month);
        FinExportBuffer.Reset();
        if not FinExportBuffer.FindFirst() then
            exit;
        TempBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        repeat
            if FinExportBuffer."Balance at Date" <> 0 then
                OutStr.WriteText(
                  Period + Format(Sep) +
                  CompanyInformation."Entity No._HGN" + Format(Sep) +
                  FinExportBuffer."G/L Account No." + Format(Sep) +
                  FinExportBuffer."Account Name" + Format(Sep) +
                  FinExportBuffer."Intercompany Partner" + Format(Sep) +
                  FinExportBuffer."Product Cat" + Format(Sep) +
                  FinExportBuffer."Custom2 Dim" + Format(Sep) +
                  FinExportBuffer."Cost Center Dim" + Format(Sep) +
                  Format(FinExportBuffer."Balance at Date", 0, '<Precision,2:2><Sign><Integer><Decimals>') + Enter);
        until FinExportBuffer.Next() = 0;

        TempBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure ExportToExcel(var FinExportBuffer: Record "Financial Data Exp. Buffer_HGN"; Year: Integer; Month: Integer)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExcelFileName: Text;
    begin
        CompanyInformation.Get();
        FinExportBuffer.Reset();
        if not FinExportBuffer.FindFirst() then
            exit;

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption(Year), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption(Month), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CompanyInformation.FieldCaption("Entity No._HGN"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("G/L Account No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Account Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Intercompany Partner"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Product Cat"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Custom2 Dim"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Cost Center Dim"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Initial Balance"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Net Change"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FinExportBuffer.FieldCaption("Balance at Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        repeat
            if not ((FinExportBuffer."Initial Balance" = 0) and (FinExportBuffer."Net Change" = 0) and (FinExportBuffer."Balance at Date" = 0)) then begin
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(FinExportBuffer.Year, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer.Month, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(CompanyInformation."Entity No._HGN", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."G/L Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Account Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Intercompany Partner", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Product Cat", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Custom2 Dim", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Cost Center Dim", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FinExportBuffer."Initial Balance", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(FinExportBuffer."Net Change", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(FinExportBuffer."Balance at Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            end;
        until FinExportBuffer.Next() = 0;

        ExcelFileName := StrSubstNo(ExcelFileNameTxt, CompanyInformation."Entity No._HGN", Year, Month);
        TempExcelBuffer.CreateNewBook(StrSubstNo(SheetNameTxt, Year, Month));
        TempExcelBuffer.WriteSheet(StrSubstNo(SheetNameTxt, Year, Month), CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;
}