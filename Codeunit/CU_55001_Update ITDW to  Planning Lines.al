codeunit 55001 "Update ITDW to  Planning Lines"
{
    VAR
        GSalesHeader: Record 36;

    trigger OnRun()
    begin
        UpdatePlanningLines;
        OrderInsertedfromSMAX;

        GSalesHeader.RESET;
        GSalesHeader.SETRANGE("Action Code", 4);
        IF GSalesHeader.FINDSET THEN BEGIN
            REPEAT
                CancelOrder(GSalesHeader);
            UNTIL GSalesHeader.NEXT = 0;
        END;

        GSalesHeader.RESET;
        GSalesHeader.SETRANGE("Action Code", 5);
        IF GSalesHeader.FINDSET THEN BEGIN
            REPEAT
                ShortCloseOrder(GSalesHeader);
            UNTIL GSalesHeader.NEXT = 0;
        END;

    end;




    PROCEDURE UpdatePlanningLines();
    VAR
        ITDWProformaRecords: Record 55014;
        JobPlanningLine: Record 1003;
    BEGIN
        ITDWProformaRecords.RESET;
        ITDWProformaRecords.SETRANGE("Invoice Inserted", FALSE);
        ITDWProformaRecords.SETRANGE("Integration Completed", FALSE);
        IF ITDWProformaRecords.FINDSET THEN BEGIN
            REPEAT
                IF JobPlanningLine.GET(ITDWProformaRecords."Job No.", ITDWProformaRecords."Job Task No.",
                                          ITDWProformaRecords."Line No.") THEN BEGIN
                    JobPlanningLine.VALIDATE("Qty. to Transfer to Journal", ITDWProformaRecords."Qty to Invoice");
                    //JobPlanningLine.VALIDATE("Currency Code",ITDWProformaRecords."Currency Code");
                    JobPlanningLine.VALIDATE("Unit Price", ITDWProformaRecords."Unit Price");
                    JobPlanningLine."Smax Order No." := ITDWProformaRecords."Smax Order No.";
                    JobPlanningLine."Smax Order for IP" := ITDWProformaRecords."Smax Order for IP";
                    JobPlanningLine."Smax Line No" := ITDWProformaRecords."Smax Line No";
                    JobPlanningLine."IP Serial No." := ITDWProformaRecords."IP Code";
                    JobPlanningLine."IP Code" := ITDWProformaRecords."IP Serial No.";
                    JobPlanningLine.MODIFY;
                    FromPlanningLineToJnlLine(JobPlanningLine);
                END;
                ITDWProformaRecords."Invoice Inserted" := TRUE;
                ITDWProformaRecords."Integration Completed" := TRUE;
                ITDWProformaRecords.MODIFY;
            UNTIL ITDWProformaRecords.NEXT = 0;
        END;
    END;

    PROCEDURE OrderInsertedfromSMAX();
    VAR
        SalesHeader: Record 36;
        TransferHeader: Record 5740;
        LSalesLine: Record 37;
        LTransferLine: Record 5741;
    BEGIN
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Order Created", TRUE);
        SalesHeader.SETRANGE("Order Inserted", FALSE);
        IF SalesHeader.FINDSET THEN BEGIN
            REPEAT
                LSalesLine.RESET;
                LSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                LSalesLine.SETRANGE("Document No.", SalesHeader."No.");
                IF LSalesLine.FINDSET THEN BEGIN
                    REPEAT
                        LSalesLine."Order Inserted" := TRUE;
                        LSalesLine.MODIFY;
                    UNTIL LSalesLine.NEXT = 0;
                    SalesHeader."Order Inserted" := TRUE;
                    SalesHeader.MODIFY;
                END;
            UNTIL SalesHeader.NEXT = 0;
        END;

        TransferHeader.RESET;
        TransferHeader.SETRANGE("Order Created", TRUE);
        TransferHeader.SETRANGE("Order Inserted", FALSE);
        IF TransferHeader.FINDSET THEN BEGIN
            REPEAT
                LTransferLine.RESET;
                LTransferLine.SETRANGE("Document No.", TransferHeader."No.");
                IF LTransferLine.FINDSET THEN BEGIN
                    REPEAT
                        LTransferLine."Order Inserted" := TRUE;
                        LTransferLine.MODIFY;
                    UNTIL LTransferLine.NEXT = 0;
                    TransferHeader."Order Inserted" := TRUE;
                    TransferHeader.MODIFY;
                END;
            UNTIL TransferHeader.NEXT = 0;
        END;
    END;

    PROCEDURE CancelOrder(SalesHeader: Record 36);
    VAR
        OrderStatusValue: Text[50];
        Text001: TextConst ENU = 'Do you want to Cancel the Order No. %1';
        Text052: TextConst ENU = 'You cananot Cancel the order,You have to Short Close the order for Line No. %1 and Item No. %2';
        Text051: TextConst ENU = 'You cannot Canel/Short Close the order,Project is pending for this Order';
        SalesLine: Record 37;
    BEGIN
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
        CancelCloseOrder(OrderStatusValue, SalesHeader);
    END;

    PROCEDURE ShortCloseOrder(SalesHeader: Record 36);
    VAR
        OrderStatusValue: Text[50];
        Text001: TextConst ENU = 'Do you want to Short Close the Order No. %1';
        Text051: TextConst ENU = 'You cananot Close  the order,You have to Cancel the order for Line No. %1and Item No. %2';
        Text052: TextConst ENU = 'You cannot Canel/Short Close the order,Project is pending for this Order';
    BEGIN
        OrderStatusValue := 'Close';
        CancelCloseOrder(OrderStatusValue, SalesHeader);
    END;

    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR SalesHeader: Record 36);
    VAR
        CancelShortClose: Text[50];
        SalesLine: Record 37;
        SalesShipLine: Record 111;
        Text050: TextConst ENU = 'Invoice is pending for Line No. %1 and Item No. %2, still want to Short Close the order?';
        ArchiveManagement: Codeunit ArchiveManagement;
        HexSMAXarch: Codeunit "Hex Smax Stage Ext";
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
                    UNTIL SalesShipLine.NEXT = 0;
                END;
            UNTIL SalesLine.NEXT = 0;
        END;

        IF NOT NoShipment THEN BEGIN
            //IF CONFIRM(Text050,FALSE,SalesShipLine."Order Line No.",SalesShipLine."No.") THEN BEGIN
            IF OrderStatus = 'Close' THEN BEGIN
                SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
                SalesHeader.MODIFY;
                HexSMAXarch.ArchiveSalesDocument2(SalesHeader);
            END;
            //END ELSE
            //EXIT;
        END ELSE BEGIN
            IF OrderStatus = 'Close' THEN BEGIN
                SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
                SalesHeader.MODIFY;
                HexSMAXarch.ArchiveSalesDocument2(SalesHeader);
            END;
        END;

        IF OrderStatus = 'Cancel' THEN BEGIN
            SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::Cancelled;
            SalesHeader.MODIFY;
            ArchiveManagement.ArchiveSalesDocument(SalesHeader);
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

    PROCEDURE FromPlanningLineToJnlLine(JobPlanningLine: Record 1003);
    VAR
        JobTask: Record 1001;
        JobJnlLine2: Record 210;
        NoSeriesMgt: Codeunit 396;
        ItemTrackingMgt: Codeunit 6500;
        JobJnlLine: Record 210;
        JobJournalBatch: Record 237;
        JobJnlPostLine: Codeunit 1012;
    BEGIN
        JobPlanningLine.TESTFIELD("Qty. to Transfer to Journal");

        JobJnlLine.INIT;
        JobJnlLine.VALIDATE("Journal Template Name", 'Job');
        JobJnlLine.VALIDATE("Journal Batch Name", 'Default');
        JobJnlLine2.SETRANGE("Journal Template Name", 'Job');
        JobJnlLine2.SETRANGE("Journal Batch Name", 'Default');
        IF JobJnlLine2.FINDLAST THEN
            JobJnlLine.VALIDATE("Line No.", JobJnlLine2."Line No." + 10000)
        ELSE
            JobJnlLine.VALIDATE("Line No.", 10000);

        JobJnlLine.VALIDATE("Job No.", JobPlanningLine."Job No.");
        JobJnlLine."Job Task No." := JobPlanningLine."Job Task No.";

        IF JobPlanningLine."Usage Link" THEN BEGIN
            JobJnlLine."Job Planning Line No." := JobPlanningLine."Line No.";
            JobJnlLine."Line Type" := JobPlanningLine."Line Type" + 1;
        END;

        JobTask.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        JobJnlLine."Posting Group" := JobTask."Job Posting Group";
        JobJnlLine."Posting Date" := WORKDATE;
        JobJnlLine."Document Date" := WORKDATE;
        JobJournalBatch.GET(JobJnlLine."Journal Template Name", JobJnlLine."Journal Batch Name");
        IF JobJournalBatch."No. Series" <> '' THEN
            JobJnlLine."Document No." := NoSeriesMgt.GetNextNo(JobJournalBatch."No. Series", WORKDATE, FALSE)
        ELSE
            JobJnlLine."Document No." := JobPlanningLine."Document No.";

        JobJnlLine.Type := JobPlanningLine.Type;
        JobJnlLine."No." := JobPlanningLine."No.";
        JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
        JobJnlLine."Gen. Bus. Posting Group" := JobPlanningLine."Gen. Bus. Posting Group";
        JobJnlLine."Gen. Prod. Posting Group" := JobPlanningLine."Gen. Prod. Posting Group";
        JobJnlLine."Serial No." := JobPlanningLine."Serial No.";
        JobJnlLine."Lot No." := JobPlanningLine."Lot No.";
        JobJnlLine.Description := JobPlanningLine.Description;
        JobJnlLine."Description 2" := JobPlanningLine."Description 2";
        JobJnlLine.VALIDATE("Unit of Measure Code", JobPlanningLine."Unit of Measure Code");
        JobJnlLine."Currency Code" := JobPlanningLine."Currency Code";
        JobJnlLine."Currency Factor" := JobPlanningLine."Currency Factor";
        JobJnlLine."Resource Group No." := JobPlanningLine."Resource Group No.";
        JobJnlLine."Location Code" := JobPlanningLine."Location Code";
        JobJnlLine."Work Type Code" := JobPlanningLine."Work Type Code";
        JobJnlLine."Customer Price Group" := JobPlanningLine."Customer Price Group";
        JobJnlLine."Variant Code" := JobPlanningLine."Variant Code";
        JobJnlLine."Bin Code" := JobPlanningLine."Bin Code";
        JobJnlLine."Service Order No." := JobPlanningLine."Service Order No.";
        JobJnlLine."Country/Region Code" := JobPlanningLine."Country/Region Code";
        JobJnlLine.VALIDATE(Quantity, JobPlanningLine."Qty. to Transfer to Journal");
        JobJnlLine.VALIDATE("Qty. per Unit of Measure", JobPlanningLine."Qty. per Unit of Measure");
        JobJnlLine."Direct Unit Cost (LCY)" := JobPlanningLine."Direct Unit Cost (LCY)";
        JobJnlLine.VALIDATE("Unit Cost", JobPlanningLine."Unit Cost");
        JobJnlLine.VALIDATE("Unit Price", JobPlanningLine."Unit Price");
        JobJnlLine.VALIDATE("Line Discount %", JobPlanningLine."Line Discount %");
        ItemTrackingMgt.CopyItemTracking(JobPlanningLine.RowID1, JobJnlLine.RowID1, FALSE);
        JobJnlPostLine.RunWithCheck(JobJnlLine);
    END;


}

