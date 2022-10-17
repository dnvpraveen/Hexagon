report 50102 "Financial Data Export_HGN"
{
    Caption = 'Financial Data Export';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                StartingDate: Date;
                EndingDate: Date;
            begin
                Window.Update(1, "No.");
                StartingDate := DMY2Date(1, Month, Year);
                EndingDate := CalcDate('<CM>', StartingDate);
                FinExportMgmt.CalcGL("G/L Account", StartingDate, EndingDate, TempExportBuffer);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                if ExportTxt then
                    FinExportMgmt.ExportBufferToTxt(TempExportBuffer, Year, Month);
                if ExportExcel then
                    FinExportMgmt.ExportToExcel(TempExportBuffer, Year, Month);
            end;

            trigger OnPreDataItem()
            var
                MonthYearNotBlankErr: Label 'Month and year cannot be blank.';
            begin
                if (Month = 0) or (Year = 0) then
                    Error(MonthYearNotBlankErr);
                TempExportBuffer.DeleteAll();
                Window.Open(ProgressLbl);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Period)
                {
                    Caption = 'Period';

                    field(MonthPeriod; Month)
                    {
                        Caption = 'Month';
                        MaxValue = 12;
                        MinValue = 1;
                        BlankZero = true;
                        ToolTip = 'Specifies the value of the Month field.';
                        ApplicationArea = All;
                    }
                    field(YearPeriod; Year)
                    {
                        Caption = 'Year';
                        MaxValue = 2070;
                        MinValue = 2010;
                        BlankZero = true;
                        ToolTip = 'Specifies the value of the Year field.';
                        ApplicationArea = All;
                    }
                }
                group("Export Options")
                {
                    Caption = 'Export Options';
                    field(ExportToTxt; ExportTxt)
                    {
                        Caption = 'Export as Txt';
                        ToolTip = 'Specifies the value of the Export as Txt field.';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if ExportTxt then
                                ExportExcel := false;
                        end;
                    }
                    field(ExportToExcel; ExportExcel)
                    {
                        Caption = 'Export as Excel';
                        ToolTip = 'Specifies the value of the Export as Excel field.';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if ExportExcel then
                                ExportTxt := false;
                        end;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ExportExcel := true;
            ExportTxt := false;
        end;
    }

    var
        TempExportBuffer: Record "Financial Data Exp. Buffer_HGN" temporary;
        FinExportMgmt: Codeunit "Financial Data Export Mgt._HGN";
        ProgressLbl: Label 'Processing account no... #1#############', Comment = '#1-Account No.';
        Year: Integer;
        Month: Integer;
        ExportTxt: Boolean;
        ExportExcel: Boolean;
        Window: Dialog;
}

