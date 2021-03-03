codeunit 50100 "IFRS15 Mgt"
{
    trigger OnRun()
    begin

    end;

    VAR
        CannotChangeTheStatusNoPlanningLinesErr: TextConst ENU = 'You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7',
        ENG = 'You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7';
        CannotChaneManuallyError: TextConst ENU = 'You cannot change %1=%2 manually', ENG = 'You cannot change %1=%2 manually';
        TotalRevenueToRecognizeMustBePositiveErr: TextConst ENU = '%1 on %2 must be positive', ENG = '%1 on %2 must be positive';
        NoCalculatedLinesFound: TextConst ENU = 'No %1 with %2=%3 found', ENG = 'No %1 with %2=%3 found';
        AmountIfFullyApportioned: TextConst ENU = 'The amount %1 is fully apportioned', ENG = 'The amount %1 is fully apportioned';
        TotalCostOfLinesToApportionIsBelowZero: TextConst ENU = 'Total Cost of lines to apportion must be greater than zero', ENG = 'Total Cost of lines to apportion must be greater than zero';
        CannotChangeIFRS: TextConst ENU = 'You cannot change the %1 = %2 because there are %3 with %4 <> """""', ENG = 'You cannot change the %1 = %2 because there are %3 with %4 <> """""';

    LOCAL PROCEDURE ">> Subscribers"();
    BEGIN
    END;

    [EventSubscriber(ObjectType::Table, 167, 'OnBeforeInsertEvent', '', false, false)]
    LOCAL PROCEDURE JobOnBeforeInsert(VAR Rec: Record Job; RunTrigger: Boolean);
    VAR
        IFRS15Setup: Record "IFRS15 Setup";
    BEGIN
        // TM TF IFRS15 29/06/18 Start
        IF rec.ISTEMPORARY THEN
            EXIT;
        IFRS15Setup.GET;
        IF IFRS15Setup."IFRS15 Active" THEN
            rec."Is IFRS15 Job" := TRUE;
        // WITH Rec DO BEGIN
        //     IF ISTEMPORARY THEN
        //         EXIT;
        //     IFRS15Setup.GET;
        //     IF IFRS15Setup."IFRS15 Active" THEN
        //         "Is IFRS15 Job" := TRUE;
        // END;
        // TM TF IFRS15 29/06/18 End
    END;

    [EventSubscriber(ObjectType::Table, 167, 'OnAfterValidateEvent', 'Is IFRS15 Job', false, false)]
    LOCAL PROCEDURE JobOnAfterValidateIsIFRS15Job(VAR Rec: Record 167; VAR xRec: Record 167; CurrFieldNo: Integer);
    VAR
        JobTask: Record 1001;
    BEGIN
        // TM TF IFRS15 08/08/18 Start
        //WITH Rec DO BEGIN
        IF CurrFieldNo <> rec.FIELDNO(rec."Is IFRS15 Job") THEN
            EXIT;
        IF rec.ISTEMPORARY THEN
            EXIT;
        IF xRec."Is IFRS15 Job" AND NOT rec."Is IFRS15 Job" THEN BEGIN
            JobTask.SETRANGE("Job No.", rec."No.");
            JobTask.SetFilter("IFRS15 Perf. Obligation Status", '<>%1', JobTask."IFRS15 Perf. Obligation Status"::" ");
            IF NOT JobTask.ISEMPTY THEN
                ERROR(CannotChangeIFRS, rec.FIELDCAPTION(rec."Is IFRS15 Job"), FALSE, JobTask.TABLECAPTION, JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status"));
        END;
        //END;
        // TM TF IFRS15 08/08/18 End
    END;

    [EventSubscriber(ObjectType::Table, 1001, 'OnAfterValidateEvent', 'IFRS15 Perf. Obligation Status', false, false)]
    LOCAL PROCEDURE JobTaskOnAfterValidateIFRS15PerfObligationStatus(VAR Rec: Record 1001; VAR xRec: Record 1001; CurrFieldNo: Integer);
    VAR
        IFRS15Setup: Record 50100;
        JobPlanningLine: Record 1003;
        Job: Record 167;
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        //WITH Rec DO BEGIN
        IFRS15Setup.GET;
        IF NOT IFRS15Setup."IFRS15 Active" THEN
            EXIT;
        IF (rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::Posted) AND NOT rec."IFRS15 Process" THEN
            ERROR(CannotChaneManuallyError, rec.FIELDCAPTION(rec."IFRS15 Perf. Obligation Status"), FORMAT(rec."IFRS15 Perf. Obligation Status"::Posted));

        IF (rec."IFRS15 Perf. Obligation Status" IN [rec."IFRS15 Perf. Obligation Status"::Calculated, rec."IFRS15 Perf. Obligation Status"::"Ready to Post"]) THEN BEGIN
            JobPlanningLine.SETRANGE("Job No.", rec."Job No.");
            JobPlanningLine.SETRANGE("Job Task No.", rec."Job Task No.");
            IF JobPlanningLine.ISEMPTY THEN
                ERROR(CannotChangeTheStatusNoPlanningLinesErr, rec.FIELDCAPTION(rec."IFRS15 Perf. Obligation Status"), FORMAT(rec."IFRS15 Perf. Obligation Status"), JobPlanningLine.TABLECAPTION,
                      rec.FIELDCAPTION(rec."Job No."), rec."Job No.", rec.FIELDCAPTION(rec."Job Task No."), rec."Job Task No.");
        END;
        IF (xRec."IFRS15 Perf. Obligation Status" <> xRec."IFRS15 Perf. Obligation Status"::" ") AND (rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::" ") AND (CurrFieldNo = rec.FIELDNO(rec."IFRS15 Perf. Obligation Status")) THEN BEGIN
            JobPlanningLine.SETRANGE("Job No.", rec."Job No.");
            JobPlanningLine.SETRANGE("Job Task No.", rec."Job Task No.");
            JobPlanningLine.MODIFYALL("IFRS15 Line Amount", 0, FALSE);
        END;

        IFRS15Setup.TESTFIELD("Recognise Revenue Confirm. Msg");
        IF (xRec."IFRS15 Perf. Obligation Status" <> xRec."IFRS15 Perf. Obligation Status"::"Ready to Post") AND
           (rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::"Ready to Post")
        THEN BEGIN
            Job.GET(rec."Job No.");
            Job.TESTFIELD("Is IFRS15 Job");
            JobPlanningLine.SETRANGE("Job No.", rec."Job No.");
            JobPlanningLine.SETRANGE("Job Task No.", rec."Job Task No.");
            JobPlanningLine.SETRANGE(Type, JobPlanningLine.Type::Item);
            JobPlanningLine.SETFILTER("Location Code", '%1', '');
            IF JobPlanningLine.FINDSET THEN
                REPEAT
                    JobPlanningLine.TESTFIELD("Location Code");
                UNTIL JobPlanningLine.NEXT = 0;
            IF NOT CONFIRM(IFRS15Setup."Recognise Revenue Confirm. Msg") THEN
                ERROR('');
        END;
    END;
    // TM TF IFRS15 02/07/18 End
    //END;

    [EventSubscriber(ObjectType::Table, 1003, 'OnBeforeModifyEvent', '', false, false)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeModify(VAR Rec: Record 1003; VAR xRec: Record 1003; RunTrigger: Boolean);
    VAR
        JobTask: Record 1001;
        OldRec: Record 1003;
    BEGIN
        // TM TF IFRS15 03/07/18 Start
        //WITH Rec DO BEGIN
        IF rec.ISTEMPORARY THEN
            EXIT;
        IF NOT RunTrigger THEN
            EXIT;
        OldRec.GET(Rec.RECORDID);
        rec.CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::Posted THEN
            EXIT;
        IF rec."Total Cost" <> OldRec."Total Cost" THEN
            rec."IFRS15 Line Amount" := 0;
        IF rec."IFRS15 Line Amount" = OldRec."IFRS15 Line Amount" THEN
            EXIT;
        IF NOT JobTask.GET(rec."Job No.", rec."Job Task No.") THEN
            EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
    END;
    // TM TF IFRS15 03/07/18 End
    //END;

    [EventSubscriber(ObjectType::Table, 1003, 'OnBeforeDeleteEvent', '', false, false)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeDelete(VAR Rec: Record 1003; RunTrigger: Boolean);
    VAR
        JobTask: Record 1001;
    BEGIN
        // TM TF IFRS15 03/07/18 Start
        //WITH Rec DO BEGIN
        IF rec.ISTEMPORARY THEN
            EXIT;
        IF NOT RunTrigger THEN
            EXIT;
        rec.CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::Posted THEN
            EXIT;
        IF NOT JobTask.GET(rec."Job No.", rec."Job Task No.") THEN
            EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
    END;
    // TM TF IFRS15 03/07/18 End
    //END;

    [EventSubscriber(ObjectType::Table, 1003, 'OnBeforeInsertEvent', '', false, false)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeInsert(VAR Rec: Record 1003; RunTrigger: Boolean);
    VAR
        JobTask: Record 1001;
    BEGIN
        // TM TF IFRS15 03/07/18 Start
        //WITH Rec DO BEGIN
        IF rec.ISTEMPORARY THEN
            EXIT;
        IF NOT RunTrigger THEN
            EXIT;
        rec.CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF rec."IFRS15 Perf. Obligation Status" = rec."IFRS15 Perf. Obligation Status"::Posted THEN
            EXIT;
        IF NOT JobTask.GET(rec."Job No.", rec."Job Task No.") THEN
            EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
    END;
    // TM TF IFRS15 03/07/18 End
    //END;

    LOCAL PROCEDURE ">> Functions"();
    BEGIN
    END;

    PROCEDURE ChangeObligationStatusByPostingRoutine(VAR JobTask: Record 1001);
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        JobTask."IFRS15 Process" := TRUE;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Posted);
        JobTask."IFRS15 Process" := FALSE;
        // TM TF IFRS15 02/07/18 End
    END;

    PROCEDURE ApportionRevenue(VAR vJobTask: Record 1001);
    VAR
        Job: Record 167;
        JobPlanningLine: Record 1003;
        JobTask: Record 1001;
        TotalCost: Decimal;
        RevFactor: Decimal;
        TotalRevenueToRecognize: Decimal;
        TotalIFRS15Amount: Decimal;
        LastJobPlanningRecID: RecordID;
        CalculatedLinesFound: Boolean;
        TotalRevenueToRecognizeLCY: Decimal;
        TotalCostLCY: Decimal;
        TotalIFRS15AmountLCY: Decimal;
        LCYFactor: Decimal;
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        Job.GET(vJobTask."Job No.");
        IF Job."Total Revenue to Recognize" <= 0 THEN
            ERROR(TotalRevenueToRecognizeMustBePositiveErr, Job.FIELDCAPTION("Total Revenue to Recognize"), Job.TABLECAPTION);
        Job.TESTFIELD("Is IFRS15 Job");

        CLEAR(TotalCost);
        CLEAR(RevFactor);
        CLEAR(TotalIFRS15Amount);
        //gk
        CLEAR(TotalCostLCY);
        CLEAR(LCYFactor);
        CLEAR(TotalIFRS15AmountLCY);
        //gk
        TotalRevenueToRecognize := Job."Total Revenue to Recognize";
        //gk
        //Job.CALCFIELDS("Total Rev to Recognize (LCY)");
        //TotalRevenueToRecognizeLCY := Job."Total Rev to Recognize (LCY)";
        //gk
        JobTask.SETRANGE("Job No.", vJobTask."Job No.");
        //gk
        //JobTask.SETAUTOCALCFIELDS("IFRS15 Line Amount", "Total Cost");
        JobTask.SETAUTOCALCFIELDS("IFRS15 Line Amount", "Total Cost", "IFRS15 Line Amount (LCY)", "Total Cost (LCY)");
        //gk
        JobTask.SETFILTER("IFRS15 Perf. Obligation Status", '<>%1', JobTask."IFRS15 Perf. Obligation Status"::" ");
        CLEAR(CalculatedLinesFound);
        IF JobTask.FINDSET THEN
            REPEAT
                IF JobTask."IFRS15 Perf. Obligation Status" IN [JobTask."IFRS15 Perf. Obligation Status"::Posted, JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post"] THEN BEGIN
                    TotalRevenueToRecognize -= JobTask."IFRS15 Line Amount";
                    //gk
                    //TotalRevenueToRecognizeLCY -= JobTask."IFRS15 Line Amount (LCY)";
                    //gk
                END;
                IF JobTask."IFRS15 Perf. Obligation Status" = JobTask."IFRS15 Perf. Obligation Status"::Calculated THEN BEGIN
                    TotalCost += JobTask."Total Cost";
                    //gk
                    //TotalCostLCY += JobTask."Total Cost (LCY)";
                    //gk
                    CalculatedLinesFound := TRUE;
                END;
            UNTIL JobTask.NEXT = 0;
        IF NOT CalculatedLinesFound THEN
            ERROR(NoCalculatedLinesFound, JobTask.TABLECAPTION, JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status"), JobTask."IFRS15 Perf. Obligation Status"::Calculated);

        IF (TotalRevenueToRecognize <= 0) THEN
            ERROR(AmountIfFullyApportioned, Job."Total Revenue to Recognize");

        IF (TotalCost <= 0) THEN
            ERROR(TotalCostOfLinesToApportionIsBelowZero);

        RevFactor := ROUND(TotalRevenueToRecognize / TotalCost, 0.00001);
        //gk
        //LCYFactor := ROUND(TotalRevenueToRecognizeLCY/TotalCostLCY, 0.00001);
        //gk

        //WITH JobPlanningLine DO BEGIN
        JobPlanningLine.SETRANGE("Job No.", JobTask."Job No.");
        JobPlanningLine.SETRANGE("IFRS15 Perf. Obligation Status", JobPlanningLine."IFRS15 Perf. Obligation Status"::Calculated);
        JobPlanningLine.MODIFYALL("IFRS15 Line Amount", 0);
        JobPlanningLine.SETFILTER("Total Cost", '<>0');
        IF JobPlanningLine.FINDLAST THEN
            LastJobPlanningRecID := JobPlanningLine.RECORDID;
        IF JobPlanningLine.FINDSET THEN BEGIN
            REPEAT
                IF JobPlanningLine.RECORDID <> LastJobPlanningRecID THEN BEGIN
                    JobPlanningLine.VALIDATE("IFRS15 Line Amount", ROUND(JobPlanningLine."Total Cost" * RevFactor, 0.01));
                    TotalIFRS15Amount += JobPlanningLine."IFRS15 Line Amount";
                    //gk
                    //VALIDATE("IFRS15 Line Amount (LCY)", ROUND("Total Cost (LCY)"*LCYFactor, 0.01));
                    TotalIFRS15AmountLCY += JobPlanningLine."IFRS15 Line Amount (LCY)";
                    //gk
                END ELSE BEGIN
                    //Last Line
                    JobPlanningLine.VALIDATE("IFRS15 Line Amount", ROUND(TotalRevenueToRecognize - TotalIFRS15Amount, 0.01));
                    //gk
                    //VALIDATE("IFRS15 Line Amount (LCY)", ROUND(TotalRevenueToRecognizeLCY-TotalIFRS15AmountLCY, 0.01));
                    //gk
                END;
                JobPlanningLine.MODIFY;
            UNTIL JobPlanningLine.NEXT = 0;
        END;
        //END;

        // TM TF IFRS15 02/07/18 End
    END;

}
