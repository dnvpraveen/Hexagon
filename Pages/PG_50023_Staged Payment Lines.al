page 50023 "Staged Payment Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = 56021;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Due Date"; "Due Date")
                {

                    trigger OnValidate()
                    var
                        ValueAmt: Decimal;
                    begin
                        ValueAmt := 0;
                        CALCFIELDS("Total Value (Inc. VAT)");
                        ValueAmt := GetTotalIncVATAmt - "Total Value (Inc. VAT)";
                        IF ValueAmt > 0 THEN
                            VALIDATE("Value (Inc. VAT)", ValueAmt);
                        CALCFIELDS("Total Value (Inc. VAT)");
                        CurrPage.UPDATE;
                    end;
                }
                field("Value (Inc. VAT)"; "Value (Inc. VAT)")
                {

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Total Value (Inc. VAT)");
                        CurrPage.UPDATE;
                    end;
                }
            }
            group()
            {
                fixed()
                {
                    group("Document Total")
                    {
                        Caption = 'Document Total';
                        field(Totals; GetTotalIncVATAmt)
                        {
                        }
                    }
                    group(Allocated)
                    {
                        Caption = 'Allocated';
                        field(Allocated; "Total Value (Inc. VAT)")
                        {
                            DrillDown = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        StagedTotalAmt: Decimal;

    local procedure GetTotalIncVATAmt() Result: Decimal
    var
        PurchHeader: Record "38";
        SalesHeader: Record "36";
    begin
        CASE "Document Type" OF
            "Document Type"::"Purch. Order":
                IF PurchHeader.GET(PurchHeader."Document Type"::Order, "Document No.") THEN
                    Result := GetQtyToInvoiceAmountPurch(PurchHeader);
            "Document Type"::"Purch. Invoice":
                IF PurchHeader.GET(PurchHeader."Document Type"::Invoice, "Document No.") THEN
                    Result := GetQtyToInvoiceAmountPurch(PurchHeader);
            "Document Type"::"Sales Order":
                IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Document No.") THEN
                    Result := GetQtyToInvoiceAmountSales(SalesHeader);
            "Document Type"::"Sales Invoice":
                IF SalesHeader.GET(SalesHeader."Document Type"::Invoice, "Document No.") THEN
                    Result := GetQtyToInvoiceAmountSales(SalesHeader);
        END;
    end;
}

