page 56010 Deferral
{
    ApplicationArea = All;
    Caption = 'Deferral';
    PageType = List;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;
    SourceTableView = where("G/L Account No." = filter(400001 .. 410001));


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Customer No"; CustomerNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Customer Name"; CustomerName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(Amount; Rec.Amount * -1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account Name field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field("AkkOn-SAT UUID Stamp"; Rec."AkkOn-SAT UUID Stamp")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AkkOn-SAT UUID Stamp field.';
                }
                field("AkkOn-VAT Registration No."; Rec."AkkOn-VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AkkOn-VAT Registration No. field.';
                }

            }

        }



    }

    actions
    {
        area(Processing)
        {
            action(Actualizar)
            {
                Caption = 'Update Backlog Report';
                Image = UpdateShipment;
                trigger OnAction()
                var
                    Backlog: Record Backlog_HGN;
                    Ultimo: Integer;
                begin

                    Backlog.Reset();
                    Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::Deferral);
                    if Backlog.FindSet() then
                        repeat
                            Backlog.Delete();
                        until Backlog.Next() = 0;
                    Backlog.Reset();
                    if Backlog.FindLast() then
                        Ultimo := Backlog."Entry No." + 1 else
                        Ultimo := 1;
                    rec.FindSet();
                    repeat
                        Clear(SalesCrmemo);
                        Clear(SalesInvHeader);
                        Clear(Job);
                        CustomerNo := '';
                        CustomerName := '';

                        if SalesCrmemo.get(rec."Document No.") then begin
                            CustomerNo := SalesCrmemo."Sell-to Customer No.";
                            CustomerName := SalesCrmemo."Sell-to Customer Name";
                        end;
                        if SalesInvHeader.get(rec."Document No.") then begin
                            CustomerNo := SalesInvHeader."Sell-to Customer No.";
                            CustomerName := SalesInvHeader."Sell-to Customer Name";
                        end;
                        if Job.get(rec."Document No.") then begin
                            CustomerNo := job."Bill-to Customer No.";
                            CustomerName := job."Bill-to Name";
                            rec."External Document No." := Job."External Doc No.";
                        end;
                        Backlog."Entry No." := Ultimo;
                        Backlog.Init();
                        Backlog."No." := rec."Document No.";
                        Backlog."Sell-to Customer No." := CustomerNo;
                        Backlog."Sell-to Customer Name" := CustomerName;
                        Backlog."External Document No." := rec."External Document No.";
                        DimensionValue.Reset();
                        DimensionValue.SetRange(code, rec."Global Dimension 2 Code");
                        if DimensionValue.FindSet() then;
                        Backlog."Product CAT Name" := DimensionValue.Name;
                        Backlog."PRODUCT CAT Code" := rec."Global Dimension 2 Code";
                        Backlog."Item Description" := rec.Description;
                        Backlog."Item No." := rec."G/L Account No.";
                        Backlog."Document Date" := rec."Posting Date";
                        Backlog."Promised Delivery Date" := rec."Posting Date";
                        Backlog."Currency Code" := '';
                        Backlog.Amount := rec.Amount;
                        Backlog."Amount LCY" := rec.Amount;
                        Backlog."Tipo Reporte" := Backlog."Tipo Reporte"::Deferral;
                        DimensionEntry.Reset();
                        DimensionEntry.SetRange("Dimension Set ID", rec."Dimension Set ID");
                        DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                        if DimensionEntry.FindSet() then begin
                            DimensionEntry.CalcFields("Dimension Value Name");
                            Backlog."MTK Sector Name" := DimensionEntry."Dimension Value Name";
                            Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                        end;
                        Backlog.Insert();

                        Ultimo := Ultimo + 1;
                    until rec.Next() = 0;

                    Message('Report has been updated!');

                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        Clear(SalesCrmemo);
        Clear(SalesInvHeader);
        Clear(Job);
        CustomerNo := '';
        CustomerName := '';

        if SalesCrmemo.get(rec."Document No.") then begin
            CustomerNo := SalesCrmemo."Sell-to Customer No.";
            CustomerName := SalesCrmemo."Sell-to Customer Name";
        end;
        if SalesInvHeader.get(rec."Document No.") then begin
            CustomerNo := SalesInvHeader."Sell-to Customer No.";
            CustomerName := SalesInvHeader."Sell-to Customer Name";
        end;
        if Job.get(rec."Document No.") then begin
            CustomerNo := job."Bill-to Customer No.";
            CustomerName := job."Bill-to Name";
            rec."External Document No." := Job."External Doc No.";
        end;





    end;

    trigger OnOpenPage()
    var
        NextMonth: date;
        FechaSig: Date;

    begin
        NextMonth := CalcDate('<+1M>', WorkDate());
        FechaSig := DMY2Date(1, Date2DMY(NextMonth, 2), Date2DMY(NextMonth, 3));
        rec.SetFilter("Posting Date", FORMAT(FechaSig) + '..');
    end;

    procedure UpdateBacklog()
    var
        Backlog: Record Backlog_HGN;
        Ultimo: Integer;
        NextMonth: date;
        FechaSig: Date;
    begin

        Backlog.Reset();
        Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::Deferral);
        if Backlog.FindSet() then
            repeat
                Backlog.Delete();
            until Backlog.Next() = 0;
        Backlog.Reset();
        if Backlog.FindLast() then
            Ultimo := Backlog."Entry No." + 1 else
            Ultimo := 1;
        NextMonth := CalcDate('<+1M>', WorkDate());
        FechaSig := DMY2Date(1, Date2DMY(NextMonth, 2), Date2DMY(NextMonth, 3));
        rec.SetFilter("Posting Date", FORMAT(FechaSig) + '..');
        if rec.FindSet() then
            repeat
                Clear(SalesCrmemo);
                Clear(SalesInvHeader);
                Clear(Job);
                CustomerNo := '';
                CustomerName := '';

                if SalesCrmemo.get(rec."Document No.") then begin
                    CustomerNo := SalesCrmemo."Sell-to Customer No.";
                    CustomerName := SalesCrmemo."Sell-to Customer Name";
                end;
                if SalesInvHeader.get(rec."Document No.") then begin
                    CustomerNo := SalesInvHeader."Sell-to Customer No.";
                    CustomerName := SalesInvHeader."Sell-to Customer Name";
                end;
                if Job.get(rec."Document No.") then begin
                    CustomerNo := job."Bill-to Customer No.";
                    CustomerName := job."Bill-to Name";
                    rec."External Document No." := Job."External Doc No.";
                end;
                Backlog."Entry No." := Ultimo;
                Backlog.Init();
                Backlog."No." := rec."Document No.";
                Backlog."Sell-to Customer No." := CustomerNo;
                Backlog."Sell-to Customer Name" := CustomerName;
                Backlog."External Document No." := rec."External Document No.";
                DimensionValue.Reset();
                DimensionValue.SetRange(code, rec."Global Dimension 2 Code");
                if DimensionValue.FindSet() then;
                Backlog."Product CAT Name" := DimensionValue.Name;
                Backlog."PRODUCT CAT Code" := rec."Global Dimension 2 Code";
                Backlog."Item Description" := rec.Description;
                Backlog."Item No." := rec."G/L Account No.";
                Backlog."Document Date" := rec."Posting Date";
                Backlog."Promised Delivery Date" := rec."Posting Date";
                Backlog."Currency Code" := '';
                Backlog.Amount := rec.Amount;
                Backlog."Amount LCY" := rec.Amount;
                Backlog."Tipo Reporte" := Backlog."Tipo Reporte"::Deferral;
                DimensionEntry.Reset();
                DimensionEntry.SetRange("Dimension Set ID", rec."Dimension Set ID");
                DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                if DimensionEntry.FindSet() then begin
                    DimensionEntry.CalcFields("Dimension Value Name");
                    Backlog."MTK Sector Name" := DimensionEntry."Dimension Value Name";
                    Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                end;

                Backlog.Insert();

                Ultimo := Ultimo + 1;
            until rec.Next() = 0;

    end;

    var
        customer: Record customer;
        SalesInvHeader: Record "Sales Invoice Header";
        Job: Record Job;
        SalesCrmemo: Record "Sales Cr.Memo Header";
        CustomerNo: code[50];
        CustomerName: Text;
        DimensionEntry: Record "Dimension Set Entry";
        DimensionValue2: Record "Dimension Value";
        DimensionValue: Record "Dimension Value";

}
