page 50098 "SMAX Sales Invoices"
{
    // KMS:20/03/2017-MMI
    // Customer Sales History functionality

    Caption = 'SMAX Sales Invoice Lines';
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Ready to Invoice" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Document No."; rec."Document No.")
                {
                    HideValue = DocumentNoHideValue_G;
                    Lookup = false;
                    StyleExpr = 'Strong';
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Name; CustomerName)
                {
                    Caption = 'Name';
                }
                field(Type; rec.Type)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("No."; rec."No.")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Description; rec.Description)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Description 2"; rec."Description 2")
                {
                }
                field("Currency Code"; rec."Currency Code")
                {
                }
                field("Location Code"; rec."Location Code")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Order Type"; rec."Order Type")
                {
                }
                field("Smax Line No."; rec."Smax Line No.")
                {
                }
                field("Work Order No."; rec."Work Order No.")
                {
                }
                field(Quantity; rec.Quantity)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Ready to Invoice"; rec."Ready to Invoice")
                {
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Remaining Qty to Ship"; rec.Quantity - rec."Quantity Shipped")
                {
                    Caption = 'Remaining Qty to Ship';
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Amount; rec.Amount)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()


                    var
                        SalesHeader: Record "Sales Header";
                        SalesOrder: Page "Sales Order";
                    begin
                        Clear(SalesHeader);
                        SalesHeader.Reset();
                        SalesHeader.SetRange("No.", Rec."Document No.");
                        SalesHeader.SetRange("Document Type", rec."Document Type");
                        SalesHeader.FindSet();
                        SalesOrder.SetRecord(SalesHeader);
                        SalesOrder.Run();

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        // ++ KMS:20/03/2017-MMI
                        //ShowDimensions;
                        // -- KMS:20/03/2017-MMI
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // ++ KMS:20/03/2017-MMI Manage Show Document No.
        DocumentNoHideValue_G := FALSE;

        // -- KMS:20/03/2017-MMI


        IF Customer.GET(rec."Bill-to Customer No.") THEN
            CustomerName := Customer.Name
        ELSE
            CustomerName := '';
    end;

    var
        _KMS_GLOBALS: Integer;
        [InDataSet]
        DocumentNoHideValue_G: Boolean;
        [InDataSet]
        isAttentionStyle_G: Boolean;
        CustomerName: Text[50];
        Customer: Record Customer;

    [Scope('Internal')]
    procedure _KMS_FUNCTIONS()
    begin
    end;

    [Scope('Internal')]
    procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        // ++ KMS:20/03/2017-MMI
        // ------------------------------
        // Manage Show Document No.
        // ------------------------------
        CLEAR(SalesLine);
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", rec."Document Type");
        SalesLine.SETRANGE("Document No.", rec."Document No.");
        SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
        IF SalesLine.FINDFIRST THEN
            EXIT(Rec."Line No." = SalesLine."Line No.")
        ELSE
            EXIT(FALSE);
        // -- KMS:20/03/2017-MMI
    end;


}


