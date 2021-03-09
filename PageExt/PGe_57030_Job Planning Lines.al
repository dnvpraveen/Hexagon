pageextension 57030 "Hex Job Planning Lines" extends "Job Planning Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field(IP; IP)
            {
                Caption = 'IP';
            }
            field("Activity Type"; "Activity Type")
            {
                Caption = 'Activity Type';
            }
            field("Order Type"; "Order Type")
            {
                Caption = 'Order Type';
            }
            field("Warranty Start Date"; "Warranty Start Date")
            {
                Caption = 'Warranty start Date';
            }
            field("Warranty End Date"; "Warranty End Date")
            {
                Caption = 'Warranty End Date';
            }
            field("BOM Component"; "BOM Component")
            {
                Caption = 'OM Component';
            }
            field("ERP Company No."; "ERP Company No.")
            {
                Caption = 'ERP Company No.';
            }
            field("Opportunity No."; "Opportunity No.")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("Job Planning &Line")
        {

            action(HexPreview)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                Promoted = false;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()

                begin
                    //CreateGeneralJnlLine(Rec);
                    IFRSPreview.CreateGeneralJnlLine(Rec, "Job No.");
                end;
            }
        }
    }

    var
        myInt: Integer;
        JobTaskNo: Code[20];
        IFRSPreview: Codeunit "IFRS15 Mgt Rev";

    // trigger OnNewRecord(var Newre: Boolean)
    // var
    //     JobTask: Record "Job Task";
    // begin
    //     // TM TF IFRS15 06/07/18 Start
    //     IF JobTask.GET(JobNo, GETFILTER("Job Task No.")) THEN
    //         CurrPage.EDITABLE(NOT (JobTask."IFRS15 Perf. Obligation Status" = JobTask."IFRS15 Perf. Obligation Status"::Posted));
    //     // TM TF IFRS15 06/07/18 End
    // end;
    // //trigger 

    Local Procedure SetJobTaskNo(No: Code[20])
    begin
        // TM TF IFRS15 06/07/18 Start
        JobTaskNo := No;
        // TM TF IFRS15 06/07/18 End
    end;
}