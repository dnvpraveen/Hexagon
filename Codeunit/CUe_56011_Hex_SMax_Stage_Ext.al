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

    PROCEDURE GetDate(var JobPlanningLine2: record "Job Planning Line"): Date;
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

    /// <summary>
    /// Thsi code is from ArchiveManagement
    /// </summary>
    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterSalesHeaderArchiveInsert', '', false, false)]
    procedure SmaxStoreSalesDocument(VAR SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header")
    VAR
        RecordLinkManagement: Codeunit 447;
        LSalesHeader: Record 36;
        LSalesLine: Record 37;
        SalesHeaderArchiveACK: Record 55015;
        SalesLineArchiveACK: Record 55016;
    begin
        //for smax
        LSalesHeader.RESET;
        LSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        LSalesHeader.SETRANGE("No.", SalesHeader."No.");
        LSalesHeader.SETRANGE("Order Created", TRUE);
        IF LSalesHeader.FINDFIRST THEN BEGIN
            SalesHeaderArchiveACK.INIT;
            SalesHeaderArchiveACK.TRANSFERFIELDS(LSalesHeader);
            SalesHeaderArchiveACK."Archived By" := USERID;
            SalesHeaderArchiveACK."Date Archived" := WORKDATE;
            SalesHeaderArchiveACK."Time Archived" := TIME;
            SalesHeaderArchiveACK."Version No." := ArchiveMgt.GetNextVersionNo(
                DATABASE::"Sales Header", LSalesHeader."Document Type", LSalesHeader."No.", LSalesHeader."Doc. No. Occurrence");
            SalesHeaderArchiveACK."Interaction Exist" := SalesHeaderArchive."Interaction Exist";
            RecordLinkManagement.CopyLinks(LSalesHeader, SalesHeaderArchiveACK);
            SalesHeaderArchiveACK.INSERT;
        END;
        //for smax
    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterStoreSalesDocument', '', false, false)]
    procedure SmaxStoreSalesDocument2(VAR SalesHeader: Record "Sales Header"; VAR SalesHeaderArchive: Record "Sales Header Archive")
    VAR
        RecordLinkManagement: Codeunit 447;
        LSalesHeader: Record 36;
        LSalesLine: Record 37;
        SalesHeaderArchiveACK: Record 55015;
        SalesLineArchiveACK: Record 55016;
        DeferralUtilities: Codeunit "Deferral Utilities";
    begin
        //for smax
        LSalesLine.RESET;
        LSalesLine.SETRANGE("Document Type", LSalesHeader."Document Type");
        LSalesLine.SETRANGE("Document No.", LSalesHeader."No.");
        IF LSalesLine.FINDSET THEN
            REPEAT

                SalesLineArchiveACK.INIT;
                SalesLineArchiveACK.TRANSFERFIELDS(LSalesLine);
                SalesLineArchiveACK."Doc. No. Occurrence" := LSalesHeader."Doc. No. Occurrence";
                SalesLineArchiveACK."Version No." := SalesHeaderArchiveACK."Version No.";
                SalesLineArchiveACK."Smax Line No." := LSalesLine."Smax Line No.";
                RecordLinkManagement.CopyLinks(LSalesLine, SalesLineArchiveACK);
                SalesLineArchiveACK.INSERT;

                IF LSalesLine."Deferral Code" <> '' THEN
                    StoreDeferrals(DeferralUtilities.GetSalesDeferralDocType, LSalesLine."Document Type",
                      LSalesLine."Document No.", LSalesLine."Line No.", LSalesHeader."Doc. No. Occurrence", SalesHeaderArchiveACK."Version No.");

            UNTIL LSalesLine.NEXT = 0;

        //for smax
    end;

    PROCEDURE "--Hex1.0---Codeunit 5063 ArchiveManagement"();
    BEGIN
    END;

    PROCEDURE ArchivePurchDocumentdirect(VAR PurchHeader: Record 38);
    var
        Text001: TextConst ENU = 'Document %1 has been archived.', PTB = 'O documento %1 foi arquivado.';
    BEGIN
        ArchiveMgt.StorePurchDocument(PurchHeader, FALSE);
        MESSAGE(Text001, PurchHeader."No.");
    END;

    PROCEDURE ArchiveSalesDocumentdirect(VAR SalesHeader: Record 36);
    var
        Text001: TextConst ENU = 'Document %1 has been archived.', PTB = 'O documento %1 foi arquivado.';
    BEGIN
        ArchiveMgt.StoreSalesDocument(SalesHeader, FALSE);
        MESSAGE(Text001, SalesHeader."No.");
    END;

    PROCEDURE ArchiveSalesDocument1(VAR SalesHeader: Record 36);
    var
        Text001: TextConst ENU = 'Document %1 has been archived.', PTB = 'O documento %1 foi arquivado.';
        Text007: TextConst ENU = 'Archive %1 no.: %2?', PTB = 'Arquivo %1 n�: %2?';
    BEGIN
        IF CONFIRM(
             Text007, TRUE, SalesHeader."Document Type",
             SalesHeader."No.")
        THEN BEGIN
            StoreSalesDocument1(SalesHeader, FALSE);
            MESSAGE(Text001, SalesHeader."No.");
        END;
    END;

    PROCEDURE StoreSalesDocument1(VAR SalesHeader: Record 36; InteractionExist: Boolean);
    VAR
        SalesLine: Record 37;
        SalesHeaderArchive: Record 5107;
        SalesLineArchive: Record 5108;
        RecordLinkManagement: Codeunit 447;
        LSalesHeader: Record 36;
        LSalesLine: Record 37;
        SalesHeaderArchiveACK: Record 55015;
        SalesLineArchiveACK: Record 55016;
        DeferralUtilities: Codeunit "Deferral Utilities";
    BEGIN
        SalesHeaderArchive.INIT;
        SalesHeaderArchive.TRANSFERFIELDS(SalesHeader);
        SalesHeaderArchive."Archived By" := USERID;
        SalesHeaderArchive."Date Archived" := WORKDATE;
        SalesHeaderArchive."Time Archived" := TIME;
        SalesHeaderArchive."Version No." := ArchiveMgt.GetNextVersionNo(
            DATABASE::"Sales Header", SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Doc. No. Occurrence");
        SalesHeaderArchive."Interaction Exist" := InteractionExist;
        RecordLinkManagement.CopyLinks(SalesHeader, SalesHeaderArchive);
        SalesHeaderArchive.INSERT;

        //for smax
        LSalesHeader.RESET;
        LSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        LSalesHeader.SETRANGE("No.", SalesHeader."No.");
        LSalesHeader.SETRANGE("Order Created", TRUE);
        IF LSalesHeader.FINDFIRST THEN BEGIN
            SalesHeaderArchiveACK.INIT;
            SalesHeaderArchiveACK.TRANSFERFIELDS(LSalesHeader);
            SalesHeaderArchiveACK."Archived By" := USERID;
            SalesHeaderArchiveACK."Date Archived" := WORKDATE;
            SalesHeaderArchiveACK."Time Archived" := TIME;
            //SalesHeaderArchiveACK."Cancel / ShortClose" := TRUE;
            SalesHeaderArchiveACK."Version No." := ArchiveMgt.GetNextVersionNo(
                DATABASE::"Sales Header", LSalesHeader."Document Type", LSalesHeader."No.", LSalesHeader."Doc. No. Occurrence");
            SalesHeaderArchiveACK."Interaction Exist" := InteractionExist;
            RecordLinkManagement.CopyLinks(LSalesHeader, SalesHeaderArchiveACK);
            SalesHeaderArchiveACK.INSERT;
        END;
        //for smax

        StoreSalesDocumentComments(
           SalesHeader."Document Type", SalesHeader."No.",
           SalesHeader."Doc. No. Occurrence", SalesHeaderArchive."Version No.");

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FINDSET THEN
            REPEAT

                SalesLineArchive.INIT;
                SalesLineArchive.TRANSFERFIELDS(SalesLine);
                SalesLineArchive.Quantity := SalesLine."Quantity Invoiced";
                SalesLineArchive."Quantity (Base)" := SalesLine."Quantity Invoiced";
                SalesLineArchive."Doc. No. Occurrence" := SalesHeader."Doc. No. Occurrence";
                SalesLineArchive."Version No." := SalesHeaderArchive."Version No.";
                RecordLinkManagement.CopyLinks(SalesLine, SalesLineArchive);
                SalesLineArchive.INSERT;

                // WITH SalesLineArchive DO BEGIN
                //     INIT;
                //     TRANSFERFIELDS(SalesLine);
                //     SalesLineArchive.Quantity := SalesLine."Quantity Invoiced";
                //     SalesLineArchive."Quantity (Base)" := SalesLine."Quantity Invoiced";
                //     "Doc. No. Occurrence" := SalesHeader."Doc. No. Occurrence";
                //     "Version No." := SalesHeaderArchive."Version No.";
                //     RecordLinkManagement.CopyLinks(SalesLine, SalesLineArchive);
                //     INSERT;
                // END;
                IF SalesLine."Deferral Code" <> '' THEN
                    StoreDeferrals(DeferralUtilities.GetSalesDeferralDocType, SalesLine."Document Type",
                      SalesLine."Document No.", SalesLine."Line No.", SalesHeader."Doc. No. Occurrence", SalesHeaderArchive."Version No.");

            UNTIL SalesLine.NEXT = 0;

        //for smax
        LSalesLine.RESET;
        LSalesLine.SETRANGE("Document Type", LSalesHeader."Document Type");
        LSalesLine.SETRANGE("Document No.", LSalesHeader."No.");
        IF LSalesLine.FINDSET THEN
            REPEAT
                SalesLineArchiveACK.INIT;
                SalesLineArchiveACK.TRANSFERFIELDS(LSalesLine);
                SalesLineArchiveACK."Doc. No. Occurrence" := LSalesHeader."Doc. No. Occurrence";
                SalesLineArchiveACK."Version No." := SalesHeaderArchiveACK."Version No.";
                SalesLineArchiveACK."Smax Line No." := LSalesLine."Smax Line No.";
                SalesLineArchiveACK.Quantity := LSalesLine."Quantity Invoiced";
                SalesLineArchiveACK."Quantity (Base)" := LSalesLine."Quantity Invoiced";
                RecordLinkManagement.CopyLinks(LSalesLine, SalesLineArchiveACK);
                SalesLineArchiveACK.INSERT;
                // WITH SalesLineArchiveACK DO BEGIN
                //     INIT;
                //     TRANSFERFIELDS(LSalesLine);
                //     "Doc. No. Occurrence" := LSalesHeader."Doc. No. Occurrence";
                //     "Version No." := SalesHeaderArchiveACK."Version No.";
                //     "Smax Line No." := LSalesLine."Smax Line No.";
                //     SalesLineArchiveACK.Quantity := LSalesLine."Quantity Invoiced";
                //     SalesLineArchiveACK."Quantity (Base)" := LSalesLine."Quantity Invoiced";
                //     RecordLinkManagement.CopyLinks(LSalesLine, SalesLineArchiveACK);
                //     INSERT;
                //      END;
                IF LSalesLine."Deferral Code" <> '' THEN
                    StoreDeferrals(DeferralUtilities.GetSalesDeferralDocType, LSalesLine."Document Type",
                      LSalesLine."Document No.", LSalesLine."Line No.", LSalesHeader."Doc. No. Occurrence", SalesHeaderArchiveACK."Version No.");

            UNTIL LSalesLine.NEXT = 0;

        //for smax
    END;

    PROCEDURE ArchiveSalesDocument2(VAR SalesHeader: Record 36);
    BEGIN
        StoreSalesDocument1(SalesHeader, FALSE);
    END;

    LOCAL PROCEDURE StoreSalesDocumentComments(DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; VersionNo: Integer);
    VAR
        SalesCommentLine: Record 44;
        SalesCommentLineArch: Record 5126;
    BEGIN
        SalesCommentLine.SETRANGE("Document Type", DocType);
        SalesCommentLine.SETRANGE("No.", DocNo);
        IF SalesCommentLine.FINDSET THEN
            REPEAT
                SalesCommentLineArch.INIT;
                SalesCommentLineArch.TRANSFERFIELDS(SalesCommentLine);
                SalesCommentLineArch."Doc. No. Occurrence" := DocNoOccurrence;
                SalesCommentLineArch."Version No." := VersionNo;
                SalesCommentLineArch.INSERT;
            UNTIL SalesCommentLine.NEXT = 0;
    END;

    LOCAL PROCEDURE StoreDeferrals(DeferralDocType: Integer; DocType: Integer; DocNo: Code[20]; LineNo: Integer; DocNoOccurrence: Integer; VersionNo: Integer);
    VAR
        DeferralHeaderArchive: Record 5127;
        DeferralLineArchive: Record 5128;
        DeferralHeader: Record 1701;
        DeferralLine: Record 1702;
    BEGIN
        IF DeferralHeader.GET(DeferralDocType, '', '', DocType, DocNo, LineNo) THEN BEGIN
            DeferralHeaderArchive.INIT;
            DeferralHeaderArchive.TRANSFERFIELDS(DeferralHeader);
            DeferralHeaderArchive."Doc. No. Occurrence" := DocNoOccurrence;
            DeferralHeaderArchive."Version No." := VersionNo;
            DeferralHeaderArchive.INSERT;

            DeferralLine.SETRANGE("Deferral Doc. Type", DeferralDocType);
            DeferralLine.SETRANGE("Gen. Jnl. Template Name", '');
            DeferralLine.SETRANGE("Gen. Jnl. Batch Name", '');
            DeferralLine.SETRANGE("Document Type", DocType);
            DeferralLine.SETRANGE("Document No.", DocNo);
            DeferralLine.SETRANGE("Line No.", LineNo);
            IF DeferralLine.FINDSET THEN
                REPEAT
                    DeferralLineArchive.INIT;
                    DeferralLineArchive.TRANSFERFIELDS(DeferralLine);
                    DeferralLineArchive."Doc. No. Occurrence" := DocNoOccurrence;
                    DeferralLineArchive."Version No." := VersionNo;
                    DeferralLineArchive.INSERT;
                UNTIL DeferralLine.NEXT = 0;
        END;
    END;
    //Add new function hear for SMAX  Sales Header TB36

    PROCEDURE "-------Hex-Sales Order table 36---"();
    BEGIN
    END;

    PROCEDURE CancelOrder(Var SalesHeader: Record "Sales Header");
    VAR
        OrderStatusValue: Text[50];
        SalesLine: record "Sales Line";
        Text001: TextConst ENU = 'Do you want to Cancel the Order No. %1';
        Text052: TextConst ENU = 'You cananot Cancel the order,You have to Short Close the order for Line No. %1 and Item No. %2';
        Text051: TextConst ENU = 'You cannot Canel/Short Close the order,Project is pending for this Order';
    BEGIN
        IF CONFIRM(Text001, FALSE, SalesHeader."No.") THEN BEGIN
            OrderStatusValue := 'Cancel';
            IF OrderStatusValue = 'Cancel' THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        IF SalesLine."Quantity Shipped" > 0 THEN
                            ERROR(Text052, SalesLine."Line No.", SalesLine."No.");
                    UNTIL SalesLine.NEXT = 0;
            END;
            //CancelCloseOrder(OrderStatusValue, SalesHeader);
        END;
    END;

    PROCEDURE ShortCloseOrder(Var SalesHeader: Record "Sales Header");
    VAR
        OrderStatusValue: Text[50];
        SalesLine: record "Sales Line";
        Text001: TextConst ENU = 'Do you want to Short Close the Order No. %1';
        Text051: TextConst ENU = 'You cananot Close  the order,You have to Cancel the order for Line No. %1and Item No. %2';
        Text052: TextConst ENU = 'You cannot Canel/Short Close the order,Project is pending for this Order';
    BEGIN
        IF CONFIRM(Text001, FALSE, SalesHeader."No.") THEN BEGIN
            OrderStatusValue := 'Close';

            IF OrderStatusValue = 'Close' THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        IF SalesLine."Quantity Shipped" = 0 THEN
                            ERROR(Text051, SalesLine."Line No.", SalesLine."No.");
                    UNTIL SalesLine.NEXT = 0;
            END;

            //CancelCloseOrder(OrderStatusValue,SalesHeader);
        END;
    END;

    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR SalesHeader: Record 36);
    VAR
        CancelShortClose: Text[50];
        SalesLine: Record 37;
        SalesShipLine: Record 111;
        Text050: TextConst ENU = 'Invoice is pending for Line No. %1 and Item No. %2, still want to Short Close the order?';
        //ArchiveManagement : Codeunit 5063;
        NoShipment: Boolean;
    BEGIN
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesShipLine.INIT;
                SalesShipLine.SETRANGE(SalesShipLine."Order No.", SalesLine."Document No.");
                SalesShipLine.SETRANGE(SalesShipLine."Order Line No.", SalesLine."Line No.");
                IF SalesShipLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF SalesShipLine."Qty. Shipped Not Invoiced" <> 0 THEN
                            NoShipment := TRUE;
                    //ERROR(Text050,SalesShipLine."Order Line No.",SalesShipLine."No.");
                    UNTIL SalesShipLine.NEXT = 0;
                END;
            UNTIL SalesLine.NEXT = 0;
        END;

        IF NOT NoShipment THEN BEGIN
            IF CONFIRM(Text050, FALSE, SalesShipLine."Order Line No.", SalesShipLine."No.") THEN BEGIN
                IF OrderStatus = 'Close' THEN BEGIN
                    SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
                    SalesHeader.MODIFY;
                    ArchiveSalesDocument1(SalesHeader);
                END;
            END ELSE
                EXIT;
        END ELSE BEGIN
            IF OrderStatus = 'Close' THEN BEGIN
                SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
                SalesHeader.MODIFY;
                ArchiveSalesDocument1(SalesHeader);
            END;
        END;

        IF OrderStatus = 'Cancel' THEN BEGIN
            SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::Cancelled;
            SalesHeader.MODIFY;
            ArchiveMgt.ArchiveSalesDocument(SalesHeader);
        END;

        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesLine.DELETE;
            UNTIL SalesLine.NEXT = 0;
        END;
        SalesHeader.DELETE;
    END;


    // Stage Payment line Table 56021 code 
    //JOB table 167 Functions

    PROCEDURE gfcnGetShortcutDimNo(pcodDimCode: Code[20]) rintDimNo: Integer
    // SC 01-10-13
    var
        lintI: Integer;
    begin

        GetGLSetup;
        REPEAT
            lintI += 1;
            IF pcodDimCode = GLSetupShortcutDimCode[lintI] THEN
                rintDimNo := lintI;
        UNTIL (rintDimNo <> 0) OR (lintI = 8);

    end;

    procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        IF NOT HasGotGLSetup THEN BEGIN
            GLSetup.GET;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := TRUE;
        END;
    end;

    var
        ArchiveMgt: Codeunit ArchiveManagement;
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: ARRAY[8] OF Code[20];

}