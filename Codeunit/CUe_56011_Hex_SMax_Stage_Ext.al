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

    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR PurchaseHeader: Record "Purchase Header");
    VAR
        Text050: TextConst ENU = 'You cannot Canel/Short Close the order, Invoice is pending for Line No. %1 and Order No. %2';
        Text051: TextConst ENU = 'You cannot Canel/Short Close the order,Return Qty. Invoice is pending for Line No. %1 and Order No. %2';
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
    BEGIN
        PurchLine.RESET;
        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        IF PurchLine.FIND('-') THEN BEGIN
            REPEAT
                IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
                    ERROR(Text050, PurchLine."Line No.", PurchaseHeader."No.");
                IF PurchLine."Return Qty. Shipped Not Invd." <> 0 THEN
                    ERROR(Text051, PurchLine."Line No.", PurchaseHeader."No.");
            UNTIL PurchLine.NEXT = 0;
        END;
        IF OrderStatus = 'Close' THEN BEGIN
            PurchaseHeader."Cancel Short Close" := PurchaseHeader."Cancel Short Close"::"Short Closed";
            PurchaseHeader.MODIFY;
        END;
        IF OrderStatus = 'Cancel' THEN BEGIN
            PurchaseHeader."Cancel Short Close" := PurchaseHeader."Cancel Short Close"::Cancelled;
            PurchaseHeader.MODIFY;
        END;

        ArchiveManagement.ArchivePurchDocument(PurchaseHeader);
        PurchLine.RESET;
        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchLine.DELETEALL;
        PurchaseHeader.DELETE;
    END;

    PROCEDURE UpdateTotalRevenueLCY(var JobPlanningLine: record "Job Planning Line");
    VAR
        Currency: Record 4;
        CurrExchRate: Record 330;
    BEGIN
        //gk
        IF JobPlanningLine."Currency Code" <> '' THEN BEGIN
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
            JobPlanningLine."IFRS15 Line Amount (LCY)" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  GetDate(JobPlanningLine), JobPlanningLine."Currency Code",
                  JobPlanningLine."IFRS15 Line Amount", JobPlanningLine."Currency Factor"),
                Currency."Unit-Amount Rounding Precision")
        END ELSE
            JobPlanningLine."IFRS15 Line Amount (LCY)" := JobPlanningLine."IFRS15 Line Amount";

        //gk
    END;

    LOCAL PROCEDURE GetDate(var JobPlanningLine2: record "Job Planning Line"): Date;
    VAR
        LJob: Record 167;
    BEGIN
        IF JobPlanningLine2."Currency Date" <> 0D THEN
            EXIT(JobPlanningLine2."Currency Date")
        ELSE
            IF JobPlanningLine2."Planning Date" <> 0D THEN
                EXIT(JobPlanningLine2."Planning Date")
            ELSE
                IF LJob.GET(JobPlanningLine2."Job No.") THEN BEGIN
                    IF LJob."Creation Date" <> 0D THEN
                        EXIT(LJob."Creation Date")
                END ELSE
                    EXIT(WORKDATE);
    END;

    [EventSubscriber(ObjectType::Table, 123, 'OnAfterInitFromPurchLine', '', false, false)]
    procedure SMAXPurchLine(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")

    begin
        //gk
        PurchInvLine."Job Planning Line No." := PurchLine."Job Planning Line No.";
        //gk
    end;

    // Filed trigger Validation
    // [EventSubscriber(ObjectType::table, 123, 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    // local procedure MyProcedure2(var Rec: Record "Purch. Inv. Line"; var xRec: Record "Purch. Inv. Line"; CurrFieldNo: Integer)
    // var
    //     myInt: Integer;
    // begin

    // end;
    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeSalesLineInsert', '', false, false)]
    procedure SmaxSalesHeader(VAR SalesLine: Record "Sales Line"; VAR TempSalesLine: Record "Sales Line")
    VAR
        LCustomer: Record Customer;
    begin
        //gk
        IF LCustomer.GET(TempSalesLine."Sell-to Customer No.") THEN begin
            //gk
            SalesLine."Gen. Bus. Posting Group" := LCustomer."Gen. Bus. Posting Group";
            SalesLine."Smax Line No." := TempSalesLine."Smax Line No.";
            //gk
        end;
    end;
}