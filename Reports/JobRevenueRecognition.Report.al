report 50099 "Job Revenue Recognition"
{
    // TM TF IFRS15 03/07/18 'IFRS15 Services'
    //   Object created
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\JobRevenueRecognition.rdl';
    //RDLCLayout = 'JobRevenueRecognition.rdl';
    Caption = 'Job Revenue Recognition';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PageLoop; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Post; Post)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(TestReportnotpostedCaption; TestReportnotpostedCaptionLbl)
            {
            }
        }
        dataitem(Job; Job)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Is IFRS15 Job" = CONST(true),
                                      Status = FILTER(Open | Completed));
            dataitem("Job Task"; 1001)
            {
                DataItemLink = "Job No." = FIELD("No.");
                DataItemTableView = SORTING("Job No.", "Job Task No.")
                                    WHERE("IFRS15 Perf. Obligation Status" = CONST("Ready to Post"));
                dataitem("Job Planning Line"; "Job Planning Line")
                {
                    DataItemLink = "Job No." = FIELD("Job No."),
                                   "Job Task No." = FIELD("Job Task No.");
                    DataItemTableView = SORTING("Job No.", "Job Task No.", "Line No.")
                                        WHERE("IFRS15 Line Amount" = FILTER(<> 0));
                    RequestFilterFields = "Job No.", "Job Task No.";
                    column(JobTaskNo_JobPlanningLine; "Job Planning Line"."Job Task No.")
                    {
                    }
                    column(JobNo_JobPlanningLine; "Job Planning Line"."Job No.")
                    {
                    }
                    column(IFRS15LineAmount_JobPlanningLine; "Job Planning Line"."IFRS15 Line Amount")
                    {
                    }
                    column(Type_JobPlanningLine; "Job Planning Line".Type)
                    {
                    }
                    column(No_JobPlanningLine; "Job Planning Line"."No.")
                    {
                    }
                    column(DocumentNo_JobPlanningLine; DocumentNo)
                    {
                    }
                    column(DocumentDate; FORMAT(DocumentDate))
                    {
                    }
                    column(LineNo_JobPlanningLine; "Job Planning Line"."Line No.")
                    {
                    }
                    column(LocalCurrency; LocalCurrency)
                    {
                    }
                    column(Job_Currencycode; Job."Currency Code")
                    {
                    }
                    column(IFRS15LineAmountLCY_JobPlanningLine; "Job Planning Line"."IFRS15 Line Amount (LCY)")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        DocumentNo := "Job No.";
                        //DocumentDate := WORKDATE;
                        DocumentDate := PostingDate;
                        IF Post THEN
                            CreateGeneralJnlLine("Job Planning Line");
                    end;

                    trigger OnPostDataItem()
                    var
                        IFRS15Mgt: Codeunit "IFRS15 Mgt";
                    begin
                        IF Post THEN BEGIN
                            IF GJobTask.RECORDID = "Job Task".RECORDID THEN BEGIN
                                IFRS15Mgt.ChangeObligationStatusByPostingRoutine(GJobTask);
                                GJobTask.MODIFY;
                            END;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(GJobTask);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                LJobTask: Record 1001;
            begin
                If Customer.GET("Bill-to Customer No.") then;
                //GK
                IF Post THEN BEGIN
                    TotalIFRSLineAmount := 0;
                    TotalIFRSLineAmountLCY := 0;
                    LJobTask.RESET;
                    LJobTask.SETRANGE("Job No.", "No.");
                    IF LJobTask.FINDSET THEN BEGIN
                        REPEAT
                            LJobTask.CALCFIELDS("IFRS15 Line Amount", "IFRS15 Line Amount (LCY)");
                            TotalIFRSLineAmount += LJobTask."IFRS15 Line Amount";
                            TotalIFRSLineAmountLCY += LJobTask."IFRS15 Line Amount (LCY)";
                        UNTIL LJobTask.NEXT = 0;
                    END;
                    IF TotalIFRSLineAmount <> "Total Revenue to Recognize" THEN
                        ERROR(AmountMismatchErr, "Total Revenue to Recognize", TotalIFRSLineAmount, "No.");
                    //IF TotalIFRSLineAmountLCY <> "Total Rev to Recognize (LCY)" THEN
                    //ERROR(AmountLCYMismatchErr,"Total Rev to Recognize (LCY)",TotalIFRSLineAmountLCY,"No.");
                END;
                //GK
            end;

            trigger OnPreDataItem()
            begin
                IF JobFilter <> '' THEN
                    SETFILTER("No.", '%1', JobFilter);
            end;
        }
    }

    requestpage
    {
        //SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Post; Post)
                    {
                        Caption = 'Post';
                    }
                    field("Posting Date"; PostingDate)
                    {
                    }
                    field("Posting Description"; PostingDesc)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportCaption = 'Job Revenue Recognition';
        JobNoLbl = 'Job No.';
        TaskNoLbl = 'Task No.';
        LineNoLbl = 'Line No.';
        PostingDocumentNoLbl = 'Posting Document No.';
        PostingDateLbl = 'Posting Date';
        TypeLbl = 'Type';
        NoLbl = 'No';
        AmountLbl = 'Amount';
        TotalLbl = 'Total';
    }

    trigger OnInitReport()
    var
        UserSetup: Record 91;
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Allowed to Recognise Revenue");
        GlobalLineNo := 10000;
        IFRS15Setup.GET;
        IFRS15Setup.TESTFIELD("Revenue Recognition Account");
        IFRS15Setup.TESTFIELD("Source Code");
        GeneralLedgerSetup.GET;
        LocalCurrency := GeneralLedgerSetup."LCY Code";
    end;

    trigger OnPostReport()
    var
        GenJnlPostLine: Codeunit 13;
        GenJournalTemplate: Record 80;
        GLReg: Record 45;
    begin
        IF Post THEN BEGIN
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", GlobalTemplateName);
            GenJournalLine.SETRANGE("IFRS15 Posting", TRUE);
            GenJnlPostLine.RUN(GenJournalLine);
            IF GLReg.GET(GenJournalLine."Line No.") THEN
                PostedOK := TRUE;
            GenJournalTemplate.GET(GlobalTemplateName);
            GenJournalTemplate.DELETE(TRUE);
            IF PostedOK THEN
                MESSAGE(PostedMsg);
        END;
    end;

    trigger OnPreReport()
    begin
        CLEAR(GlobalTemplateName);
        GlobalTemplateName := GetTemplateName;
        GlobalBatch := GetBatchName;
        JobFilter := "Job Planning Line".GETFILTER("Job No.");
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GlobalTemplateName);
        GenJournalLine.SETRANGE("IFRS15 Posting", TRUE);
        GenJournalLine.DELETEALL(TRUE);
        GenJournalLine.RESET;
    end;

    var
        Post: Boolean;
        GlobalLineNo: Integer;
        IFRS15Setup: Record 50100;
        PageNoCaptionLbl: Label 'Page';
        TestReportnotpostedCaptionLbl: Label 'Test Report (Not Posted)';
        Customer: Record 18;
        GJobTask: Record 1001;
        DocumentNo: Text;
        DocumentDate: Date;
        PostedMsg: Label 'Revenue Recognition Entries have been posted';
        PostedOK: Boolean;
        NoDeferralScheduleErr: Label 'You must create a deferral schedule because you have specified the deferral code %2 in line %1.', Comment = '%1=The item number of the sales transaction line, %2=The Deferral Template Code';
        ZeroDeferralAmtErr: Label 'Deferral amounts cannot be 0. Line: %1, Deferral Template: %2.', Comment = '%1=The item number of the sales transaction line, %2=The Deferral Template Code';
        GenJournalLine: Record 81;
        GlobalTemplateName: Code[10];
        RevReconTxt: Label 'REV_RECON';
        GlobalBatch: Code[10];
        GJob: Record 167;
        TotalIFRSLineAmountLCY: Decimal;
        TotalIFRSLineAmount: Decimal;
        AmountMismatchErr: Label 'Total Revenue to Recognise %1 must be equal to IFRS Line Amount Total %2 for Job No. %3';
        AmountLCYMismatchErr: Label 'Total Revenue to Recognise(LCY) %1 must be equal to IFRS Line Amount (LCY) Total %2  for Job No. %3';
        JobFilter: Text[30];
        PostingDate: Date;
        GeneralLedgerSetup: Record 98;
        LocalCurrency: Code[10];
        PostingDesc: Text[50];
    // "Job Planning Line": Record "Job Planning Line";


    local procedure CreateGeneralJnlLine(var JobPlanningLine: Record 1003)
    var
        JobTask: Record 1001;
        DimMgt: Codeunit 408;
        GeneralPostingSetup: Record 252;
        DeferralUtilities: Codeunit 1720;
        DeferralDocType: Option Purchase,Sales,"G/L";
        CurrencyFactor: Decimal;
        Currency: Record 4;
        CurrExchRate: Record 330;
    begin
        JobTask.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        GJobTask := JobTask;
        JobPlanningLine.TESTFIELD("Gen. Prod. Posting Group");
        GeneralPostingSetup.GET(Customer."Gen. Bus. Posting Group", JobPlanningLine."Gen. Prod. Posting Group");
        //WITH GenJournalLine DO BEGIN
        GenJournalLine.INIT;
        GenJournalLine.VALIDATE("Journal Template Name", GlobalTemplateName);
        GenJournalLine.VALIDATE("Journal Batch Name", GlobalBatch);
        GenJournalLine."IFRS15 Posting" := TRUE;
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", GlobalLineNo);
        GlobalLineNo += 10000;
        GenJournalLine.VALIDATE("Document No.", DocumentNo);
        GenJournalLine.VALIDATE("Posting Date", DocumentDate);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        //VALIDATE("Account No.", GeneralPostingSetup."Sales Account");       //Original Code
        GenJournalLine.VALIDATE("Account No.", IFRS15Setup."Revenue Recognition Account");         //Hexagon Changes
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        //VALIDATE("Bal. Account No.", IFRS15Setup."Revenue Recognition Account");    //Original Code
        GenJournalLine.VALIDATE("Bal. Account No.", GeneralPostingSetup."Sales Account");      //Hexagon Changes
        GenJournalLine.VALIDATE("Source Code", IFRS15Setup."Source Code");
        //gk
        GenJournalLine.VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount (LCY)");
        IF PostingDesc <> '' THEN
            GenJournalLine.VALIDATE(Description, PostingDesc);
        //VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount");
        /*
        IF JobPlanningLine."Currency Code" <> '' THEN BEGIN
          CurrencyFactor := CurrExchRate.ExchangeRate(WORKDATE,JobPlanningLine."Currency Code");
           Currency.TESTFIELD("Unit-Amount Rounding Precision");
           VALIDATE(Amount,ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,JobPlanningLine."Currency Code",
                JobPlanningLine."IFRS15 Line Amount",CurrencyFactor),
                Currency."Unit-Amount Rounding Precision"));
          VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount (LCY)");
        END ELSE
          VALIDATE(Amount, JobPlanningLine."IFRS15 Line Amount (LCY)");
          */
        //gk

        GenJournalLine.VALIDATE("Dimension Set ID", DimMgt.CreateDimSetFromJobTaskDim(
                                            JobTask."Job No.", JobTask."Job Task No.", JobTask."Global Dimension 1 Code", JobTask."Global Dimension 2 Code")
                );
        GenJournalLine."Shortcut Dimension 1 Code" := JobTask."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := JobTask."Global Dimension 2 Code";

        GenJournalLine."Job Task No." := JobTask."Job Task No.";
        GenJournalLine.VALIDATE("Deferral Code", JobTask."Deferral Template");
        CLEAR(GenJournalLine."Gen. Posting Type");
        CLEAR(GenJournalLine."Gen. Bus. Posting Group");
        CLEAR(GenJournalLine."Gen. Prod. Posting Group");
        CLEAR(GenJournalLine."VAT Bus. Posting Group");
        CLEAR(GenJournalLine."VAT Prod. Posting Group");
        CLEAR(GenJournalLine."Bal. Gen. Posting Type");
        CLEAR(GenJournalLine."Bal. Gen. Bus. Posting Group");
        CLEAR(GenJournalLine."Bal. Gen. Prod. Posting Group");
        CLEAR(GenJournalLine."Bal. VAT Bus. Posting Group");
        CLEAR(GenJournalLine."Bal. VAT Prod. Posting Group");
        GenJournalLine.INSERT(TRUE);
        //END;

    end;

    local procedure GetTemplateName(): Code[10]
    var
        GenJournalTemplate: Record 80;
    begin
        IF NOT GenJournalTemplate.GET(RevReconTxt) THEN BEGIN
            GenJournalTemplate.INIT;
            GenJournalTemplate.Name := RevReconTxt;
            GenJournalTemplate.VALIDATE(Type, GenJournalTemplate.Type::General);
            GenJournalTemplate.INSERT(TRUE);
        END;
        EXIT(RevReconTxt);
    end;

    local procedure GetBatchName(): Code[10]
    var
        GenJournalBatch: Record 232;
        BatchTxt: Code[10];
    begin
        //WITH GenJournalLine DO BEGIN
        BatchTxt := FORMAT(CURRENTDATETIME, 0, '<year,2><Month,2><day,2><hour,2><Minute,2>');
        IF NOT GenJournalBatch.GET(GlobalTemplateName, BatchTxt) THEN BEGIN
            GenJournalBatch.INIT;
            GenJournalBatch."Journal Template Name" := GlobalTemplateName;
            GenJournalBatch.Name := BatchTxt;
            GenJournalBatch.INSERT(TRUE);
        END;
        //END;
        EXIT(BatchTxt);
    end;
}

