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
        GLSetup: record "General Ledger Setup";
    begin

        GetGLSetup;
        //GLSetup.Get();
        //GLSetupShortcutDimCode[10] := GLSetup."Shortcut Dimension 10 Code";//DNVP
        REPEAT
            lintI += 1;
            IF pcodDimCode = GLSetupShortcutDimCode[lintI] THEN
                rintDimNo := lintI;
        UNTIL (rintDimNo <> 0) OR (lintI = 20);

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
            GLSetupShortcutDimCode[10] := GLSetup."Shortcut Dimension 10 Code";//DNVP
            HasGotGLSetup := TRUE;
        END;
    end;

    //Job page function

    PROCEDURE gfncCreateSalesDoc(var HexJob: record job; poptDocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order");
    VAR
        lrecGlSetup: Record 98;
        lrecJobSetup: Record 315;
        lrecSalesHeader: Record 36;
        Text50000: Label '%1 No. %2 created';
        lrecJobOrderLink: Record 50000;
        lrecDimValue: Record 349;
        lrecDimSetEntry: Record 480;
        lintLineNo: Integer;
        OldDimSetID: Integer;
        i: Integer;
        LrecSalesLine: Record 37;
        LrecJobTaskLine: Record 1001;
        LrecJobPlanningLine: Record 1003;
        JobTaskDimension: Record 1002;
        RecordLinkManagement: Codeunit 447;
        HexText: label 'Hexagon System Defined Option. Please contact NAV Admin';
        GText001: label 'Sales Order already exists.   Do you want to create new Sales Order?';
        GText010: label 'Do you Want to create Sales Lines With Text?';
        Text001: label 'JOB Status should be Order';
    BEGIN
        //HEXGBJOB.01 <<
        //KB 17.09.13 - new function

        //>>DPM 10.02.14 Job Status check before Sales order creation
        //IF Status <> Status::Order THEN
        IF HexJob.Status <> HexJob.Status::Open THEN//HEXB2B
            ERROR(Text001);
        //<<DPM 10.02.14
        //SE HEX Bug Fix
        lrecJobOrderLink.RESET;
        lrecJobOrderLink.SETRANGE("Job No.", HexJob."No.");
        lrecJobOrderLink.SETRANGE("Invoice No.", '');
        IF lrecJobOrderLink.FIND('-') THEN BEGIN
            IF NOT CONFIRM(GText001, FALSE) THEN
                EXIT;
        END;
        //SE HEX Bug Fix
        //create sales order or credit memo
        lrecSalesHeader.INIT;
        lrecSalesHeader."Document Type" := poptDocType;
        // TM TF IFRS15 04/07/18 Start
        lrecSalesHeader."Assigned Job No." := HexJob."No.";
        // TM TF IFRS15 04/07/18 End
        lrecSalesHeader."No." := '';
        lrecSalesHeader.INSERT(TRUE);
        lrecSalesHeader.VALIDATE("Sell-to Customer No.", HexJob."Bill-to Customer No.");
        lrecSalesHeader."Job No." := HexJob."No.";
        lrecSalesHeader."Sell-to Contact" := HexJob."Bill-to Contact";
        lrecSalesHeader."External Document No." := HexJob."External Doc No.";
        lrecSalesHeader."Assigned User ID" := USERID;
        //gk
        lrecSalesHeader.VALIDATE("Shortcut Dimension 1 Code", HexJob."Global Dimension 1 Code");
        lrecSalesHeader.VALIDATE("Shortcut Dimension 2 Code", HexJob."Global Dimension 2 Code");

        lrecGlSetup.GET;
        GLSetupShortcutDimCode[1] := lrecGlSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := lrecGlSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := lrecGlSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := lrecGlSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := lrecGlSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := lrecGlSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := lrecGlSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := lrecGlSetup."Shortcut Dimension 8 Code";

        FOR i := 1 TO 8 DO BEGIN
            JobTaskDimension.RESET;
            JobTaskDimension.SETRANGE("Job No.", HexJob."No.");
            JobTaskDimension.SETRANGE("Dimension Code", GLSetupShortcutDimCode[i]);
            IF JobTaskDimension.FINDFIRST THEN
                lrecSalesHeader.ValidateShortcutDimCode(i, JobTaskDimension."Dimension Value Code");
        END;

        //gk
        //MAN 2013-11-08>>
        lrecSalesHeader.MODIFY;
        //HEX JOB Task line and planning lines to copy in sales line

        IF CONFIRM(GText010, FALSE) THEN BEGIN
            lintLineNo := 0;
            LrecJobTaskLine.RESET;
            LrecJobTaskLine.SETCURRENTKEY("Job No.", "Job Task No.");
            LrecJobTaskLine.SETFILTER(LrecJobTaskLine."Job No.", HexJob."No.");
            IF LrecJobTaskLine.FIND('-') THEN
                REPEAT
                    lintLineNo := lintLineNo + 10000;
                    LrecSalesLine.INIT;
                    LrecSalesLine."Document Type" := poptDocType;
                    LrecSalesLine."Document No." := lrecSalesHeader."No.";
                    LrecSalesLine."Line No." := lintLineNo;
                    LrecSalesLine.Type := 0;
                    LrecSalesLine.Description := LrecJobTaskLine.Description;
                    LrecSalesLine.INSERT(TRUE);

                    LrecJobPlanningLine.RESET;
                    LrecJobPlanningLine.SETCURRENTKEY("Job No.", "Job Task No.", "Line No.");
                    LrecJobPlanningLine.SETFILTER(LrecJobPlanningLine."Job No.", HexJob."No.");
                    LrecJobPlanningLine.SETFILTER(LrecJobPlanningLine."Job Task No.", LrecJobTaskLine."Job Task No.");
                    IF LrecJobPlanningLine.FIND('-') THEN
                        REPEAT
                            lintLineNo := lintLineNo + 10000;
                            LrecSalesLine.INIT;
                            LrecSalesLine."Document Type" := poptDocType;
                            LrecSalesLine."Document No." := lrecSalesHeader."No.";
                            LrecSalesLine."Line No." := lintLineNo;
                            LrecSalesLine.Type := 0;
                            LrecSalesLine.Description := LrecJobPlanningLine.Description;
                            LrecSalesLine.INSERT(TRUE);

                        UNTIL LrecJobPlanningLine.NEXT <= 0;
                UNTIL LrecJobTaskLine.NEXT <= 0;
        END;

        //HEX JOB Task line and planning lines to copy in sales line
        MESSAGE(Text50000, FORMAT(lrecSalesHeader."Document Type"), lrecSalesHeader."No.");

        //create Job Order Link
        lrecJobOrderLink.RESET;
        lrecJobOrderLink.SETRANGE("Job No.", HexJob."No.");     //from Job rec
        IF lrecJobOrderLink.FINDLAST THEN
            lintLineNo := lrecJobOrderLink."Line No." + 10000
        ELSE
            lintLineNo := 10000;
        lrecJobOrderLink.INIT;
        lrecJobOrderLink."Job No." := HexJob."No.";     //from Job rec
        lrecJobOrderLink."Line No." := lintLineNo;
        lrecJobOrderLink."Sales Doc. Type" := poptDocType;
        lrecJobOrderLink."Order No." := lrecSalesHeader."No.";
        //lrecJobOrderLink."Invoice Doc. Type" := 2;           //set to invoice MAN Removed
        lrecJobOrderLink."Invoice Doc. Type" := poptDocType;   //Changed Line Above
        lrecJobOrderLink.INSERT;
        RecordLinkManagement.CopyLinks(HexJob, lrecSalesHeader);

        // SC 17-12-13 >>
        IF poptDocType = poptDocType::Order THEN
            PAGE.RUN(42, lrecSalesHeader);

        IF poptDocType = poptDocType::"Credit Memo" THEN
            PAGE.RUN(44, lrecSalesHeader);
        // SC 17-12-13 <<
        //HEXGBJOB.01 >>
    END;

    procedure gfncCreateSalesDocGopal(var HexJob: record job; poptDocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order");
    var
        lrecGlSetup: Record 98;
        lrecJobSetup: Record 315;
        lrecSalesHeader: Record 36;
        Text50000: Label '%1 No. %2 created';
        lrecJobOrderLink: Record 50000;
        lrecDimValue: Record 349;
        lrecDimSetEntry: Record 480;
        lintLineNo: Integer;
        OldDimSetID: Integer;
        i: Integer;
        LrecSalesLine: Record 37;
        LrecJobTaskLine: Record 1001;
        LrecJobPlanningLine: Record 1003;
        JobTaskDimension: Record 1002;
        RecordLinkManagement: Codeunit 447;
        HexText: label 'Hexagon System Defined Option. Please contact NAV Admin';
        GText001: label 'Sales Order already exists.   Do you want to create new Sales Order?';
        GText010: label 'Do you Want to create Sales Lines With Text?';
        Text001: label 'JOB Status should be Order';
    begin
        IF HexJob.Status <> HexJob.Status::Open THEN//HEXB2B
            ERROR(Text001);

        lrecJobOrderLink.RESET;
        lrecJobOrderLink.SETRANGE("Job No.", HexJob."No.");
        lrecJobOrderLink.SETRANGE("Invoice No.", '');
        IF lrecJobOrderLink.FIND('-') THEN BEGIN
            IF NOT CONFIRM(GText001, FALSE) THEN
                EXIT;
        END;

        lrecSalesHeader.INIT;
        lrecSalesHeader."Document Type" := poptDocType;
        lrecSalesHeader."Assigned Job No." := HexJob."No.";
        lrecSalesHeader."No." := '';
        lrecSalesHeader.INSERT(TRUE);
        lrecSalesHeader.VALIDATE("Sell-to Customer No.", HexJob."Bill-to Customer No.");
        lrecSalesHeader.VALIDATE("Currency Code", HexJob."Currency Code");
        lrecSalesHeader."Job No." := HexJob."No.";
        lrecSalesHeader.VALIDATE("Shortcut Dimension 1 Code", HexJob."Global Dimension 1 Code");
        lrecSalesHeader.VALIDATE("Shortcut Dimension 2 Code", HexJob."Global Dimension 2 Code");

        lrecGlSetup.GET;
        GLSetupShortcutDimCode[1] := lrecGlSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := lrecGlSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := lrecGlSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := lrecGlSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := lrecGlSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := lrecGlSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := lrecGlSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := lrecGlSetup."Shortcut Dimension 8 Code";

        FOR i := 1 TO 8 DO BEGIN
            JobTaskDimension.RESET;
            JobTaskDimension.SETRANGE("Job No.", HexJob."No.");
            JobTaskDimension.SETRANGE("Dimension Code", GLSetupShortcutDimCode[i]);
            IF JobTaskDimension.FINDFIRST THEN
                lrecSalesHeader.ValidateShortcutDimCode(i, JobTaskDimension."Dimension Value Code");
        END;
        lrecSalesHeader.MODIFY;

        lintLineNo := 0;
        LrecJobPlanningLine.RESET;
        LrecJobPlanningLine.SETCURRENTKEY("Job No.", "Job Task No.", "Line No.");
        LrecJobPlanningLine.SETFILTER(LrecJobPlanningLine."Job No.", HexJob."No.");
        LrecJobPlanningLine.SETFILTER(LrecJobPlanningLine."Job Task No.", LrecJobTaskLine."Job Task No.");
        LrecJobPlanningLine.SETRANGE(IP, TRUE);
        IF LrecJobPlanningLine.FIND('-') THEN BEGIN
            REPEAT
                lintLineNo := lintLineNo + 10000;
                LrecSalesLine.INIT;
                LrecSalesLine."Document Type" := poptDocType;
                LrecSalesLine."Document No." := lrecSalesHeader."No.";
                LrecSalesLine."Line No." := lintLineNo;
                LrecSalesLine.VALIDATE(Type, LrecSalesLine.Type::Item);
                LrecSalesLine.VALIDATE("No.", LrecJobPlanningLine."No.");
                LrecSalesLine.VALIDATE(Quantity, LrecJobPlanningLine.Quantity);
                LrecSalesLine.VALIDATE("Unit Cost", LrecJobPlanningLine."Unit Cost");
                LrecSalesLine.Description := LrecJobPlanningLine.Description;
                LrecSalesLine."Job No." := LrecJobPlanningLine."Job No.";
                LrecSalesLine."Job Task No." := LrecJobPlanningLine."Job Task No.";
                LrecSalesLine."Job Planning Line No." := LrecJobPlanningLine."Line No.";
                LrecSalesLine.INSERT(TRUE);

            UNTIL LrecJobPlanningLine.NEXT <= 0;
        END;

        MESSAGE(Text50000, FORMAT(lrecSalesHeader."Document Type"), lrecSalesHeader."No.");

        //create Job Order Link
        lrecJobOrderLink.RESET;
        lrecJobOrderLink.SETRANGE("Job No.", HexJob."No.");     //from Job rec
        IF lrecJobOrderLink.FINDLAST THEN
            lintLineNo := lrecJobOrderLink."Line No." + 10000
        ELSE
            lintLineNo := 10000;
        lrecJobOrderLink.INIT;
        lrecJobOrderLink."Job No." := HexJob."No.";
        lrecJobOrderLink."Line No." := lintLineNo;
        lrecJobOrderLink."Sales Doc. Type" := poptDocType;
        lrecJobOrderLink."Order No." := lrecSalesHeader."No.";
        lrecJobOrderLink."Invoice Doc. Type" := poptDocType;
        lrecJobOrderLink.INSERT;

        IF poptDocType = poptDocType::Order THEN
            PAGE.RUN(42, lrecSalesHeader);

        IF poptDocType = poptDocType::"Credit Memo" THEN
            PAGE.RUN(44, lrecSalesHeader);
    end;
    //Codeunit 333 Req. Wksh.-Make Order
    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterInitPurchOrderLine', '', false, false)]
    procedure "Hex InitPurchOrderLine Ext"(VAR PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    var
        PurchOrderHeader: Record "Purchase Header";
    begin
        //gk
        IF RequisitionLine."Demand Type" = 1003 THEN BEGIN
            PurchaseLine."Job No." := RequisitionLine."Demand Order No.";
            PurchaseLine."Job Task No." := RequisitionLine."Job Task No.";
            PurchaseLine."Job Planning Line No." := RequisitionLine."Job Planning Line No.";
            IF PurchOrderHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN BEGIN
                PurchaseLine."Job Currency Factor" := PurchOrderHeader."Currency Factor";
                PurchaseLine."Job Currency Code" := PurchOrderHeader."Currency Code";
            end;
        end;
        //gk
    end;

    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterInsertPurchOrderHeader', '', false, false)]
    procedure "Hex OnAfterInsertPurchOrderHeader Ext"(VAR RequisitionLine: Record "Requisition Line"; VAR PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean)
    var
        lrecJobOrderLink: Record "Job Order Link";
        lintLineNo: Integer;
        lrecJobSetup: Record "Jobs Setup";
        DimensionManagement: Codeunit DimensionManagement;
    //PurchOrderHeader: Record "Purchase Header";
    begin
        //gk
        lrecJobSetup.GET;
        lrecJobSetup.TESTFIELD("Dimension for Sales Link");
        PurchaseOrderHeader.ValidateShortcutDimCode(gfcnGetShortcutDimNo(lrecJobSetup."Dimension for Sales Link"), RequisitionLine."Demand Order No.");
        PurchaseOrderHeader."Job No." := RequisitionLine."Demand Order No.";
        //gk
        //create Job Order Link
        lrecJobOrderLink.RESET;
        lrecJobOrderLink.SETRANGE("Job No.", PurchaseOrderHeader."Job No.");     //from Job rec
        IF lrecJobOrderLink.FINDLAST THEN
            lintLineNo := lrecJobOrderLink."Line No." + 10000
        ELSE
            lintLineNo := 10000;
        lrecJobOrderLink.INIT;
        lrecJobOrderLink."Job No." := PurchaseOrderHeader."Job No.";
        lrecJobOrderLink."Line No." := lintLineNo;
        lrecJobOrderLink."Purch Doc. Type" := PurchaseOrderHeader."Document Type"::Order;
        lrecJobOrderLink."Purch Order No." := PurchaseOrderHeader."No.";
        lrecJobOrderLink.INSERT;

        IF lrecJobOrderLink."Purch Doc. Type" = PurchaseOrderHeader."Document Type"::Order THEN
            PAGE.RUN(50, PurchaseOrderHeader);
        //gk
    end;
    //hex Requisition Line code
    [EventSubscriber(ObjectType::Table, 246, 'OnAfterTransferFromUnplannedDemand', '', false, false)]
    procedure "Hex OnAfterTransferFromUnplannedDemand Ext"(VAR RequisitionLine: Record "Requisition Line"; UnplannedDemand: Record "Unplanned Demand")
    var
    begin
        //gk
        RequisitionLine."Job Task No." := UnplannedDemand."Job Task No.";
        RequisitionLine."Job Planning Line No." := UnplannedDemand."Job Planning Line No.";
        //gk
    end;

    // Codeunit 90 Purch.-Post
    //OnPostItemJnlLineJobConsumption
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostItemJnlLineJobConsumption', '', false, false)]
    procedure "Hex OnPostItemJnlLineJobConsumption Ext"(VAR IsHandled: Boolean)
    var
        JobsSetup: Record "Jobs Setup";
    begin
        //gk
        JobsSetup.GET;
        IF NOT JobsSetup."Auto Consume" THEN  //gk code modified
            IsHandled := TRUE;                                     //gk

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforeRevertWarehouseEntry', '', false, false)]
    procedure "Hex OnBeforeRevertWarehouseEntry Ext"(VAR IsHandled: Boolean)
    var
        JobsSetup: Record "Jobs Setup";
    begin
        //gk
        JobsSetup.GET;
        IF NOT JobsSetup."Auto Consume" THEN  //gk code modified
            IsHandled := TRUE;                                     //gk

    end;

    //Codeunit 5520 Get Unplanned Demand
    // Codeunit 12 Gen. Jnl.-Post Line
    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitGLEntry', '', false, false)]
    // procedure "Hex OnBeforeInitGLEntry Ext"(VAR GenJournalLine : Record "Gen. Journal Line")
    // var
    // begin
    //     //gk
    //     //gk
    // end;
    //Codeunit 80 Sales-Post

    [EventSubscriber(ObjectType::Table, 5744, 'OnAfterCopyFromTransferHeader', '', false, false)]
    procedure "Hex CopyFromTransferHeader"(VAR TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    var
        JobsSetup: Record "Jobs Setup";
    begin
        //gk
        //HEX  SMAX Code
        TransferShipmentHeader."Sell-to Customer No." := TransferHeader."Sell-to Customer No.";
        TransferShipmentHeader."Sell-to Customer Name" := TransferHeader."Sell-to Customer Name";
        TransferShipmentHeader."Order Created" := TransferHeader."Order Created";
        TransferShipmentHeader."Order Inserted" := TransferHeader."Order Inserted";
        TransferShipmentHeader."Order Type" := TransferHeader."Order Type";
        TransferShipmentHeader."Smax Order No." := TransferHeader."Smax Order No.";
        TransferShipmentHeader."Parts Order No." := TransferHeader."Parts Order No.";
        TransferShipmentHeader."Target System" := TransferHeader."Target System";
        TransferShipmentHeader."Header Status" := TransferHeader."Header Status"::Shipped;
        // HEX END
        //gk

    end;

    [EventSubscriber(ObjectType::Table, 5745, 'OnAfterCopyFromTransferLine', '', false, false)]
    procedure "Hex COnAfterCopyFromTransferLine"(VAR TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    var
        JobsSetup: Record "Jobs Setup";
    begin
        //gk
        // HEX SMAX Code
        TransferShipmentLine."Smax Line No." := TransferLine."Smax Line No.";
        TransferShipmentLine."Action Code" := TransferLine."Action Code";
        //IF TransferLine."Qty. to Ship" <> TransferLine."Qty. to Ship (Base)" THEN
        if TransferLine.Quantity <> TransferLine."Qty. to Ship" then
            TransferShipmentLine."Line Status" := TransferLine."Line Status"::"Partially shipped"
        ELSE
            TransferShipmentLine."Line Status" := TransferLine."Line Status"::Shipped;
        TransferShipmentLine."Order Created" := TRUE;
        TransferShipmentLine."Order Dispatched" := TRUE;
        // HEX END;
        //gk

    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnRunOnBeforeCommit', '', false, false)]
    procedure "Hex OnRunOnBeforeCommit"(VAR TransferHeader: Record "Transfer Header"; TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        LTransferShipmentHeader: Record "Transfer Shipment Header";
        LTransferShipmentLine: Record "Transfer Shipment Line";
    begin
        //gk
        IF LTransferShipmentHeader.GET(TransferShipmentHeader."No.") THEN BEGIN
            LTransferShipmentLine.RESET;
            LTransferShipmentLine.SETRANGE("Document No.", LTransferShipmentHeader."No.");
            LTransferShipmentLine.SETFILTER("Line Status", '<>%1', LTransferShipmentLine."Line Status"::Shipped);
            IF LTransferShipmentLine.FINDFIRST THEN BEGIN
                LTransferShipmentHeader."Header Status" := LTransferShipmentHeader."Header Status"::"Partially shipped";
                LTransferShipmentHeader.MODIFY;
            END ELSE BEGIN
                LTransferShipmentHeader."Header Status" := LTransferShipmentHeader."Header Status"::Shipped;
                LTransferShipmentHeader.MODIFY
            END;
        END;
        //gk

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    procedure "Hex OnBeforePostSalesDoc"(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; VAR HideProgressWindow: Boolean)
    begin
        //gk
        // HEX SMAX
        // NewPreviewMode := PreviewMode;
        // Message('Mode1 %1 looks', format(NewPreviewMode));
        SalesHeader.Preview := PreviewMode;
        SalesHeader.Modify();
        // HEX SMAX
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', false, false)]
    procedure "Hex OnAfterSalesInvLineInsert"(VAR SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; VAR SalesHeader: Record "Sales Header"; VAR TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)")
    var
        UpdateJobRecords: Codeunit "Update Job Records";
        Test80: Codeunit "sales-post";
    begin
        //gk
        // HEX SMAX
        //Error('finding');
        IF NOT SalesHeader.Preview THEN begin
            UpdateJobRecords.UpdateBillingInvoiceDetails(SalesInvHeader, SalesInvLine);
            // HEX SMAX
        end;
    END;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptHeaderInsert', '', false, false)]
    procedure "Hex OnAfterSalesShptHeaderInsert"(VAR SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean)
    var
        UpdateJobRecords: Codeunit "Update Job Records";
    begin
        //gk
        // HEX SMAX
        //Error('finding');
        //gk
        UpdateJobRecords.UpdateShipmentDetails(SalesShipmentHeader);
        //gk
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', false, false)]
    procedure "Hex OnAfterSalesInvHeaderInsert"(VAR SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        UpdateJobRecords: Codeunit "Update Job Records";
    begin
        //gk
        // HEX SMAX
        //gk
        UpdateJobRecords.UpdateInvoiceDetails(SalesInvHeader);
        //gk
    END;


    [EventSubscriber(ObjectType::Codeunit, 1012, 'OnAfterApplyUsageLink', '', false, false)]
    procedure "Hex OnAfterApplyUsageLink"(VAR JobLedgerEntry: Record "Job Ledger Entry")
    var
        UpdateJobRecords: Codeunit "Update Job Records";
    begin
        //gk
        // HEX SMAX
        //gk
        UpdateJobRecords.UpdateSerialNo(JobLedgerEntry);
        //gk
        // HEX SMAX
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostItemJnlLine', '', false, false)]
    procedure "Hex OnAfterPostItemJnlLine"(VAR ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; VAR ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        AutoSaleJobLineConsumption: Codeunit "Auto Sale JobLine Consumption";
    begin
        //gk
        // HEX SMAX

        //IF (SalesLine.Type = SalesLine.Type::Item) AND SalesHeader.Invoice THEN
        //  PostItemJnlLineItemCharges(SalesHeader,SalesLine,OriginalItemJnlLine,"Item Shpt. Entry No.");
        // base code commented by gk
        // new code added gk
        //IF (SalesLine.Type = SalesLine.Type::Item) AND SalesHeader.Invoice THEN BEGIN
        //PostItemJnlLineItemCharges(SalesHeader, SalesLine, OriginalItemJnlLine, "Item Shpt. Entry No.");
        IF SalesLine."Job No." <> '' THEN
            AutoSaleJobLineConsumption.PostItemJnlLineJobConsumption(SalesHeader, SalesLine, salesline."Qty. to Invoice (Base)", ItemJournalLine."Item Shpt. Entry No.");
        //END;
        // new code end gk
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeTestSalesLineJob', '', false, false)]
    procedure "Hex OnBeforeTestSalesLineJob"(SalesLine: Record "Sales Line"; VAR SkipTestJobNo: Boolean)
    var
        HexSalesHeader: record "Sales Header";
    begin
        //gk
        //gk
        //IF SalesHeader."Job No." = '' THEN //gk
        // IF NOT ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) THEN
        //TESTFIELD("Job No.",'');
        // new code end gk
        //  IF HexSalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
        //    IF HexSalesHeader."Job No." = '' THEN
        SkipTestJobNo := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnPostSalesLineOnBeforeTestJobNo', '', false, false)]
    procedure "Hex OnPostSalesLineOnBeforeTestJobNo"(SalesLine: Record "Sales Line"; VAR IsHandled: Boolean)
    var
        HexSalesHeader: record "Sales Header";
    begin
        //gk
        //gk
        //IF SalesHeader."Job No." = '' THEN //gk
        // IF NOT ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) THEN
        //TESTFIELD("Job No.",'');
        // new code end gk
        //  IF HexSalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
        //    IF HexSalesHeader."Job No." = '' THEN
        IsHandled := true;
    end;

    // CUstom2 DIM

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeUpdateAllLineDim', '', false, false)]
    procedure "Hex OnBeforeUpdateAllLineDim"(VAR SalesHeader: Record "Sales Header"; NewParentDimSetID: Integer; OldParentDimSetID: Integer; VAR IsHandled: Boolean)
    var
    begin
        IsHandled := true;
        Message('Beta MX testing for default Dim');
    end;


    var
        ArchiveMgt: Codeunit ArchiveManagement;
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: ARRAY[20] OF Code[20];
        CUdebug: codeunit "Sales-Post";
        NewPreviewMode: Boolean;

}