page 50023 "Staged Payment Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Staged Payment Line";

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
            group(Hex)
            {
                fixed(ok)
                {
                    group("Document Total")
                    {
                        Caption = 'Document Total';
                        field(Totals; GetTotalIncVATAmt)
                        {
                        }
                    }
                    group(Allocated2)
                    {
                        Caption = 'Allocated2';
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
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        SMAXext: Codeunit "Hex Smax Stage Ext";
    begin
        CASE "Document Type" OF
            "Document Type"::"Purch. Order":
                IF PurchHeader.GET(PurchHeader."Document Type"::Order, "Document No.") THEN
                    Result := SMAXext.GetQtyToInvoiceAmountPurch(PurchHeader);
            "Document Type"::"Purch. Invoice":
                IF PurchHeader.GET(PurchHeader."Document Type"::Invoice, "Document No.") THEN
                    Result := SMAXext.GetQtyToInvoiceAmountPurch(PurchHeader);
            "Document Type"::"Sales Order":
                IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Document No.") THEN
                    Result := SMAXext.GetQtyToInvoiceAmountSales(SalesHeader);
            "Document Type"::"Sales Invoice":
                IF SalesHeader.GET(SalesHeader."Document Type"::Invoice, "Document No.") THEN
                    Result := SMAXext.GetQtyToInvoiceAmountSales(SalesHeader);
        END;
    end;
}

