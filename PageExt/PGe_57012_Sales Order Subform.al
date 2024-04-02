pageextension 57012 "Hex Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        //addlast()
        addafter("Shipment Date")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Editable = true;
            }
            field("Smax Line No."; "Smax Line No.")
            {
                Editable = false;
            }
            field("Order Created"; "Order Created")
            {
                Editable = false;
            }
            field("Order Inserted"; "Order Inserted")
            {
                Editable = false;
            }
            field("Ready to Invoice"; "Ready to Invoice")
            {
                Editable = true;
            }
            field("Job No."; "Job No.")
            { }
            field("Job Planning Line No."; "Job Planning Line No.")
            { }
            field("Job Task No."; "Job Task No.") { }
            field("VAT Identifier"; "VAT Identifier")
            {
            }
            field("Doc. Line Discount %_HGN"; Rec."Doc. Line Discount %_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Line Discount % HGN';
                Caption = 'Doc. Line Discount %';
                ApplicationArea = All;
                Visible = SDCenable_HGN;
            }
            field("Doc. Line Amount_HGN"; Rec."Doc. Line Amount_HGN")
            {
                Caption = 'Doc. Line Amount';
                ApplicationArea = All;
                Visible = SDCenable_HGN;
                ToolTip = 'Specifies the value of Doc. Line Amount HGN';
                trigger OnValidate()
                begin
                    SaveRecord();
                    UpdateTotalDocLines();
                end;
            }
            field("Doc. Unit Price_HGN"; rec."Doc. Unit Price_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Unit Price HGN';
                Caption = 'Doc. Unit Price';
                ApplicationArea = All;
                Visible = SDCenable_HGN;
            }
            field("Doc. Qty_HGN"; rec."Doc. Qty_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Qty HGN';
                Caption = 'Doc. Qty';
                ApplicationArea = All;
                Visible = SDCenable_HGN;
            }
            field("Doc. VAT %_HGN"; rec."Doc. VAT %_HGN")
            {
                ToolTip = 'Specifies the value of Doc. VAT % HGN';
                Caption = 'Doc. VAT %';
                ApplicationArea = All;
                Visible = SDCenable_HGN;
            }
        }
        addafter("TotalSalesLine.""Line Amount""")
        {
            field("Doc Line Total_HGN2"; "Doc Line Total_HGN")
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Doc Line Total';
                Visible = SDCenable_HGN;
                Editable = false;
                ToolTip = 'Specifies the sum of the value in the Doc Line Total Excl. VAT field on all lines in the document.';
            }
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                if SDCenable_HGN Then begin
                    SaveRecord();
                    UpdateTotalDocLines();
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                if SDCenable_HGN Then begin
                    SaveRecord();
                    UpdateTotalDocLines();
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if SDCenable_HGN Then
                    UpdateTotalDocLines();
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        SDCenable_HGN: Boolean;
        Currency: Record Currency;
        TotalSalesLine: Record "Sales Line";
        "Doc Line Total_HGN": Decimal;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SDCenable_HGN := true;
        if SalesSetup.Get() then begin
            if NOT SalesSetup."SDC Enable_HGN" then begin
                SDCenable_HGN := false;
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateTotalDocLines();
        if rec."Item Category Code" = '' then
            exit;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if SDCenable_HGN Then
            UpdateTotalDocLines();
    end;
    /// <summary>
    /// UpdateTotalDocLines.
    /// </summary>
    procedure UpdateTotalDocLines()
    var
        SalesLine2: Record "Sales Line";
    begin
        "Doc Line Total_HGN" := 0;
        SalesLine2.Reset();
        SalesLine2.CopyFilters(Rec);
        SalesLine2.CalcSums("Doc. Line Amount_HGN");
        "Doc Line Total_HGN" := SalesLine2."Doc. Line Amount_HGN";
    end;

}