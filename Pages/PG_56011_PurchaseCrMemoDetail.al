page 56011 "Purchase Cr. Memo Detail"
{
    ApplicationArea = All;
    Caption = 'Purchase Cr. Memo Detail';
    PageType = List;
    SourceTable = "Purch. Cr. Memo Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field("Fecha de Registro"; rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }


                field("Valor Pendiente"; custledger."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }


                field("Pay-to Customer No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Vendor Name"; customer.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name';
                }
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;

                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }



                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }


                field("External Document No."; SalesHeader."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name';
                }


            }
        }
    }
    var
        customer: Record Vendor;
        custledger: Record "Vendor Ledger Entry";

    var
        SalesHeader: Record "Purch. Cr. Memo Hdr.";

    trigger OnAfterGetRecord()
    begin
        Clear(custledger);
        custledger.Reset();
        ;
        custledger.SetRange("Document No.", rec."Document No.");
        if custledger.FindSet() then
            custledger.CalcFields("Remaining Amount");


        IF customer.GET(Rec."Pay-to Vendor No.") THEN;
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."Document No.");
        IF SalesHeader.FindSet() THEN;
    end;

}
