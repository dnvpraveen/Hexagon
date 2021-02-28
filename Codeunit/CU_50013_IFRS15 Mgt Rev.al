codeunit 50013 "IFRS15 Mgt Rev"
{
    trigger OnRun()
    begin

    end;

    VAR
        GJobTask: Record "Job Task";
        Customer: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        GlobalTemplateName: Code[10];
        GlobalBatch: Code[10];
        GlobalLineNo: Integer;
        DocumentNo: Text;
        DocumentDate: Date;
        IFRS15Setup: Record "IFRS15 Setup";
        RevReconTxt: TextConst ENU = 'REV_RECON';

    PROCEDURE CreateGeneralJnlLine(VAR JobPlanningLine: Record 1003; VAR JobNo: Code[20]);
    VAR
        JobTask: Record "Job Task";
        DimMgt: Codeunit DimensionManagement;
        GeneralPostingSetup: Record 252;
        DeferralUtilities: Codeunit 1720;
        DeferralDocType: Option Purchase,Sales,"G/L";
        GenJnlPostBatch: Codeunit 13;
        Job: Record 167;
        UserSetup: Record 91;
        GenJnlPost: Codeunit 231;
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
            VALIDATE("Gen. Prod. Posting Group", JobPlanningLine."Gen. Prod. Posting Group");
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

    LOCAL PROCEDURE GetTemplateName(): Code[10];
    VAR
        GenJournalTemplate: Record 80;
    BEGIN
        IF NOT GenJournalTemplate.GET(RevReconTxt) THEN BEGIN
            GenJournalTemplate.INIT;
            GenJournalTemplate.Name := RevReconTxt;
            GenJournalTemplate.VALIDATE(Type, GenJournalTemplate.Type::General);
            GenJournalTemplate.INSERT(TRUE);
        END;
        EXIT(RevReconTxt);
    END;

    LOCAL PROCEDURE GetBatchName(): Code[10];
    VAR
        GenJournalBatch: Record 232;
        BatchTxt: Code[10];
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

    PROCEDURE GLPreview();
    VAR
        GenJournalLine2: Record 81;
        GenJnlPostBatch: Codeunit 13;
        GenJnlPost: Codeunit 231;
    BEGIN
        GenJournalLine2.INIT;
        GlobalBatch := 'TEST';
        GlobalTemplateName := 'REV_RECON';
        GenJournalLine2.SETRANGE("Journal Template Name", GlobalTemplateName);
        GenJournalLine2.SETRANGE("Journal Batch Name", GlobalBatch);
        IF GenJournalLine2.FINDFIRST THEN BEGIN
            GenJnlPost.Preview(GenJournalLine2);
            //GenJnlPostBatch.Preview(GenJournalLine2)
        END ELSE
            MESSAGE('Out of loop');
    END;

    PROCEDURE CreateGeneralJnlLineJobTask(VAR JobTask: Record 1001);
    VAR
        DimMgt: Codeunit 408;
        GeneralPostingSetup: Record 252;
        DeferralUtilities: Codeunit 1720;
        DeferralDocType: Option Purchase,Sales,"G/L";
        GenJnlPostBatch: Codeunit 13;
        Job: Record 167;
        UserSetup: Record 91;
        GenJnlPost: Codeunit 231;
        JobPlanningLine: Record 1003;
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

        JobPlanningLine.SETRANGE("Job No.", JobTask."Job No.");
        JobPlanningLine.SETRANGE("Job Task No.", JobTask."Job Task No.");
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


}
