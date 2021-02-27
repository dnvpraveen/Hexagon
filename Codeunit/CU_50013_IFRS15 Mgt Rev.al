codeunit 50013 "IFRS15 Mgt Rev"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}



OBJECT Codeunit 50013 IFRS15 Mgt Rev
{
  OBJECT-PROPERTIES
  {
    Date=24-09-20;
    Time=[ 9:19:39 AM];
    Modified=Yes;
    Version List=HexIFRS,HEXGJ1.0;
  }
  PROPERTIES
  {
    OnRun=BEGIN
          END;

  }
  CODE
  {
    VAR
      GJobTask@1000000008 : Record 1001;
      Customer@1000000007 : Record 18;
      GenJournalLine@1000000006 : Record 81;
      GlobalTemplateName@1000000005 : Code[10];
      GlobalBatch@1000000004 : Code[10];
      GlobalLineNo@1000000003 : Integer;
      DocumentNo@1000000002 : Text;
      DocumentDate@1000000001 : Date;
      IFRS15Setup@1000000000 : Record 50100;
      RevReconTxt@1000000009 : TextConst 'ENU=REV_RECON';

    PROCEDURE CreateGeneralJnlLine@1000000000(VAR JobPlanningLine@1000000000 : Record 1003;VAR JobNo@1000000001 : Code[20]);
    VAR
      JobTask@1000000002 : Record 1001;
      DimMgt@1000000003 : Codeunit 408;
      GeneralPostingSetup@1000 : Record 252;
      DeferralUtilities@1003 : Codeunit 1720;
      DeferralDocType@1004 : 'Purchase,Sales,G/L';
      GenJnlPostBatch@1001 : Codeunit 13;
      Job@1002 : Record 167;
      UserSetup@1005 : Record 91;
      GenJnlPost@1000000004 : Codeunit 231;
    BEGIN
      UserSetup.GET(USERID);
      UserSetup.TESTFIELD("Allowed to Recognise Revenue");
      GlobalLineNo := 10000;
      IFRS15Setup.GET;
      IFRS15Setup.TESTFIELD("Revenue Recognition Account");
      IFRS15Setup.TESTFIELD("Source Code");

      CLEAR(GlobalTemplateName);
      GlobalTemplateName := GetTemplateName;
      GlobalBatch := GetBatchName;
      GenJournalLine.RESET;
      GenJournalLine.SETRANGE("Journal Template Name", GlobalTemplateName);
      GenJournalLine.SETRANGE("IFRS15 Posting", TRUE);
      GenJournalLine.DELETEALL(TRUE);
      GenJournalLine.RESET;

      IF Job.GET(JobNo) THEN
       IF Customer.GET(Job."Bill-to Customer No.") THEN;

      CLEAR(GJobTask);
      DocumentNo := JobNo;
      DocumentDate := WORKDATE;


      JobTask.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
      GJobTask := JobTask;
      JobPlanningLine.TESTFIELD("Gen. Prod. Posting Group");
      GeneralPostingSetup.GET(Customer."Gen. Bus. Posting Group", JobPlanningLine."Gen. Prod. Posting Group");
      WITH GenJournalLine DO BEGIN
        INIT;
          "Journal Template Name" := GlobalTemplateName;
          "Journal Batch Name" := GlobalBatch;
          "IFRS15 Posting" := TRUE;
          VALIDATE("Line No.", GlobalLineNo);
          GlobalLineNo += 10000;
          VALIDATE("Document No.", DocumentNo);
          VALIDATE("Posting Date", DocumentDate);
          VALIDATE("Account Type", "Account Type"::"G/L Account");
          //VALIDATE("Account No.", GeneralPostingSetup."Sales Account");                //Original Code
          VALIDATE("Account No.", IFRS15Setup."Revenue Recognition Account");            //Hexagon Changes
          VALIDATE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
          //VALIDATE("Bal. Account No.", IFRS15Setup."Revenue Recognition Account");      //Original Code
          VALIDATE("Bal. Account No.", GeneralPostingSetup."Sales Account");              //Hexagon Changes
          VALIDATE("Source Code", IFRS15Setup."Source Code");
          VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount");
          VALIDATE("Dimension Set ID", DimMgt.CreateDimSetFromJobTaskDim(
                                              JobTask."Job No.", JobTask."Job Task No.", JobTask."Global Dimension 1 Code", JobTask."Global Dimension 2 Code")
                  );
          "Shortcut Dimension 1 Code" := JobTask."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code" := JobTask."Global Dimension 2 Code";

          "Job Task No." := JobTask."Job Task No.";
          VALIDATE("Gen. Prod. Posting Group",JobPlanningLine."Gen. Prod. Posting Group");
          VALIDATE("Deferral Code", JobTask."Deferral Template");
          CLEAR("Gen. Posting Type");
          CLEAR("Gen. Bus. Posting Group");
          CLEAR("Gen. Prod. Posting Group");
          CLEAR("VAT Bus. Posting Group");
          CLEAR("VAT Prod. Posting Group");
          CLEAR("Bal. Gen. Posting Type");
          CLEAR("Bal. Gen. Bus. Posting Group");
          CLEAR("Bal. Gen. Prod. Posting Group");
          CLEAR("Bal. VAT Bus. Posting Group");
          CLEAR("Bal. VAT Prod. Posting Group");
          INSERT;
      END;
      COMMIT;
       //GenJnlPostBatch.Preview(GenJournalLine);
            GenJnlPost.Preview(GenJournalLine);
      //      GLPreview(GenJournalLine);
      //GLPreview;
    END;

    LOCAL PROCEDURE GetTemplateName@29() : Code[10];
    VAR
      GenJournalTemplate@1000 : Record 80;
    BEGIN
      IF NOT GenJournalTemplate.GET(RevReconTxt) THEN BEGIN
        GenJournalTemplate.INIT;
          GenJournalTemplate.Name := RevReconTxt;
          GenJournalTemplate.VALIDATE(Type, GenJournalTemplate.Type::General);
        GenJournalTemplate.INSERT(TRUE);
      END;
      EXIT(RevReconTxt);
    END;

    LOCAL PROCEDURE GetBatchName@32() : Code[10];
    VAR
      GenJournalBatch@1002 : Record 232;
      BatchTxt@1003 : Code[10];
    BEGIN
      WITH GenJournalLine DO BEGIN
        BatchTxt := FORMAT(CURRENTDATETIME, 0, '<year,2><Month,2><day,2><hour,2><Minute,2>');
        IF NOT GenJournalBatch.GET(GlobalTemplateName, BatchTxt) THEN BEGIN
          GenJournalBatch.INIT;
            GenJournalBatch."Journal Template Name" := GlobalTemplateName;
            GenJournalBatch.Name := BatchTxt;
          GenJournalBatch.INSERT(TRUE);
        END;
      END;
      EXIT(BatchTxt);
    END;

    PROCEDURE GLPreview@1000000001();
    VAR
      GenJournalLine2@1000000001 : Record 81;
      GenJnlPostBatch@1000000002 : Codeunit 13;
      GenJnlPost@1000000000 : Codeunit 231;
    BEGIN
      GenJournalLine2.INIT;
      GlobalBatch := 'TEST';
      GlobalTemplateName := 'REV_RECON';
      GenJournalLine2.SETRANGE("Journal Template Name", GlobalTemplateName);
      GenJournalLine2.SETRANGE("Journal Batch Name",GlobalBatch);
      IF GenJournalLine2.FINDFIRST THEN BEGIN
        GenJnlPost.Preview(GenJournalLine2);
        //GenJnlPostBatch.Preview(GenJournalLine2)
      END ELSE
        MESSAGE('Out of loop');
    END;

    PROCEDURE CreateGeneralJnlLineJobTask@1000000002(VAR JobTask@1000000000 : Record 1001);
    VAR
      DimMgt@1000000003 : Codeunit 408;
      GeneralPostingSetup@1000 : Record 252;
      DeferralUtilities@1003 : Codeunit 1720;
      DeferralDocType@1004 : 'Purchase,Sales,G/L';
      GenJnlPostBatch@1001 : Codeunit 13;
      Job@1002 : Record 167;
      UserSetup@1005 : Record 91;
      GenJnlPost@1000000004 : Codeunit 231;
      JobPlanningLine@1000000001 : Record 1003;
    BEGIN
      UserSetup.GET(USERID);
      UserSetup.TESTFIELD("Allowed to Recognise Revenue");
      GlobalLineNo := 10000;
      IFRS15Setup.GET;
      IFRS15Setup.TESTFIELD("Revenue Recognition Account");
      IFRS15Setup.TESTFIELD("Source Code");

      CLEAR(GlobalTemplateName);
      GlobalTemplateName := GetTemplateName;
      GlobalBatch := GetBatchName;
      GenJournalLine.RESET;
      GenJournalLine.SETRANGE("Journal Template Name", GlobalTemplateName);
      GenJournalLine.SETRANGE("IFRS15 Posting", TRUE);
      GenJournalLine.DELETEALL(TRUE);
      GenJournalLine.RESET;

      IF Job.GET(JobTask."Job No.") THEN
       IF Customer.GET(Job."Bill-to Customer No.") THEN;

      CLEAR(GJobTask);
      DocumentNo := JobTask."Job No.";
      DocumentDate := WORKDATE;

      JobPlanningLine.SETRANGE("Job No.",JobTask."Job No.");
      JobPlanningLine.SETRANGE("Job Task No.",JobTask."Job Task No.");
      //JobTask.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
      //GJobTask := JobTask;
      IF JobPlanningLine.FINDSET THEN
      REPEAT
      JobPlanningLine.TESTFIELD("Gen. Prod. Posting Group");
      GeneralPostingSetup.GET(Customer."Gen. Bus. Posting Group", JobPlanningLine."Gen. Prod. Posting Group");
      WITH GenJournalLine DO BEGIN
        INIT;
          "Journal Template Name" := GlobalTemplateName;
          "Journal Batch Name" := GlobalBatch;
          "IFRS15 Posting" := TRUE;
          VALIDATE("Line No.", GlobalLineNo);
          GlobalLineNo += 10000;
          VALIDATE("Document No.", DocumentNo);
          VALIDATE("Posting Date", DocumentDate);
          VALIDATE("Account Type", "Account Type"::"G/L Account");
          //VALIDATE("Account No.", GeneralPostingSetup."Sales Account");                //Original Code
          VALIDATE("Account No.", IFRS15Setup."Revenue Recognition Account");            //Hexagon Changes
          VALIDATE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
          //VALIDATE("Bal. Account No.", IFRS15Setup."Revenue Recognition Account");      //Original Code
          VALIDATE("Bal. Account No.", GeneralPostingSetup."Sales Account");              //Hexagon Changes
          VALIDATE("Source Code", IFRS15Setup."Source Code");
          VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount");
          VALIDATE("Dimension Set ID", DimMgt.CreateDimSetFromJobTaskDim(
                                              JobTask."Job No.", JobTask."Job Task No.", JobTask."Global Dimension 1 Code", JobTask."Global Dimension 2 Code")
                  );
          "Shortcut Dimension 1 Code" := JobTask."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code" := JobTask."Global Dimension 2 Code";

          "Job Task No." := JobTask."Job Task No.";
          VALIDATE("Deferral Code", JobTask."Deferral Template");
          CLEAR("Gen. Posting Type");
          CLEAR("Gen. Bus. Posting Group");
          CLEAR("Gen. Prod. Posting Group");
          CLEAR("VAT Bus. Posting Group");
          CLEAR("VAT Prod. Posting Group");
          CLEAR("Bal. Gen. Posting Type");
          CLEAR("Bal. Gen. Bus. Posting Group");
          CLEAR("Bal. Gen. Prod. Posting Group");
          CLEAR("Bal. VAT Bus. Posting Group");
          CLEAR("Bal. VAT Prod. Posting Group");
          INSERT;
      END;
      UNTIL JobPlanningLine.NEXT = 0;
      COMMIT;
      //    GenJnlPostBatch.Preview(GenJournalLine);
            GenJnlPost.Preview(GenJournalLine);
      //      GLPreview(GenJournalLine);
      //GLPreview;
    END;

    BEGIN
    END.
  }
}