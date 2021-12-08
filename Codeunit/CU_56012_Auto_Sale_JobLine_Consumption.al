codeunit 56012 "Auto Sale JobLine Consumption"
{
    trigger OnRun()
    begin

    end;

    PROCEDURE PostItemJnlLineJobConsumption(SalesHeader: Record "Sales Header"; VAR SalesLine: Record "Sales Line"; QtyToBeInvoiced: Decimal; ItemShptEntryNo: Integer)
    var
    begin
        //WITH SalesLine DO
        IF SalesLine."Job No." <> '' THEN BEGIN
            IF SalesHeader.Invoice THEN BEGIN
                IF QtyToBeInvoiced <> 0 THEN BEGIN
                    SalesLine."Qty. to Invoice" := QtyToBeInvoiced;
                    PostPositiveItemJournalLine(SalesHeader, SalesLine, ItemShptEntryNo);
                    GJobPlanningLine.RESET;
                    GJobPlanningLine.SETRANGE("Job No.", SalesLine."Job No.");
                    GJobPlanningLine.SETRANGE("Job Task No.", SalesLine."Job Task No.");
                    GJobPlanningLine.SETRANGE("Line No.", SalesLine."Job Planning Line No.");
                    IF GJobPlanningLine.FINDFIRST THEN BEGIN
                        GJobPlanningLine."Qty. to Transfer to Journal" := -QtyToBeInvoiced;
                        GJobPlanningLine."Bin Code" := SalesLine."Bin Code";
                        GJobPlanningLine.MODIFY;
                        FromPlanningLineToJnlLine(GJobPlanningLine, SalesLine);
                    END;
                END;
            END;
        END;
    end;

    PROCEDURE PostPositiveItemJournalLine(LSalesHeader: Record "Sales Header"; LSalesLine: Record "Sales Line"; ItemShipmentEntryNo: Integer)
    var

        ItemJnlLine: Record "Item Journal Line";
        LItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := 'ITEM';
        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
        ItemJnlLine."Line No." := LSalesLine."Line No.";
        ItemJnlLine."Source No." := LSalesLine."Bill-to Customer No.";
        ItemJnlLine."Document No." := LSalesLine."Document No.";//dnvp
        //ItemJnlLine."Document No." := LSalesLine."Job No.";
        ItemJnlLine."Document Line No." := LSalesLine."Line No.";
        ItemJnlLine."Posting Date" := LSalesHeader."Posting Date";
        ItemJnlLine.VALIDATE("Item No.", LSalesLine."No.");
        ItemJnlLine.VALIDATE(Quantity, LSalesLine.Quantity);
        ItemJnlLine."Unit of Measure Code" := LSalesLine."Unit of Measure";
        ItemJnlLine."Location Code" := LSalesLine."Location Code";
        ItemJnlLine."Bin Code" := LSalesLine."Bin Code";//dnvp
        Item.GET(LSalesLine."No.");
        ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        ItemJnlLine.VALIDATE("Shortcut Dimension 1 Code", LSalesLine."Shortcut Dimension 1 Code");
        ItemJnlLine.VALIDATE("Shortcut Dimension 2 Code", LSalesLine."Shortcut Dimension 2 Code");
        ItemJnlLine.VALIDATE("Dimension Set ID", LSalesLine."Dimension Set ID");

        LItemLedgerEntry.RESET;
        LItemLedgerEntry.SETRANGE("Entry No.", ItemShipmentEntryNo);
        IF LItemLedgerEntry.FINDFIRST THEN begin
            ItemJnlLine."Entry/Exit Point" := LItemLedgerEntry."Entry/Exit Point";
            ItemJnlLine."AkkOn-Entry/Exit Date" := LItemLedgerEntry."AkkOn-Entry/Exit Date";
            ItemJnlLine."AkkOn-Entry/Exit No." := LItemLedgerEntry."AkkOn-Entry/Exit No.";
        end;

        IF Item."Item Tracking Code" <> '' THEN
            UpdatePositiveResEntry(ItemJnlLine, LSalesLine, ItemShipmentEntryNo);
        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
    end;

    PROCEDURE UpdatePositiveResEntry(VAR ItemJournalLine: Record "Item Journal Line"; VAR Salesline: Record "Sales Line"; ItemShipmentEntryNo: Integer)
    var
        ReservationEntry: Record "Reservation Entry";
        OldReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
        TrackingSpecification: Record "Tracking Specification";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin


        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Entry No.", ItemShipmentEntryNo);
        IF ItemLedgerEntry.FINDFIRST THEN;

        InitTrackingSpecificationPositive(ItemJournalLine, TrackingSpecification, ItemLedgerEntry);


        IF ReservationEntry.FINDLAST THEN
            EntryNo := ReservationEntry."Entry No." + 1
        ELSE
            EntryNo := 0;

        OldReservationEntry.RESET;
        OldReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        OldReservationEntry.SETRANGE("Source Ref. No.", Salesline."Line No.");
        OldReservationEntry.SETRANGE("Source ID", Salesline."Document No.");
        IF OldReservationEntry.FINDSET THEN
            REPEAT
                ReservationEntry.INIT;
                ReservationEntry."Entry No." := EntryNo;
                EntryNo += 1;
                ReservationEntry.VALIDATE(Positive, TRUE);
                ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
                ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
                ReservationEntry.VALIDATE("Quantity (Base)", OldReservationEntry."Quantity (Base)");
                ReservationEntry.VALIDATE("Qty. per Unit of Measure", OldReservationEntry."Qty. per Unit of Measure");
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Creation Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
                ReservationEntry.VALIDATE("Source Subtype", 1);
                ReservationEntry.VALIDATE("Source ID", ItemJournalLine."Journal Template Name");
                ReservationEntry.VALIDATE("Source Batch Name", ItemJournalLine."Journal Batch Name");
                ReservationEntry.VALIDATE("Source Ref. No.", ItemJournalLine."Line No.");
                ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                ReservationEntry.VALIDATE(Correction, FALSE);
                ReservationEntry.VALIDATE("Lot No.", OldReservationEntry."Lot No.");
                ReservationEntry.VALIDATE("Serial No.", OldReservationEntry."Serial No.");
                ReservationEntry.VALIDATE("Expiration Date", OldReservationEntry."Expiration Date");
                ReservationEntry.INSERT;
                OldReservationEntry.DELETE;
                ItemJournalLine."Document No." := Salesline."Job No.";
            UNTIL OldReservationEntry.NEXT = 0;
    end;

    procedure InitTrackingSpecificationPositive(VAR ItemJnlLine: Record "Item Journal Line";

    VAR TrackingSpecification: Record "Tracking Specification";
        LItemLedgerEntry: Record "Item Ledger Entry")
    var
    begin


        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
        //WITH ItemJnlLine DO BEGIN
        TrackingSpecification."Item No." := ItemJnlLine."Item No.";
        TrackingSpecification."Location Code" := ItemJnlLine."Location Code";
        TrackingSpecification.Description := ItemJnlLine.Description;
        TrackingSpecification."Variant Code" := ItemJnlLine."Variant Code";
        TrackingSpecification.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        TrackingSpecification."Source Subtype" := ItemJnlLine."Entry Type";
        TrackingSpecification."Source ID" := ItemJnlLine."Journal Template Name";
        TrackingSpecification."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := ItemJnlLine."Line No.";
        TrackingSpecification."Quantity (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Qty. to Handle" := ItemJnlLine.Quantity;
        TrackingSpecification."Qty. to Handle (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := ItemJnlLine.Quantity;
        TrackingSpecification."Qty. to Invoice (Base)" := ItemJnlLine."Quantity (Base)";
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
        TrackingSpecification."Serial No." := LItemLedgerEntry."Serial No.";
        TrackingSpecification."Lot No." := LItemLedgerEntry."Lot No.";
        TrackingSpecification."Bin Code" := ItemJnlLine."Bin Code";
        //END;
        CreateReservEntry.SetDates(0D, 0D);
        CreateReservEntry.SetApplyFromEntryNo(0);
        CreateReservEntry.SetApplyToEntryNo(0);
        CreateReservEntry.CreateReservEntryFor(
        TrackingSpecification."Source Type",
        TrackingSpecification."Source Subtype",
        TrackingSpecification."Source ID",
        TrackingSpecification."Source Batch Name",
        TrackingSpecification."Source Prod. Order Line",
        TrackingSpecification."Source Ref. No.",
        TrackingSpecification."Qty. per Unit of Measure",
        0,
        TrackingSpecification."Quantity (Base)",
        TrackingSpecification."Serial No.",
        TrackingSpecification."Lot No.");

        CreateReservEntry.CreateEntry(TrackingSpecification."Item No.",
        TrackingSpecification."Variant Code",
        TrackingSpecification."Location Code",
        TrackingSpecification.Description,
        ItemJnlLine."Posting Date",
        ItemJnlLine."Posting Date", LItemLedgerEntry."Entry No.", 3);
    end;

    procedure FromPlanningLineToJnlLine(JobPlanningLine: Record "Job Planning Line"; LSalesLine: Record "Sales Line")
    var
        JobTask: Record "Job Task";
        JobJnlLine2: Record "Job Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        JobJnlLine: Record "Job Journal Line";
        JobJournalBatch: Record "Job Journal Batch";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
    begin


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
        // IF JobJournalBatch."No. Series" <> '' THEN
        //JobJnlLine."Document No." := NoSeriesMgt.GetNextNo(JobJournalBatch."No. Series", WORKDATE, FALSE)
        //ELSE
        //JobJnlLine."Document No." := JobPlanningLine."Document No.";
        //JobJnlLine."Document No." := LSalesLine."Document No.";
        JobJnlLine."Document No." := JobPlanningLine."Job No.";
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
        //JobJnlLine.VALIDATE("Unit Cost", LSalesLine."Line Amount");
        JobJnlLine.VALIDATE("Unit Price", JobPlanningLine."Unit Price");
        JobJnlLine.VALIDATE("Line Discount %", JobPlanningLine."Line Discount %");
        Item.GET(JobPlanningLine."No.");
        IF Item."Item Tracking Code" <> '' THEN
            UpdateNegativeResEntry(JobJnlLine, LSalesLine);

        JobJnlPostLine.RunWithCheck(JobJnlLine);
    end;

    procedure UpdateNegativeResEntry(VAR JobJournalLine: Record "Job Journal Line"; VAR Salesline: Record "Sales Line")
    var

        ReservationEntry: Record "Reservation Entry";
        OldReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
        TrackingSpecification: Record "Tracking Specification";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin


        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Document No.", Salesline."Document No.");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
        IF ItemLedgerEntry.FINDLAST THEN;

        InitTrackingSpecificationNegative(JobJournalLine, TrackingSpecification, ItemLedgerEntry);


        IF ReservationEntry.FINDLAST THEN
            EntryNo := ReservationEntry."Entry No." + 1
        ELSE
            EntryNo := 0;

        OldReservationEntry.RESET;
        OldReservationEntry.SETRANGE("Source Type", DATABASE::"Job Journal Line");
        OldReservationEntry.SETRANGE("Source Ref. No.", Salesline."Line No.");
        OldReservationEntry.SETRANGE("Source ID", Salesline."Document No.");
        IF OldReservationEntry.FINDSET THEN
            REPEAT
                ReservationEntry.INIT;
                ReservationEntry."Entry No." := EntryNo;
                EntryNo += 1;
                ReservationEntry.VALIDATE(Positive, FALSE);
                ReservationEntry.VALIDATE("Item No.", JobJournalLine."No.");
                ReservationEntry.VALIDATE("Location Code", JobJournalLine."Location Code");
                ReservationEntry.VALIDATE("Quantity (Base)", OldReservationEntry."Quantity (Base)");
                ReservationEntry.VALIDATE("Qty. per Unit of Measure", OldReservationEntry."Qty. per Unit of Measure");
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Creation Date", JobJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Source Type", DATABASE::"Job Journal Line");
                ReservationEntry.VALIDATE("Source Subtype", 1);
                ReservationEntry.VALIDATE("Source ID", JobJournalLine."Journal Template Name");
                ReservationEntry.VALIDATE("Source Batch Name", JobJournalLine."Journal Batch Name");
                ReservationEntry.VALIDATE("Source Ref. No.", JobJournalLine."Line No.");
                ReservationEntry.VALIDATE("Shipment Date", JobJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                ReservationEntry.VALIDATE(Correction, FALSE);
                ReservationEntry.VALIDATE("Lot No.", OldReservationEntry."Lot No.");
                ReservationEntry.VALIDATE("Serial No.", OldReservationEntry."Serial No.");
                ReservationEntry.VALIDATE("Expiration Date", OldReservationEntry."Expiration Date");
                ReservationEntry.INSERT;
                OldReservationEntry.DELETE;
            UNTIL OldReservationEntry.NEXT = 0;
    end;

    procedure InitTrackingSpecificationNegative(VAR JobJournalLine: Record "Job Journal Line"; VAR TrackingSpecification: Record "Tracking Specification"; LItemLedgerEntry: Record "Item Ledger Entry")
    var
    begin


        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Job Journal Line";
        //WITH JobJournalLine DO BEGIN
        TrackingSpecification."Item No." := JobJournalLine."No.";
        TrackingSpecification."Location Code" := JobJournalLine."Location Code";
        TrackingSpecification.Description := JobJournalLine.Description;
        TrackingSpecification."Variant Code" := JobJournalLine."Variant Code";
        TrackingSpecification.VALIDATE("Source Type", DATABASE::"Job Journal Line");
        TrackingSpecification."Source Subtype" := JobJournalLine."Entry Type";
        TrackingSpecification."Source ID" := JobJournalLine."Journal Template Name";
        TrackingSpecification."Source Batch Name" := JobJournalLine."Journal Batch Name";
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := JobJournalLine."Line No.";
        TrackingSpecification."Quantity (Base)" := JobJournalLine."Quantity (Base)";
        TrackingSpecification."Qty. to Handle" := JobJournalLine.Quantity;
        TrackingSpecification."Qty. to Handle (Base)" := JobJournalLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := JobJournalLine.Quantity;
        TrackingSpecification."Qty. to Invoice (Base)" := JobJournalLine."Quantity (Base)";
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := JobJournalLine."Qty. per Unit of Measure";
        TrackingSpecification."Serial No." := LItemLedgerEntry."Serial No.";
        TrackingSpecification."Lot No." := LItemLedgerEntry."Lot No.";
        TrackingSpecification."Bin Code" := JobJournalLine."Bin Code";
        //END;
        CreateReservEntry.SetDates(0D, 0D);
        CreateReservEntry.SetApplyFromEntryNo(0);
        CreateReservEntry.SetApplyToEntryNo(0);
        CreateReservEntry.CreateReservEntryFor(
        TrackingSpecification."Source Type",
        TrackingSpecification."Source Subtype",
        TrackingSpecification."Source ID",
        TrackingSpecification."Source Batch Name",
        TrackingSpecification."Source Prod. Order Line",
        TrackingSpecification."Source Ref. No.",
        TrackingSpecification."Qty. per Unit of Measure",
        0,
        TrackingSpecification."Quantity (Base)",
        TrackingSpecification."Serial No.",
        TrackingSpecification."Lot No.");

        CreateReservEntry.CreateEntry(TrackingSpecification."Item No.",
        TrackingSpecification."Variant Code",
        TrackingSpecification."Location Code",
        TrackingSpecification.Description,
        JobJournalLine."Posting Date",
        JobJournalLine."Posting Date", LItemLedgerEntry."Entry No.", 3);

    end;

    var
        Job: Record Job;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        GJobPlanningLine: Record "Job Planning Line";
        Item: Record Item;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
}