tableextension 50019 "Excel Buffer_HGN" extends "Excel Buffer"
{
    fields
    {
        field(50000; "Font Name_HGN"; Text[100])
        {
            Caption = 'Font Name';
            DataClassification = CustomerContent;

        }
        field(50101; "Font Size_HGN"; Integer)
        {
            Caption = 'Font Size';
            DataClassification = CustomerContent;
        }
        field(50102; "Using Custom Format_HGN"; Boolean)
        {
            Caption = 'Using Custom Format';
            DataClassification = CustomerContent;
        }

    }


    var
        // Need to Modify the Variables Because These variables data should come from Excel Buffer table.
        // Because of Protection level In Base table Not able access variable 
        CurrentRow: Integer;
        CurrentCol: Integer;
        Text002_HGN: Label 'You must enter an Excel worksheet name.', Comment = '{Locked="Excel"}';
        //FileManagement_HGN: Codeunit "File Management";
        //OpenXMLManagement_HGN: Codeunit "OpenXML Management";
        //XlWrkBkWriter: DotNet WorkbookWriter;
        Text037_HGN: Label 'Could not create the Excel workbook.', Comment = '{Locked="Excel"}';

    procedure AddColumnWithFont(Value: Variant; IsFormula: Boolean; CommentText: Text; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option; FontName: Text; FontSize: Integer; UsingCustomFormat: Boolean)
    begin
        IF CurrentRow < 1 THEN
            NewRow;

        CurrentCol := CurrentCol + 1;
        INIT;
        VALIDATE("Row No.", CurrentRow);
        VALIDATE("Column No.", CurrentCol);
        IF IsFormula THEN
            SetFormula(FORMAT(Value))
        ELSE
            "Cell Value as Text" := FORMAT(Value);
        Comment := CommentText;
        Bold := IsBold;
        Italic := IsItalics;
        Underline := IsUnderline;
        NumberFormat := NumFormat;
        "Cell Type" := CellType;
        "Font Name_HGN" := FontName;
        "Font Size_HGN" := FontSize;
        "Using Custom Format_HGN" := UsingCustomFormat;
        INSERT;

    end;

    procedure CreateBookAndOpenExcel_HGN(FileName: Text; SheetName: Text[250]; ReportHeader: Text; CompanyName2: Text; UserID2: Text)
    begin
        //CreateBook_HGN(FileName, SheetName);
        WriteSheet(ReportHeader, CompanyName2, UserID2);
        CloseBook;
        OpenExcel;
    end;

    //   procedure CreateBook_HGN(FileName: Text; SheetName: Text)
    // begin
    //   if SheetName = '' then
    //     Error(Text002_HGN);

    //if FileName = '' then
    //  FileNameServer := FileManagement.ServerTempFileName('xlsx')
    //else begin
    //  if Exists(FileName) then
    //    Erase(FileName);
    //FileNameServer := FileName;
    // end;

    //FileManagement.IsAllowedPath(FileNameServer, false);
    //XlWrkBkWriter := XlWrkBkWriter.Create(FileNameServer);
    //if IsNull(XlWrkBkWriter) then
    //  Error(Text037);

    //XlWrkShtWriter := XlWrkBkWriter.FirstWorksheet;
    //if SheetName <> '' then
    //  XlWrkShtWriter.Name := SheetName;

    // OpenXMLManagement.SetupWorksheetHelper(XlWrkBkWriter);
    //end;


}
