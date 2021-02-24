codeunit 56011 "Hex Smax Stage Ext"
{
    trigger OnRun()
    begin

    end;

    PROCEDURE IPCreated(JobRecordsforSmax: Record "Job Records for Smax");
    VAR
        LJobRecordsforSmax: Record "Job Records for Smax";
    BEGIN
        IF JobRecordsforSmax."IP Created" THEN BEGIN
            LJobRecordsforSmax.RESET;
            LJobRecordsforSmax.SETRANGE("Job No.", JobRecordsforSmax."Job No.");
            LJobRecordsforSmax.SETRANGE("IP Created", FALSE);
            IF LJobRecordsforSmax.FINDSET THEN
                REPEAT
                    LJobRecordsforSmax."IP Created" := TRUE;
                    LJobRecordsforSmax.MODIFY;
                UNTIL LJobRecordsforSmax.NEXT = 0;
        END;
    END;

    PROCEDURE GetQtyToInvoiceAmountPurch(PurchHeader: Record 38): Decimal;
    VAR
        PurchLine: Record 39;
        Result: Decimal;
    BEGIN
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice THEN BEGIN
            PurchHeader.CALCFIELDS("Amount Including VAT");
            EXIT(PurchHeader."Amount Including VAT");
        END;

        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN BEGIN
            PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchHeader."No.");
            PurchLine.SETFILTER("Qty. to Invoice", '<>0');
            IF NOT PurchLine.FINDSET THEN EXIT;
            REPEAT
                Result += ROUND(PurchLine."Amount Including VAT" / PurchLine.Quantity * PurchLine."Qty. to Invoice");
            UNTIL PurchLine.NEXT = 0;
            EXIT(Result);
        END;
    END;

    PROCEDURE GetQtyToInvoiceAmountSales(SalesHeader: Record 36): Decimal;
    VAR
        SalesLine: Record 37;
        Result: Decimal;
    BEGIN
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
            SalesHeader.CALCFIELDS("Amount Including VAT");
            EXIT(SalesHeader."Amount Including VAT");
        END;

        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETFILTER("Qty. to Invoice", '<>0');
            IF NOT SalesLine.FINDSET THEN EXIT;
            REPEAT
                Result += ROUND(SalesLine."Amount Including VAT" / SalesLine.Quantity * SalesLine."Qty. to Invoice");
            UNTIL SalesLine.NEXT = 0;
            EXIT(Result);
        END;
    END;
}