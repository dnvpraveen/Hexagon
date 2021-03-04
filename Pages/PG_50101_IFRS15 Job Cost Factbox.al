// page 50101 "IFRS15 Job Cost Factbox"
// {
//     // TM TF IFRS15 29/06/18 'IFRS15 Services'
//     //   Object created

//     Caption = 'Job Details';
//     Editable = false;
//     LinksAllowed = false;
//     PageType = CardPart;
//     SourceTable = Job;

//     layout
//     {
//         area(content)
//         {
//             field("No."; "No.")
//             {
//                 Caption = 'Job No.';
//                 ToolTip = 'Specifies the job number.';

//                 trigger OnDrillDown()
//                 begin
//                     ShowDetails;
//                 end;
//             }
//             group("Budget Cost")
//             {
//                 Caption = 'Budget Cost';
//                 field(PlaceHolderLbl; PlaceHolderLbl)
//                 {
//                     Editable = false;
//                     Enabled = false;
//                     ToolTip = 'Specifies nothing.';
//                     Visible = false;
//                 }
//                 field(ScheduleCostLCY; CL[1])
//                 {
//                     Caption = 'Resource';
//                     Editable = false;
//                     ToolTip = 'Specifies the total budgeted cost of resources associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 1, TRUE);
//                     end;
//                 }
//                 field(ScheduleCostLCYItem; CL[2])
//                 {
//                     Caption = 'Item';
//                     Editable = false;
//                     ToolTip = 'Specifies the total budgeted cost of items associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 2, TRUE);
//                     end;
//                 }
//                 field(ScheduleCostLCYGLAcc; CL[3])
//                 {
//                     Caption = 'G/L Account';
//                     Editable = false;
//                     ToolTip = 'Specifies the total budgeted cost of general journal entries associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 3, TRUE);
//                     end;
//                 }
//                 field(ScheduleCostLCYTotal; CL[4])
//                 {
//                     Caption = 'Total';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ToolTip = 'Specifies the total budget cost of a job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 0, TRUE);
//                     end;
//                 }
//             }
//             group("Actual Cost")
//             {
//                 Caption = 'Actual Cost';
//                 field(PlaceHolderLbl; PlaceHolderLbl)
//                 {
//                     Editable = false;
//                     Enabled = false;
//                     ToolTip = 'Specifies nothing.';
//                     Visible = false;
//                 }
//                 field(UsageCostLCY; CL[5])
//                 {
//                     Caption = 'Resource';
//                     Editable = false;
//                     ToolTip = 'Specifies the total usage cost of resources associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 1, TRUE);
//                     end;
//                 }
//                 field(UsageCostLCYItem; CL[6])
//                 {
//                     Caption = 'Item';
//                     Editable = false;
//                     ToolTip = 'Specifies the total usage cost of items associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 2, TRUE);
//                     end;
//                 }
//                 field(UsageCostLCYGLAcc; CL[7])
//                 {
//                     Caption = 'G/L Account';
//                     Editable = false;
//                     ToolTip = 'Specifies the total usage cost of general journal entries associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 3, TRUE);
//                     end;
//                 }
//                 field(UsageCostLCYTotal; CL[8])
//                 {
//                     Caption = 'Total';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ToolTip = 'Specifies the total costs used for a job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 0, TRUE);
//                     end;
//                 }
//             }
//             group("Billable Price")
//             {
//                 Caption = 'Billable Price';
//                 field(PlaceHolderLbl; PlaceHolderLbl)
//                 {
//                     Editable = false;
//                     Enabled = false;
//                     ToolTip = 'Specifies nothing.';
//                     Visible = false;
//                 }
//                 field(BillablePriceLCY; PL[9])
//                 {
//                     Caption = 'Resource';
//                     Editable = false;
//                     ToolTip = 'Specifies the total billable price of resources associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 1, FALSE);
//                     end;
//                 }
//                 field(BillablePriceLCYItem; PL[10])
//                 {
//                     Caption = 'Item';
//                     Editable = false;
//                     ToolTip = 'Specifies the total billable price of items associated with this job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 2, FALSE);
//                     end;
//                 }
//                 field(BillablePriceLCYGLAcc; PL[11])
//                 {
//                     Caption = 'G/L Account';
//                     Editable = false;
//                     ToolTip = 'Specifies the total billable price for job planning lines of type G/L account.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 3, FALSE);
//                     end;
//                 }
//                 field(BillablePriceLCYTotal; PL[12])
//                 {
//                     Caption = 'Total';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ToolTip = 'Specifies the total billable price used for a job.';

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(1, 0, FALSE);
//                     end;
//                 }
//             }
//             group("Invoiced Price")
//             {
//                 Caption = 'Invoiced Price';
//                 Visible = false;
//                 field(PlaceHolderLbl; PlaceHolderLbl)
//                 {
//                     Editable = false;
//                     Enabled = false;
//                     ToolTip = 'Specifies nothing.';
//                     Visible = false;
//                 }
//                 field(InvoicedPriceLCY; PL[13])
//                 {
//                     Caption = 'Resource';
//                     Editable = false;
//                     ToolTip = 'Specifies the total invoiced price of resources associated with this job.';
//                     Visible = false;

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 1, FALSE);
//                     end;
//                 }
//                 field(InvoicedPriceLCYItem; PL[14])
//                 {
//                     Caption = 'Item';
//                     Editable = false;
//                     ToolTip = 'Specifies the total invoiced price of items associated with this job.';
//                     Visible = false;

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 2, FALSE);
//                     end;
//                 }
//                 field(InvoicedPriceLCYGLAcc; PL[15])
//                 {
//                     Caption = 'G/L Account';
//                     Editable = false;
//                     ToolTip = 'Specifies the total invoiced price of general journal entries associated with this job.';
//                     Visible = false;

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 3, FALSE);
//                     end;
//                 }
//                 field(InvoicedPriceLCYTotal; PL[16])
//                 {
//                     Caption = 'Total';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ToolTip = 'Specifies the total invoiced price of a job.';
//                     Visible = false;

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowLedgEntry(1, 0, FALSE);
//                     end;
//                 }
//             }
//             group("Revenue Recognised")
//             {
//                 Caption = 'Revenue Recognised';
//                 field(PlaceHolderLbl; PlaceHolderLbl)
//                 {
//                     Editable = false;
//                     Enabled = false;
//                     ToolTip = 'Specifies nothing.';
//                     Visible = false;
//                 }
//                 field(RevenueRecognised; RevenueRecognised)
//                 {
//                     Caption = 'Revenue Recognised Amount';
//                     Editable = false;

//                     trigger OnDrillDown()
//                     begin
//                         JobCalcStatistics.ShowPlanningLine(99999, 0, FALSE);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         CLEAR(JobCalcStatistics);
//         JobCalcStatistics.JobCalculateCommonFilters(Rec);
//         JobCalcStatistics.CalculateAmounts;
//         JobCalcStatistics.GetLCYCostAmounts(CL);
//         JobCalcStatistics.GetLCYPriceAmounts(PL);
//         CalcRevenueRecognised(Rec);
//     end;

//     var
//         JobCalcStatistics: Codeunit 1008;
//         PlaceHolderLbl: Label 'Placeholder';
//         CL: array[16] of Decimal;
//         PL: array[16] of Decimal;
//         RevenueRecognised: Decimal;

//     local procedure ShowDetails()
//     begin
//         PAGE.RUN(PAGE::"Job Card", Rec);
//     end;

//     local procedure CalcRevenueRecognised(var Job: Record 167)
//     var
//         JobTask: Record 1001;
//     begin
//         CLEAR(RevenueRecognised);
//         //WITH JobTask DO BEGIN
//         JobTask.SETRANGE("Job No.", Job."No.");
//         JobTask.SETRANGE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Posted);
//         JobTask.SETAUTOCALCFIELDS("IFRS15 Line Amount");
//         IF FINDSET THEN
//             REPEAT
//                 RevenueRecognised += JobTask."IFRS15 Line Amount";
//             UNTIL NEXT = 0;
//         //END;
//     end;
// }

