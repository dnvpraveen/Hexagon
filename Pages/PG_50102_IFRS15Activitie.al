page 50102 "IFRS15 Activities"
{
    Caption = 'IFRS15 Activities';
    PageType = CardPart;
    SourceTable = "IFRS15 Cue";

    layout
    {
        area(content)
        {
            cuegroup("Perf. Obligation Status")
            {
                Caption = 'Perf. Obligation Status';
                field("Perf. Oblig Status Blank"; "Perf. Oblig Status Blank")
                {
                    Caption = 'Blank';

                    trigger OnDrillDown()
                    var
                        JobTaskLinesPage: Page "Job Task Lines";
                        JobTask: Record "Job Task";
                    begin
                        JobTask.RESET;
                        JobTask.FILTERGROUP(2);
                        JobTask.SETRANGE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::" ");
                        JobTask.SETRANGE("Job Task Type", JobTask."Job Task Type"::Posting);
                        JobTask.FILTERGROUP(0);
                        JobTaskLinesPage.CAPTION := JobTaskLinesPage.CAPTION + ' - ' + JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status") + ': ' + FORMAT(JobTask."IFRS15 Perf. Obligation Status"::" ");
                        JobTaskLinesPage.SETTABLEVIEW(JobTask);
                        JobTaskLinesPage.RUNMODAL;
                    end;
                }
                field("Perf. Oblig Status Calc"; "Perf. Oblig Status Calc")
                {
                    Caption = 'Calculated';

                    trigger OnDrillDown()
                    var
                        JobTaskLinesPage: Page "Job Task Lines";
                        JobTask: Record "Job Task";
                    begin
                        JobTask.RESET;
                        JobTask.FILTERGROUP(2);
                        JobTask.SETRANGE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Calculated);
                        JobTask.SETRANGE("Job Task Type", JobTask."Job Task Type"::Posting);
                        JobTask.FILTERGROUP(0);
                        JobTaskLinesPage.CAPTION := JobTaskLinesPage.CAPTION + ' - ' + JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status") + ': ' + FORMAT(JobTask."IFRS15 Perf. Obligation Status"::Calculated);
                        JobTaskLinesPage.SETTABLEVIEW(JobTask);
                        JobTaskLinesPage.RUNMODAL;
                    end;
                }
                field("Perf. Oblig Status ReadyToPost"; "Perf. Oblig Status ReadyToPost")
                {
                    Caption = 'Ready To Post';

                    trigger OnDrillDown()
                    var
                        JobTaskLinesPage: Page "Job Task Lines";
                        JobTask: Record "Job Task";
                    begin
                        JobTask.RESET;
                        JobTask.FILTERGROUP(2);
                        JobTask.SETRANGE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
                        JobTask.SETRANGE("Job Task Type", JobTask."Job Task Type"::Posting);
                        JobTask.FILTERGROUP(0);
                        JobTaskLinesPage.CAPTION := JobTaskLinesPage.CAPTION + ' - ' + JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status") + ': ' + FORMAT(JobTask."IFRS15 Perf. Obligation Status"::"Ready to Post");
                        JobTaskLinesPage.SETTABLEVIEW(JobTask);
                        JobTaskLinesPage.RUNMODAL;
                    end;
                }
                field("Perf. Oblig Status Posted"; "Perf. Oblig Status Posted")
                {
                    Caption = 'Posted';

                    trigger OnDrillDown()
                    var
                        JobTaskLinesPage: Page "Job Task Lines";
                        JobTask: Record "Job Task";
                    begin
                        JobTask.RESET;
                        JobTask.FILTERGROUP(2);
                        JobTask.SETRANGE("IFRS15 Perf. Obligation Status", JobTask."IFRS15 Perf. Obligation Status"::Posted);
                        JobTask.SETRANGE("Job Task Type", JobTask."Job Task Type"::Posting);
                        JobTask.FILTERGROUP(0);
                        JobTaskLinesPage.CAPTION := JobTaskLinesPage.CAPTION + ' - ' + JobTask.FIELDCAPTION("IFRS15 Perf. Obligation Status") + ': ' + FORMAT(JobTask."IFRS15 Perf. Obligation Status"::Posted);
                        JobTaskLinesPage.SETTABLEVIEW(JobTask);
                        JobTaskLinesPage.RUNMODAL;
                    end;
                }

                actions
                {
                    action("Job Revenue Recognition")
                    {
                        Caption = 'Job Revenue Recognition';

                        //RunObject = Report 50100;
                        trigger OnAction()
                        begin
                            Message('check the RunObject = Report 50100 report removed in AL');
                        end;
                    }
                }
            }
        }




    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;
}

