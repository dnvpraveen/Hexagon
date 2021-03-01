// codeunit 50190 "IFRS15 Test CU"
// {
//     trigger OnRun()
//     begin

//     end;

//     VAR
//         IFRS15Setup: Record 50100;
//         IFRS15ConfMsgTxt: TextConst ENU = 'You are about to set this task as a Performance Obligation and calculate the IFRS15 Revenue Recognition - do you want to proceed?',
//         ENG = 'You are about to set this task as a Performance Obligation and calculate the IFRS15 Revenue Recognition - do you want to proceed?';
//         Assert: Codeunit 130000;
//         LibraryERM: Codeunit 131300;
//         LibraryJob: Codeunit 131920;
//         FieldError: TextConst ENU = '%1 must be %2 in %3.';
//         CannotChangeObligStatusToPostManuallyErrMsg: TextConst ENU = 'You cannot change IFRS15 Perf. Obligation Status=Posted manually';
//         CannotChangeTheStatusNoPlanningLinesErr: TextConst ENU = 'You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7', ENG = 'You cannot change the %1=%2, because there are no %3 for %4=%5, %6=%7';
//         LibrarySales: Codeunit 130509;
//         LibraryRandom: Codeunit 130440;
//         LibraryWarehouse: Codeunit 132204;
//         GlobalSalesInvoiceNo: Code[20];
//         UpdateDimOnJobQuestionMsg: TextConst ENU = 'You have changed a dimension.\\Do you want to update the lines?', ENG = 'You have changed a dimension.\\Do you want to update the lines?';
//         LocationCodeMustHaveAValueErr: TextConst ENU = 'Location Code must have a value';

//     LOCAL PROCEDURE ">> Tests"();
//     BEGIN
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE Job_CreateJobWhenIFRS15Active();
//     VAR
//         Job: Record 167;
//     BEGIN
//         // 01. Test if Job is marked as "is IFRS15 Job" while creating new Job as IFRS15 when IFRS15Setup is Active

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job
//         LibraryJob.CreateJob(Job);

//         // Verify: Check if "Is IFRS15 Job" is active
//         Assert.AreEqual(
//           TRUE, Job."Is IFRS15 Job",
//           STRSUBSTNO(FieldError, Job.FIELDCAPTION("Is IFRS15 Job"), TRUE, Job.TABLECAPTION));
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE Job_CreateJobWhenIFRS15NOTActive();
//     VAR
//         Job: Record 167;
//     BEGIN
//         // 02. Test if Job is NOT marked as "is IFRS15 Job" while creating new Job as IFRS15 when IFRS15Setup is NOT Active

//         // Setup: Setup IFRS15 as NOT Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);
//         IFRS15Setup.GET;
//         IFRS15Setup."IFRS15 Active" := FALSE;
//         IFRS15Setup.MODIFY(TRUE);

//         // Exercise: Create new Job
//         LibraryJob.CreateJob(Job);

//         // Verify: Check if "Is IFRS15 Job" is NOT active
//         Assert.AreEqual(
//           FALSE, Job."Is IFRS15 Job",
//           STRSUBSTNO(FieldError, Job.FIELDCAPTION("Is IFRS15 Job"), FALSE, Job.TABLECAPTION));
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCannotBeSetToPostManually();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//     BEGIN
//         // 03. Job Tasks. Test if the user cannot change the Obligation Status to "Post" manually

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);

//         // Verify: Check if Obligation Status cannot be set to "Posted" manually
//         ASSERTERROR JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Posted);
//         Assert.ExpectedError(CannotChangeObligStatusToPostManuallyErrMsg);
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCanBeSetToPostByCalculation();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         IFRS15Mgt: Codeunit 50100;
//     BEGIN
//         // 04. Job Tasks. Test if the user can change the Obligation Status to "Post" using calculation routine

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);

//         // Verify: Check if Obligation Status can be set to "Posted" using calculatrion routine
//         IFRS15Mgt.ChangeObligationStatusByPostingRoutine(JobTask);
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCannotBeSetToCalculatedWhenNoPlanningLines();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//     BEGIN
//         // 05. Job Tasks. Test if the user cannot change the Obligation Status to "Calculated" if no Planning Lines

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);

//         // Verify: Check if Obligation Status cannot be set to "Calculated" when no Planning Lines
//         ASSERTERROR JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         Assert.ExpectedError(STRSUBSTNO(CannotChangeTheStatusNoPlanningLinesErr, JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status"),
//                              FORMAT(JobTask."IFRS15 Perf. Obligation Status"::Calculated), JobPlanningLine.TABLECAPTION,
//                              JobTask.FIELDCAPTION("Job No."), JobTask."Job No.", JobTask.FIELDCAPTION("Job Task No."), JobTask."Job Task No."));
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler, MsgHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCanBeSetToCalculatedWhenPlanningLinesExist();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//     BEGIN
//         // 06. Job Tasks. Test if the user can change the Obligation Status to "Calculated" if Planning Lines exist

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Budget, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         // Verify: Check if Obligation Status can be set to "Calculated" when Planning Lines exist
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCannotBeSetToReadyToPostWhenNoPlanningLines();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//     BEGIN
//         // 07. Job Tasks. Test if the user cannot change the Obligation Status to "Ready to Post" if no Planning Lines

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);

//         // Verify: Check if Obligation Status cannot be set to "Ready to Post" when no Planning Lines
//         ASSERTERROR JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//         Assert.ExpectedError(STRSUBSTNO(CannotChangeTheStatusNoPlanningLinesErr, JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status"),
//                              FORMAT(JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post"), JobPlanningLine.TABLECAPTION,
//                              JobTask.FIELDCAPTION("Job No."), JobTask."Job No.", JobTask.FIELDCAPTION("Job Task No."), JobTask."Job Task No."));
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, MsgHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCanBeSetToReadyToPostWhenPlanningLinesExist();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         Location@1000 : Record 14;
//     BEGIN
//         // 08. Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if Planning Lines exist

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Budget, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         LibraryWarehouse.CreateLocation(Location);
//         JobPlanningLine."Location Code" := Location.Code;
//         JobPlanningLine.MODIFY;
//         // Verify: Check if Obligation Status can be set to "Calculated" when Planning Lines exist
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, MsgHandler)]
//     PROCEDURE JobTask_CheckIfConfMsgIsDisplayedWhenObligationStatusSetToReadyToPostWithPlanningLines();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         Location@1000 : Record 14;
//     BEGIN
//         // 09. Job Tasks. Test if a confirmation is displayed when Obligation Status is set to "Ready to Post" and the Planning Lines exists

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Budget, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         LibraryWarehouse.CreateLocation(Location);
//         JobPlanningLine."Location Code" := Location.Code;
//         JobPlanningLine.MODIFY;
//         // Verify: Check if confirmation is displayed
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, MsgHandler)]
//     PROCEDURE JobTask_CheckIfAssignedJobNoIsFilledInWhenSalesInvoiceIsCreated();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobTaskLinesTestPage: TestPage 1002;
//         JobCreateSalesInvoice: Report 1093;
//         SalesHeader: Record 36;
//     BEGIN
//         // 10. Job Tasks. Test if Assigned Job No. is filled in when the Sales Invoice is created from Job Task
//         // The action Create Invoice from Job Task has been disabled in Hexagon

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Create Sales Invoice form JOb Task
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         COMMIT;
//         JobTaskLinesTestPage.OPENVIEW;
//         JobTaskLinesTestPage.GOTORECORD(JobTask);
//         IF JobTaskLinesTestPage.Action15.ENABLED THEN BEGIN
//             JobTaskLinesTestPage.Action15.INVOKE;


//             // Verify: Check if Assigned Job No. on Created Sales Invoice is equal Job No.
//             SalesHeader.SETRANGE("Assigned Job No.", Job."No.");
//             SalesHeader.FINDFIRST;
//         END;
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, SalesOrderCreatedMessageHandler)]
//     PROCEDURE JobTaskHEX_CheckIfAssignedJobNoIsFilledInWhenSalesOrderIsCreated();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobCardTestPage: TestPage 88;
//         SalesOrderTestPage@1000 : TestPage 42;
//       JobCreateSalesInvoice: Report 1093;
//         SalesHeader@1001 : Record 36;
//     BEGIN
//         //11. Job Tasks HEX. Test if Assigned Job No. is filled in when the Sales Order is created from Job Task

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Create Sales Order form Job Task
//         LibraryJob.CreateJob(Job);
//         Job.Status := Job.Status::Open;
//         Job.MODIFY(TRUE);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         COMMIT;

//         SalesOrderTestPage.TRAP;
//         JobCardTestPage.OPENVIEW;
//         JobCardTestPage.GOTORECORD(Job);
//         JobCardTestPage."Create Sales Order".INVOKE;

//         // Verify: Check if Assigned Job No. on Created Sales Invoice is equal Job No.
//         Assert.AreEqual(Job."No.", SalesOrderTestPage."Assigned Job No.".VALUE, '');
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, SalesOrderCreatedMessageHandler)]
//     PROCEDURE JobTaskHEX_CheckIfAssignedJobNoIsFilledInWhenSaleCreditIsCreated();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobCardTestPage: TestPage 88;
//         SalesCreditMemoTestPage@1000 : TestPage 44;
//       JobCreateSalesInvoice: Report 1093;
//         SalesHeader@1001 : Record 36;
//     BEGIN
//         //12. Job Tasks HEX. Test if Assigned Job No. is filled in when the Sales Credit is created from Job Task

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Create Sales Order form Job Task
//         LibraryJob.CreateJob(Job);
//         Job.Status := Job.Status::Open;
//         Job.MODIFY(TRUE);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         COMMIT;

//         SalesCreditMemoTestPage.TRAP;
//         JobCardTestPage.OPENVIEW;
//         JobCardTestPage.GOTORECORD(Job);
//         JobCardTestPage."Create Sales Credit".INVOKE;

//         // Verify: Check if Assigned Job No. on Created Sales Invoice is equal Job No.
//         Assert.AreEqual(Job."No.", SalesCreditMemoTestPage."Assigned Job No.".VALUE, '');
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler, MsgHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCanBeSetToReadyToPostWhenPlanLinesWithTypeItemNotHaveLocationCode();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         Location: Record 14;
//     BEGIN
//         //13.Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if any of Planning Lines with type Item do not have Location Code

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Budget, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobPlanningLine."Location Code" := '';
//         JobPlanningLine.MODIFY;
//         // Verify: Check if Obligation Status can be set to "Calculated" when Planning Lines exist
//         ASSERTERROR JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//         Assert.ExpectedError(LocationCodeMustHaveAValueErr);
//     END;

//     [Test]
//     [HandlerFunctions(ConfMsgHandler, MsgHandler)]
//     PROCEDURE SalesDocument_CheckIfAssignedJobNoIsTransferedToPostedDocument();
//     VAR
//         SalesHeader: Record 36;
//         SalesLine: Record 37;
//         Job: Record 167;
//         DocNo: Code[20];
//         SalesInvoiceHeader: Record 112;
//         Customer: Record 18;
//         GLAccount: Record 15;
//         VATPostingSetup: Record 325;
//         GenProductPostingGroup: Record 251;
//     BEGIN
//         // 14. Sales Document. Test if Assigned Job No. is transfered to posted document

//         // Setup: Setup Job No
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);
//         LibraryJob.CreateJob(Job);
//         LibrarySales.CreateCustomer(Customer);
//         LibraryERM.CreateGLAccount(GLAccount);
//         VATPostingSetup.SETRANGE("VAT Calculation Type", VATPostingSetup."VAT Calculation Type"::"Normal VAT");
//         VATPostingSetup.FINDFIRST;
//         GenProductPostingGroup.FINDFIRST;
//         GLAccount."VAT Bus. Posting Group" := VATPostingSetup."VAT Bus. Posting Group";
//         GLAccount."VAT Prod. Posting Group" := VATPostingSetup."VAT Prod. Posting Group";
//         GLAccount."Gen. Prod. Posting Group" := GenProductPostingGroup.Code;
//         GLAccount.MODIFY;

//         // Exercise: Create sales invoice, set Assigned Job No, Post Document
//         LibrarySales.CreateSalesHeader(SalesHeader, SalesHeader."Document Type"::Invoice, Customer."No.");
//         LibrarySales.CreateSalesLine(SalesLine, SalesHeader, SalesLine.Type::"G/L Account", GLAccount."No.", LibraryRandom.RandInt(100));
//         SalesHeader.VALIDATE("Assigned Job No.", Job."No.");
//         SalesHeader.VALIDATE("Posting Date", WORKDATE);
//         SalesHeader.MODIFY;
//         DocNo := LibrarySales.PostSalesDocument(SalesHeader, TRUE, TRUE);

//         // Verify: Check if Assigned Job No. has been transfered on posted document
//         SalesInvoiceHeader.GET(DocNo);
//         SalesInvoiceHeader.TESTFIELD("Assigned Job No.", SalesHeader."Assigned Job No.");
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler, CopySalesDocumentReportHandler, MsgHandler)]
//     PROCEDURE SalesDocument_CheckIfAssignedJobNoIsCopiedTOOtherSalesDocUsingCopyDocFunc();
//     VAR
//         SalesHeader: Record 36;
//         SalesHeader2: Record 36;
//         Job: Record 167;
//         SalesReceivablesSetup: Record 311;
//         SalesInvoiceTestPage: TestPage 43;
//     BEGIN
//         // 15. Sales Document. Test if Assigned Job No. is copied to other sales document using "Copy Document" functionality

//         // Setup: Setup Job No, Changes Sales Setup to ignore stock warning
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);
//         LibraryJob.CreateJob(Job);
//         SalesReceivablesSetup.GET;
//         SalesReceivablesSetup."Stockout Warning" := FALSE;
//         SalesReceivablesSetup.MODIFY;

//         // Exercise: Create sales invoice, set Assigned Job No, Create new Sales Invoice and copy document from previous Sales Invoice
//         LibrarySales.CreateSalesInvoice(SalesHeader);
//         SalesHeader.VALIDATE("Assigned Job No.", Job."No.");
//         SalesHeader.MODIFY;
//         GlobalSalesInvoiceNo := SalesHeader."No.";
//         LibrarySales.CreateSalesHeader(SalesHeader2, SalesHeader2."Document Type"::Invoice, SalesHeader."Sell-to Customer No.");
//         COMMIT;

//         SalesInvoiceTestPage.OPENEDIT;
//         SalesInvoiceTestPage.GOTORECORD(SalesHeader2);
//         SalesInvoiceTestPage.CopyDocument.INVOKE;
//         SalesHeader2.GET(SalesHeader2.RECORDID);
//         // Verify: Check if Assigned Job No. has been transfered on posted document
//         SalesHeader2.TESTFIELD("Assigned Job No.", SalesHeader."Assigned Job No.");
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler, MsgHandler)]
//     PROCEDURE JobPlanningLine_CheckIfManualChangeOfIFRS15AmountWillChangeObligationStatusToBlank();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobTaskLinesTestPage: TestPage 1002;
//         JobCreateSalesInvoice: Report 1093;
//         SalesLine: Record 37;
//         SalesHeader: Record 36;
//     BEGIN
//         //16. Job Planning Lines. Check if manual change of IFRS15 Amount will set the Obligation Status to '' (Blank)

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Set Status to calculated
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobPlanningLine.VALIDATE("IFRS15 Line Amount", LibraryRandom.RandDecInDecimalRange(1000, 2000, 2));
//         JobPlanningLine.MODIFY(TRUE);
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         JobTask.MODIFY(TRUE);

//         // Verify: Check if manual change will set the status back to '' (Blank)
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         JobPlanningLine.VALIDATE("IFRS15 Line Amount", LibraryRandom.RandDecInDecimalRange(0, 500, 2));
//         JobPlanningLine.MODIFY(TRUE);
//         JobTask.GET(JobTask.RECORDID);
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
//     END;

//     [Test]
//     [HandlerFunctions(ConfirmationMsgHandler)]
//     PROCEDURE JobTask_CheckIfObligationStatusCanBeSetToReadyToPostWhenPlanLinesWithTypeOtherThanItemNotHaveLocationCode();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         Location@1000 : Record 14;
//     BEGIN
//         //17.Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if any of Planning Lines with type other than Item do not have Location Code

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Budget, JobPlanningLine.Type::"G/L Account", JobTask, JobPlanningLine);
//         JobPlanningLine."Location Code" := '';
//         JobPlanningLine.MODIFY;
//         // Verify: Check if Obligation Status can be set to "Calculated" when Planning Lines exist
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler, MsgHandler)]
//     PROCEDURE JobPlanningLine_CheckIfInsertNewPlanningLineWillChangeObligationStatusToBlank();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobTaskLinesTestPage: TestPage 1002;
//         JobCreateSalesInvoice: Report 1093;
//         SalesLine: Record 37;
//         SalesHeader: Record 36;
//     BEGIN
//         //18. Job Planning Line. Check if insert new planning line will set the Obligation Status to '' (Blank)

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Set Status to calculated
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobPlanningLine.VALIDATE("IFRS15 Line Amount", LibraryRandom.RandDecInDecimalRange(1000, 2000, 2));
//         JobPlanningLine.MODIFY(TRUE);
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         JobTask.MODIFY(TRUE);

//         // Verify: Check if insert new planning line will set the status back to '' (Blank)
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobTask.GET(JobTask.RECORDID);
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
//     END;

//     [Test]
//     [HandlerFunctions(DimensionChangedOnJobConfirmationHandler, MsgHandler)]
//     PROCEDURE JobPlanningLine_CheckIfDeletePlanningLineWillChangeObligationStatusToBlank();
//     VAR
//         Job: Record 167;
//         JobTask: Record 1001;
//         JobPlanningLine: Record 1003;
//         JobTaskLinesTestPage: TestPage 1002;
//         JobCreateSalesInvoice: Report 1093;
//         SalesLine: Record 37;
//         SalesHeader: Record 36;
//     BEGIN
//         //19. Job Planning Line. Check if delete planning line will set the Obligation Status to '' (Blank)

//         // Setup: Setup IFRS15 as Active
//         InitializeIFRS15Setup(TRUE, IFRS15ConfMsgTxt);

//         // Exercise: Create new Job, Create new Task, Create Planning Line, Set Status to calculated
//         LibraryJob.CreateJob(Job);
//         LibraryJob.CreateJobTask(Job, JobTask);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobPlanningLine.VALIDATE("IFRS15 Line Amount", LibraryRandom.RandDecInDecimalRange(1000, 2000, 2));
//         JobPlanningLine.MODIFY(TRUE);
//         LibraryJob.CreateJobPlanningLine(JobPlanningLine."Line Type"::Billable, JobPlanningLine.Type::Item, JobTask, JobPlanningLine);
//         JobPlanningLine.VALIDATE("IFRS15 Line Amount", LibraryRandom.RandDecInDecimalRange(1000, 2000, 2));
//         JobPlanningLine.MODIFY(TRUE);
//         JobTask.VALIDATE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         JobTask.MODIFY(TRUE);

//         // Verify: Check if delete planning line will set the status back to '' (Blank)
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
//         JobPlanningLine.DELETE(TRUE);
//         JobTask.GET(JobTask.RECORDID);
//         JobTask.TESTFIELD("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
//     END;

//     LOCAL PROCEDURE ">> Functions"();
//     BEGIN
//     END;

//     LOCAL PROCEDURE InitializeIFRS15Setup(IsActive: Boolean; ConfMsg: Text[250]);
//     VAR
//         GLAccount: Record 15;
//         SourceCode: Record 230;
//         JobsSetup: Record 315;
//         NoSeries: Record 308;
//         GeneralLedgerSetup: Record 98;
//         InventorySetup: Record 313;
//     BEGIN
//         WITH IFRS15Setup DO BEGIN
//             RESET;
//             IF GET THEN
//                 DELETEALL;

//             LibraryERM.CreateGLAccount(GLAccount);
//             LibraryERM.CreateSourceCode(SourceCode);
//             INIT;
//             VALIDATE("IFRS15 Active", IsActive);
//             VALIDATE("Revenue Recognition Account", GLAccount."No.");
//             VALIDATE("Source Code", SourceCode.Code);
//             VALIDATE("Recognise Revenue Confirm. Msg", ConfMsg);
//             INSERT(TRUE);
//         END;

//         JobsSetup.GET;
//         IF JobsSetup."Job Nos." <> '' THEN BEGIN
//             IF NoSeries.GET(JobsSetup."Job Nos.") THEN BEGIN
//                 IF NOT NoSeries."Manual Nos." THEN BEGIN
//                     NoSeries.VALIDATE("Manual Nos.", TRUE);
//                     NoSeries.MODIFY;
//                 END;
//             END;
//         END;

//         GeneralLedgerSetup.GET;
//         GeneralLedgerSetup."Allow Posting From" := 0D;
//         GeneralLedgerSetup."Allow Posting To" := 0D;
//         GeneralLedgerSetup.MODIFY;

//         InventorySetup.GET;
//         InventorySetup."Location Mandatory" := FALSE;
//         InventorySetup."Prevent Negative Inventory" := FALSE;
//         InventorySetup.MODIFY;
//     END;

//     LOCAL PROCEDURE ">> Handlers"();
//     BEGIN
//     END;

//     [ConfirmHandler]
//     PROCEDURE ConfirmationMsgHandler(Question: Text; VAR Reply: Boolean);
//     BEGIN
//         IF Question = IFRS15Setup."Recognise Revenue Confirm. Msg" THEN
//             Reply := TRUE;
//     END;

//     [ConfirmHandler]
//     PROCEDURE DimensionChangedOnJobConfirmationHandler@1(Question: Text; VAR Reply: Boolean);
//     BEGIN
//         IF Question = UpdateDimOnJobQuestionMsg THEN
//             Reply := TRUE
//         ELSE
//             ERROR(Question);
//     END;

//     [RequestPageHandler]
//     PROCEDURE JobCreateSalesInvoiceReportHandler(VAR JobCreateSalesInvoiceReport: TestRequestPage 1093);
//     BEGIN
//         JobCreateSalesInvoiceReport.OK.INVOKE;
//     END;

//     [RequestPageHandler]
//     PROCEDURE CopySalesDocumentReportHandler(VAR CopySalesDocumentReport: TestRequestPage 292);
//     VAR
//         SalesHeader: Record 36;
//     BEGIN
//         CopySalesDocumentReport.DocumentType.VALUE := FORMAT(SalesHeader."Document Type"::Invoice);
//         CopySalesDocumentReport.DocumentNo.VALUE(GlobalSalesInvoiceNo);
//         CopySalesDocumentReport.IncludeHeader_Options.VALUE(FORMAT(TRUE));
//         CLEAR(GlobalSalesInvoiceNo);
//         CopySalesDocumentReport.OK.INVOKE;
//     END;

//     [MessageHandler]
//     PROCEDURE SalesInvoiceCreatedMessageHandler(Message: Text);
//     BEGIN
//     END;

//     [ModalPageHandler]
//     PROCEDURE NoSeriesListModalPageHandler(VAR NoSeriesList: TestPage 571);
//     VAR
//         NoSeries: Record 308;
//     BEGIN
//         NoSeriesList.GOTOKEY('SS-ORD');
//         NoSeriesList.OK.INVOKE;
//     END;

//     [MessageHandler]
//     PROCEDURE SalesOrderCreatedMessageHandler(Message: Text);
//     BEGIN
//     END;

//     [MessageHandler]
//     PROCEDURE MsgHandler(Message: Text);
//     BEGIN
//     END;

//     [ConfirmHandler]
//     PROCEDURE ConfMsgHandler(Question: Text; VAR Reply: Boolean);
//     BEGIN
//         Reply := TRUE;
//     END;

//     // BEGIN
//     // {
//     //   TM TF IFRS15 29/06/18 'IFRS15 Services'
//     //     Object created

//     //   01. Jobs. Test if Job is marked as "is IFRS15 Job" while creating new Job as IFRS15 when IFRS15Setup is Active
//     //   02. Jobs. Test if Job is NOT marked as "is IFRS15 Job" while creating new Job as IFRS15 when IFRS15Setup is NOT Active
//     //   03. Job Tasks. Test if the user cannot change the Obligation Status to "Post" manually
//     //   04. Job Tasks. Test if the user can change the Obligation Status to "Post" using calculation routine
//     //   05. Job Tasks. Test if the user cannot change the Obligation Status to "Calculated" if no Planning Lines
//     //   06. Job Tasks. Test if the user can change the Obligation Status to "Calculated" if Planning Lines exist
//     //   07. Job Tasks. Test if the user cannot change the Obligation Status to "Ready to Post" if no Planning Lines
//     //   08. Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if Planning Lines exist
//     //   09. Job Tasks. Test if a confirmation is displayed when Obligation Status is set to "Ready to Post" and the Planning Lines exists
//     //   10. Job Tasks. Test if Assigned Job No. is filled in when the Sales Invoice is created from Job Task
//     //   11. Job Tasks HEX. Test if Assigned Job No. is filled in when the Sales Order is created from Job Task
//     //   12. Job Tasks HEX. Test if Assigned Job No. is filled in when the Sales Credit is created from Job Task
//     //   13. Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if any of Planning Lines with type Item do not have Location Code
//     //   14. Sales Document. Test if Assigned Job No. is transfered to posted document
//     //   15. Sales Document. Test if Assigned Job No. is copied to other sales document using "Copy Document" functionality
//     //   16. Job Planning Line. Check if manual change of IFRS15 Amount will set the Obligation Status to '' (Blank)
//     //   17. Job Tasks. Test if the user can change the Obligation Status to "Ready to Post" if any of Planning Lines with type other than Item do not have Location Code
//     //   18. Job Planning Line. Check if insert new planning line will set the Obligation Status to '' (Blank)
//     //   19. Job Planning Line. Check if delete planning line will set the Obligation Status to '' (Blank)
//     // }
//     // END.
// }
// }
