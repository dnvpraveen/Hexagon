page 55029 "SMAX Sales Invoice Lines"
{
    // KMS:20/03/2017-MMI
    // Customer Sales History functionality

    Caption = 'SMAX Sales Invoice Lines';
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
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
                field("Document No."; "Document No.")
                {
                    HideValue = DocumentNoHideValue_G;
                    Lookup = false;
                    StyleExpr = 'Strong';
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Name; CustomerName)
                {
                    Caption = 'Name';
                }
                field(Type; Type)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("No."; "No.")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Description; Description)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Description 2"; "Description 2")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Location Code"; "Location Code")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Bin Code"; "Bin Code")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Order Type"; "Order Type")
                {
                }
                field("Smax Line No."; "Smax Line No.")
                {
                }
                field("Work Order No."; "Work Order No.")
                {
                }
                field(Quantity; Quantity)
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Ready to Invoice"; "Ready to Invoice")
                {
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Remaining Qty to Ship"; Quantity - "Quantity Shipped")
                {
                    Caption = 'Remaining Qty to Ship';
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                    Visible = false;
                }
                field("Unit Price"; "Unit Price")
                {
                    Style = Attention;
                    StyleExpr = isAttentionStyle_G;
                }
                field(Amount; Amount)
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
                    begin
                        // ++ KMS:20/03/2017-MMI
                        //ShowDocument;
                        // -- KMS:20/03/2017-MMI
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
        DocumentNoOnFormat;
        // -- KMS:20/03/2017-MMI


        IF Customer.GET("Bill-to Customer No.") THEN
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
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "Document No.");
        SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
        IF SalesLine.FINDFIRST THEN
            EXIT(Rec."Line No." = SalesLine."Line No.")
        ELSE
            EXIT(FALSE);
        // -- KMS:20/03/2017-MMI
    end;

    [Scope('Internal')]
    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
        SalesQuote: Page "Sales Quote";
    begin
        // ++ KMS:20/03/2017-MMI
        // ------------------------------
        // Open Document Page
        // ------------------------------
        IF NOT SalesHeader.GET("Document Type", "Document No.") THEN
            EXIT;

        CASE "Document Type" OF
            "Document Type"::Quote:
                PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
            "Document Type"::Order:
                PAGE.RUN(PAGE::"Sales Order", SalesHeader);
            "Document Type"::Invoice:
                PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
            "Document Type"::"Credit Memo":
                PAGE.RUN(PAGE::"Sales Credit Memo", SalesHeader);
            "Document Type"::"Blanket Order":
                PAGE.RUN(PAGE::"Blanket Sales Order", SalesHeader);
            "Document Type"::"Return Order":
                PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
        END;
        // -- KMS:20/03/2017-MMI
    end;

    local procedure DocumentNoOnFormat()
    begin
        // ++ KMS:20/03/2017-MMI
        // ------------------------------
        //  Manage Show Document No.
        // ------------------------------
        //IF NOT IsFirstDocLine THEN
        //  DocumentNoHideValue_G := TRUE;
        // -- KMS:20/03/2017-MMI
    end;
}

