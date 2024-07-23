page 50099 SalesInvoiceLine
{
    ApplicationArea = All;
    Caption = 'Sales Invoice Line';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
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
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Amount field.';
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("PRODUCT CAT Name"; DimensionValue.Name) { }

                field("Currency Code"; SalesInvHeader."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = all;
                }
                field("Order Date"; SalesInvHeader."Order Date")
                {
                    Caption = 'Order Date';
                    ApplicationArea = all;
                }

                field("External Document No."; SalesInvHeader."External Document No.")
                {
                    Caption = 'External Document No.';
                    ApplicationArea = all;
                }

                field("Document Date"; SalesInvHeader."Document Date")
                {
                    Caption = 'Document Date';
                    ApplicationArea = all;

                }
                field("AkkOn-SAT Relationship type"; SalesInvHeader."AkkOn-SAT Relationship type")
                {
                    Caption = 'AkkOn-SAT Relationship type';
                    ApplicationArea = all;

                }
                field("Customer Name"; SalesInvHeader."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = all;

                }
                field("UUID"; SalesInvHeader."Fiscal Invoice Number PAC")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = all;
                }

                field("Unit Of Measure Code"; rec."Unit of Measure Code")
                {
                    Caption = 'Unit Of Measure Code';
                    ApplicationArea = all;

                }
                field("Akkon Action"; SalesInvHeader."Akkon-Action")
                {
                    Caption = 'AkkOn Action';
                    ApplicationArea = all;

                }


            }

        }



    }

    var
        Customer: Record Customer;
        DimensionValue: Record "Dimension Value";
        SalesInvHeader: Record "Sales Invoice Header";

    trigger OnAfterGetRecord()

    begin
        Clear(SalesInvHeader);
        SalesInvHeader.get(rec."Document No.");
        CLEAR(DimensionValue);
        CLEAR(Customer);
        IF rec."Sell-to Customer No." <> '' THEN
            Customer.GET(rec."Sell-to Customer No.");
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, rec."Shortcut Dimension 2 Code");
        IF DimensionValue.FINDSET THEN;
    end;
}
