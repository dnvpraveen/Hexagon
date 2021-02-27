codeunit 50100 "IFRS15 Mgt"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}



OBJECT Codeunit 50100 IFRS15 Mgt
{
  OBJECT-PROPERTIES
  {
    Date=15-10-18;
    Time=12:00:00 PM;
    Modified=Yes;
    Version List=IFRS15;
  }
  PROPERTIES
  {
    OnRun=BEGIN
          END;

  }
  CODE
  {
    VAR
      CannotChangeTheStatusNoPlanningLinesErr@1000000000 : TextConst 'ENU="You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7";ENG="You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7"';
      CannotChaneManuallyError@1000000001 : TextConst 'ENU="You cannot change %1=%2 manually";ENG="You cannot change %1=%2 manually"';
      TotalRevenueToRecognizeMustBePositiveErr@1000 : TextConst 'ENU=%1 on %2 must be positive;ENG=%1 on %2 must be positive';
      NoCalculatedLinesFound@1001 : TextConst 'ENU="No %1 with %2=%3 found";ENG="No %1 with %2=%3 found"';
      AmountIfFullyApportioned@1002 : TextConst 'ENU=The amount %1 is fully apportioned;ENG=The amount %1 is fully apportioned';
      TotalCostOfLinesToApportionIsBelowZero@1003 : TextConst 'ENU=Total Cost of lines to apportion must be greater than zero;ENG=Total Cost of lines to apportion must be greater than zero';
      CannotChangeIFRS@1004 : TextConst 'ENU="You cannot change the %1 = %2 because there are %3 with %4 <> """"";ENG="You cannot change the %1 = %2 because there are %3 with %4 <> """""';

    LOCAL PROCEDURE ">> Subscribers"@1000000000();
    BEGIN
    END;

    [EventSubscriber(Table,167,OnBeforeInsertEvent)]
    LOCAL PROCEDURE JobOnBeforeInsert@1000000001(VAR Rec@1000000000 : Record 167;RunTrigger@1000000001 : Boolean);
    VAR
      IFRS15Setup@1000000002 : Record 50100;
    BEGIN
      // TM TF IFRS15 29/06/18 Start
      WITH Rec DO BEGIN
        IF ISTEMPORARY THEN
          EXIT;
        IFRS15Setup.GET;
        IF IFRS15Setup."IFRS15 Active" THEN
          "Is IFRS15 Job" := TRUE;
      END;
      // TM TF IFRS15 29/06/18 End
    END;

    [EventSubscriber(Table,167,OnAfterValidateEvent,"Is IFRS15 Job")]
    LOCAL PROCEDURE JobOnAfterValidateIsIFRS15Job@1(VAR Rec@1000 : Record 167;VAR xRec@1001 : Record 167;CurrFieldNo@1002 : Integer);
    VAR
      JobTask@1003 : Record 1001;
    BEGIN
      // TM TF IFRS15 08/08/18 Start
      WITH Rec DO BEGIN
        IF CurrFieldNo <> FIELDNO("Is IFRS15 Job") THEN
          EXIT;
        IF ISTEMPORARY THEN
          EXIT;
        IF xRec."Is IFRS15 Job" AND NOT "Is IFRS15 Job" THEN BEGIN
          JobTask.SETRANGE("Job No.", "No.");
          JobTask.SETFILTER("IFRS15 Perf. Obligation Status", '<>%1', JobTask."IFRS15 Perf. Obligation Status"::" ");
          IF NOT JobTask.ISEMPTY THEN
            ERROR(CannotChangeIFRS, FIELDCAPTION("Is IFRS15 Job"), FALSE, JobTask.TABLECAPTION, JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status"));
        END;
      END;
      // TM TF IFRS15 08/08/18 End
    END;

    [EventSubscriber(Table,1001,OnAfterValidateEvent,"IFRS15 Perf. Obligation Status")]
    LOCAL PROCEDURE JobTaskOnAfterValidateIFRS15PerfObligationStatus@1000000002(VAR Rec@1000000000 : Record 1001;VAR xRec@1000000001 : Record 1001;CurrFieldNo@1000000002 : Integer);
    VAR
      IFRS15Setup@1000000003 : Record 50100;
      JobPlanningLine@1000000004 : Record 1003;
      Job@1000 : Record 167;
    BEGIN
      // TM TF IFRS15 02/07/18 Start
      WITH Rec DO BEGIN
        IFRS15Setup.GET;
        IF NOT IFRS15Setup."IFRS15 Active" THEN
          EXIT;
        IF ("IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::Posted) AND NOT "IFRS15 Process" THEN
          ERROR(CannotChaneManuallyError, FIELDCAPTION("IFRS15 Perf. Obligation Status"), FORMAT("IFRS15 Perf. Obligation Status"::Posted));

        IF ("IFRS15 Perf. Obligation Status" IN ["IFRS15 Perf. Obligation Status"::Calculated, "IFRS15 Perf. Obligation Status"::"Ready to Post"]) THEN BEGIN
          JobPlanningLine.SETRANGE("Job No.", "Job No.");
          JobPlanningLine.SETRANGE("Job Task No.", "Job Task No.");
          IF JobPlanningLine.ISEMPTY THEN
            ERROR(CannotChangeTheStatusNoPlanningLinesErr, FIELDCAPTION("IFRS15 Perf. Obligation Status"), FORMAT("IFRS15 Perf. Obligation Status"), JobPlanningLine.TABLECAPTION,
                  FIELDCAPTION("Job No."), "Job No.", FIELDCAPTION("Job Task No."), "Job Task No.");
        END;
        IF (xRec."IFRS15 Perf. Obligation Status" <> xRec."IFRS15 Perf. Obligation Status"::" ") AND ("IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::" ") AND (CurrFieldNo = FIELDNO("IFRS15 Perf. Obligation Status")) THEN BEGIN
          JobPlanningLine.SETRANGE("Job No.", "Job No.");
          JobPlanningLine.SETRANGE("Job Task No.", "Job Task No.");
          JobPlanningLine.MODIFYALL("IFRS15 Line Amount", 0, FALSE);
        END;

        IFRS15Setup.TESTFIELD("Recognise Revenue Confirm. Msg");
        IF (xRec."IFRS15 Perf. Obligation Status" <> xRec."IFRS15 Perf. Obligation Status"::"Ready to Post") AND
           ("IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::"Ready to Post")
        THEN BEGIN
          Job.GET("Job No.");
          Job.TESTFIELD("Is IFRS15 Job");
          JobPlanningLine.SETRANGE("Job No.", "Job No.");
          JobPlanningLine.SETRANGE("Job Task No.", "Job Task No.");
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
    END;

    [EventSubscriber(Table,1003,OnBeforeModifyEvent)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeModify@1000000011(VAR Rec@1000000000 : Record 1003;VAR xRec@1000000001 : Record 1003;RunTrigger@1000000002 : Boolean);
    VAR
      JobTask@1000000003 : Record 1001;
      OldRec@1000000004 : Record 1003;
    BEGIN
      // TM TF IFRS15 03/07/18 Start
      WITH Rec DO BEGIN
        IF ISTEMPORARY THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        OldRec.GET(Rec.RECORDID);
        CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF "IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::Posted THEN
          EXIT;
        IF "Total Cost" <> OldRec."Total Cost" THEN
          "IFRS15 Line Amount" := 0;
        IF "IFRS15 Line Amount" = OldRec."IFRS15 Line Amount" THEN
          EXIT;
        IF NOT JobTask.GET("Job No.", "Job Task No.") THEN
          EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
      END;
      // TM TF IFRS15 03/07/18 End
    END;

    [EventSubscriber(Table,1003,OnBeforeDeleteEvent)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeDelete@5(VAR Rec@1000 : Record 1003;RunTrigger@1001 : Boolean);
    VAR
      JobTask@1000000003 : Record 1001;
    BEGIN
      // TM TF IFRS15 03/07/18 Start
      WITH Rec DO BEGIN
        IF ISTEMPORARY THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF "IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::Posted THEN
          EXIT;
        IF NOT JobTask.GET("Job No.", "Job Task No.") THEN
          EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
      END;
      // TM TF IFRS15 03/07/18 End
    END;

    [EventSubscriber(Table,1003,OnBeforeInsertEvent)]
    LOCAL PROCEDURE JobPlanningLineOnBeforeInsert@6(VAR Rec@1000 : Record 1003;RunTrigger@1001 : Boolean);
    VAR
      JobTask@1000000003 : Record 1001;
    BEGIN
      // TM TF IFRS15 03/07/18 Start
      WITH Rec DO BEGIN
        IF ISTEMPORARY THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        CALCFIELDS("IFRS15 Perf. Obligation Status");
        IF "IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::Posted THEN
          EXIT;
        IF NOT JobTask.GET("Job No.", "Job Task No.") THEN
          EXIT;
        JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
        JobTask.MODIFY(TRUE);
      END;
      // TM TF IFRS15 03/07/18 End
    END;

    LOCAL PROCEDURE ">> Functions"@1000000003();
    BEGIN
    END;

    PROCEDURE ChangeObligationStatusByPostingRoutine@1000000004(VAR JobTask@1000000000 : Record 1001);
    BEGIN
      // TM TF IFRS15 02/07/18 Start
      JobTask."IFRS15 Process" := TRUE;
      JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Posted);
      JobTask."IFRS15 Process" := FALSE;
      // TM TF IFRS15 02/07/18 End
    END;

    PROCEDURE ApportionRevenue@1000000005(VAR vJobTask@1000000000 : Record 1001);
    VAR
      Job@1000000002 : Record 167;
      JobPlanningLine@1000000001 : Record 1003;
      JobTask@1000000004 : Record 1001;
      TotalCost@1000000003 : Decimal;
      RevFactor@1000000005 : Decimal;
      TotalRevenueToRecognize@1000 : Decimal;
      TotalIFRS15Amount@1003 : Decimal;
      LastJobPlanningRecID@1001 : RecordID;
      CalculatedLinesFound@1002 : Boolean;
      TotalRevenueToRecognizeLCY@1004 : Decimal;
      TotalCostLCY@1005 : Decimal;
      TotalIFRS15AmountLCY@1006 : Decimal;
      LCYFactor@1007 : Decimal;
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
      JobTask.SETAUTOCALCFIELDS("IFRS15 Line Amount", "Total Cost","IFRS15 Line Amount (LCY)","Total Cost (LCY)");
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

      RevFactor := ROUND(TotalRevenueToRecognize/TotalCost, 0.00001);
      //gk
      //LCYFactor := ROUND(TotalRevenueToRecognizeLCY/TotalCostLCY, 0.00001);
      //gk

      WITH JobPlanningLine DO BEGIN
        SETRANGE("Job No.", JobTask."Job No.");
        SETRANGE("IFRS15 Perf. Obligation Status", "IFRS15 Perf. Obligation Status"::Calculated);
        MODIFYALL("IFRS15 Line Amount", 0);
        SETFILTER("Total Cost", '<>0');
        IF FINDLAST THEN
          LastJobPlanningRecID := JobPlanningLine.RECORDID;
        IF FINDSET THEN BEGIN
          REPEAT
            IF RECORDID <> LastJobPlanningRecID THEN BEGIN
              VALIDATE("IFRS15 Line Amount", ROUND("Total Cost"*RevFactor, 0.01));
              TotalIFRS15Amount += "IFRS15 Line Amount";
              //gk
              //VALIDATE("IFRS15 Line Amount (LCY)", ROUND("Total Cost (LCY)"*LCYFactor, 0.01));
              TotalIFRS15AmountLCY += "IFRS15 Line Amount (LCY)";
              //gk
            END ELSE BEGIN
              //Last Line
              VALIDATE("IFRS15 Line Amount", ROUND(TotalRevenueToRecognize-TotalIFRS15Amount, 0.01));
              //gk
              //VALIDATE("IFRS15 Line Amount (LCY)", ROUND(TotalRevenueToRecognizeLCY-TotalIFRS15AmountLCY, 0.01));
              //gk
           END;
            MODIFY;
          UNTIL NEXT = 0;
        END;
      END;

      // TM TF IFRS15 02/07/18 End
    END;

    BEGIN
    {
      TM TF IFRS15 29/06/18 'IFRS15 Services'
        Object created
    }
    END.
  }
}