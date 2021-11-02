pageextension 57017 "Hex Job Card" extends "Job Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Opportunity No."; "Opportunity No.")
            {
                Caption = 'Opportunity No.';
            }
            field("CurrencyCode"; "Currency Code")
            {
                Caption = 'Currency Code';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    CurrencyCheck;
                end;
            }
            field("Order Type"; "Order Type")
            {
                Caption = 'Order Type';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    IF "Order Type" = "Order Type"::System THEN
                        fill := FALSE
                    ELSE
                        fill := TRUE;
                end;
            }
            Field("Product Serial No."; "Product Serial No.")
            {
                Caption = 'Product Serial No.';
                Editable = fill;
            }
            field("ERP Company No."; "ERP Company No.")
            {
                Editable = fill;
            }

        }

        addafter("Person Responsible")
        {
            field("External Doc No."; "External Doc No.")
            {
                Caption = 'Customer PO';
            }
            field("Is IFRS15 Job"; "Is IFRS15 Job")
            {
                Caption = 'Is IFRS15 Job';
            }
            field("Order Date"; "Order Date")
            {
                Caption = 'Customer PO Date';
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                Caption = 'Salesperson Code';
            }
        }

        modify("No.")
        {
            Visible = true;
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';
        }
        modify("Bill-to Contact No.")
        {
            Caption = 'Sell-to Contact No.';
        }
        modify("Person Responsible")
        {
            Visible = false;
        }
        addafter("% Invoiced")
        {
            field("Total Revenue to Recognize"; "Total Revenue to Recognize")
            {
                Caption = 'Total Revenue to Recognize';
            }
            field("Total Rev to Recognize (LCY)"; "Total Rev to Recognize (LCY)")
            {
                Caption = 'Total Rev to Recognize (LCY)';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addbefore("W&IP")
        {

            action(OrderPlanning)
            {
                ApplicationArea = Suite;
                Caption = 'Order Planning';
                RunObject = Page 5522;
                Image = "Order";
            }
            action(RevenueRecognistion)
            {
                ApplicationArea = Suite;
                Caption = 'Revenue Recognistion';
                Runobject = Report 50099;
                Image = "Order";
            }
            action("Job Lines for Smax")
            {
                trigger OnAction()
                var
                    SmaxJobLine: Record "Job Records for Smax";
                begin
                    SmaxJobLine.SetRange("Job No.", "No.");     //Smax Job Lines order
                    Page.RunModal(55000, SmaxJobLine);
                end;
            }
            action("General Ledger Entries")
            {
                trigger OnAction()
                var
                    GLetnry: Record "G/L Entry";
                begin
                    GLetnry.setrange("Document No.", "No.");
                    PAGE.RUNMODAL(0, GLetnry);
                end;
            }
            action("Create IP Sales Order")
            {
                trigger OnAction()
                var
                    Hexext: Codeunit "Hex Smax Stage Ext";
                begin
                    Hexext.gfncCreateSalesDocGopal(rec, 1);     //sales order
                end;
            }
            action("Create Sales Credit")
            {
                trigger OnAction()
                var
                    Hexext: Codeunit "Hex Smax Stage Ext";
                begin
                    Hexext.gfncCreateSalesDoc(rec, 3);     //sales order
                end;
            }
            action("Orders / Invoices")
            {
                RunObject = Page "Job Order Link List";
                RunPageLink = "Job No." = FIELD("No.");
                Image = Documents;
            }
        }
    }
    var
        fill: Boolean;
    // Hexext: Codeunit "Hex Smax Stage Ext";


}