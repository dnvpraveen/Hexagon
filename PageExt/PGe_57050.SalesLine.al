pageextension 50093 SalesLineExt extends "Sales Lines"
{
    layout
    {
        addafter("Outstanding Quantity")
        {
            field("Order Date"; SalesHeader."Order Date") { }
            field("Posting Date"; SalesHeader."Posting Date") { }
            field("Invoice Registered"; SalesInvoiceLine."Document No.") { }
            field("Currency Code"; rec."Currency Code") { }
            field("Document Date"; SalesHeader."Document Date") { }
            field("PRODUCT CAT Name"; DimensionValue.Name) { }
            field("Unit Price"; rec."Outstanding Amount") { }
            field("External Document No."; SalesHeader."External Document No.") { }
            field("Customer Name"; Customer.Name) { }
            field("VAT %"; rec."VAT %") { }
            field("Quantity Invoiced"; REC."Quantity Invoiced") { }
            field("Quantity to Invoice"; REC."Qty. to Invoice") { }
            field("Amount to Invoice"; AmountToInvoice) { }
            field("Amount Invoiced"; rec."Line Amount" - AmountToInvoice) { }
            field("Requested Delivery Date"; rec."Requested Delivery Date") { }
        }
    }
    var
        SalesHeader: Record "Sales Header";
        DimensionValue: Record "Dimension Value";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        AmountToInvoice: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        AmountToInvoice := 0;
        AmountToInvoice := rec."Qty. to Invoice" * rec."Unit Price";
        CLEAR(DimensionValue);
        CLEAR(Customer);
        IF rec."Sell-to Customer No." <> '' THEN
            Customer.GET(rec."Sell-to Customer No.");
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, rec."Shortcut Dimension 2 Code");
        IF DimensionValue.FINDSET THEN;

        IF rec."Document No." <> '' THEN BEGIN
            CLEAR(SalesHeader);
            CLEAR(SalesInvoiceHeader);
            CLEAR(SalesInvoiceLine);
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", rec."Document No.");
            IF SalesHeader.FINDSET THEN;

            SalesInvoiceHeader.RESET;
            SalesInvoiceHeader.SETRANGE("Order No.", rec."Document No.");
            IF SalesInvoiceHeader.FINDSET THEN BEGIN
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SETFILTER(Quantity, '<>0');
                SalesInvoiceLine.SETRANGE("No.", rec."No.");
                IF SalesInvoiceLine.FINDSET THEN;
            END;
        END

    end;
}
