tableextension 57030 "Job Task" extends "Job Task"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "IFRS15 Perf. Obligation Status"; Option)
        {
            Description = 'IFRS15 Perf. Obligation Status';

            OptionCaption = ' ,Calculated,Ready to Post,Posted';

            OptionMembers = " ",Calculated,"Ready to Post",Posted;
        }
        field(50101; "IFRS15 Process"; Boolean)
        {
            Description = 'IFRS15 Process';

            Editable = false;
        }
        field(50102; "IFRS15 Line Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."IFRS15 Line Amount" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))));
            Description = 'IFRS15 Line Amount';

            Editable = false;
            AutoFormatType = 2;
        }
        field(50103; "Deferral Template"; Code[10])
        {
            TableRelation = "Deferral Template"."Deferral Code";

            Description = 'Deferral Template';
        }
        field(50104; "Total Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Total Cost" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No.")));
            Description = 'Total Cost';

            BlankZero = true;

            Editable = false;
            AutoFormatType = 1;
        }
        field(50105; "IFRS15 Line Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."IFRS15 Line Amount (LCY)" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))));
            Description = 'IFRS15 Line Amount (LCY)';
            Editable = false;
            AutoFormatType = 2;
        }
        field(50106; "Total Cost (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Total Cost (LCY)" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No.")));
            Description = 'Total Cost (LCY)';

            BlankZero = true;

            Editable = false;
            AutoFormatType = 1;
        }
        field(55000; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
            Editable = false;
        }
        field(55002; "Opportunity No."; Code[10])
        {
            Description = 'Opportunity No.';
            Editable = false;
        }
        field(55003; "Activity Type"; Option)
        {
            Description = 'Activity Type';
            OptionCaption = '" ",Purchase,Installation,Training,Programming,Warranty';
            OptionMembers = " ",Purchase,Installation,Training,Programming,Warranty;
        }
        field(55004; "Performance Obligation"; Text[50])
        {
            Description = 'Performance Obligation';
            Editable = false;
        }
        field(55005; "Order Type"; Code[2])
        {
            Description = 'Order Type';
            Editable = false;
        }
        modify("Job Task No.")
        {
            trigger OnAfterValidate()
            var
                job: Record job;
                JobTaskMaster: Record "Job Task Master_New";
            begin
                Job.GET("Job No.");

                JobTaskMaster.RESET;
                JobTaskMaster.SETRANGE("Job Task Code", "Job Task No.");
                IF JobTaskMaster.FINDFIRST THEN BEGIN
                    VALIDATE("Performance Obligation", JobTaskMaster."Performance Obligation");
                    VALIDATE("Order Type", JobTaskMaster."Order Type");
                    VALIDATE("Activity Type", JobTaskMaster."Activity Type");
                    Validate(Description, JobTaskMaster."Performance Obligation");
                END ELSE
                    ERROR('Job Task No not exists in Job Task Master');
                //gk Smax1.0
                IF Job."Order Type" <> Job."Order Type"::System THEN
                    Job.TESTFIELD("Product Serial No.");
                "ERP Company No." := Job."ERP Company No.";
                "Opportunity No." := Job."Opportunity No.";
                //gk Smax1.0
            end;


        }
    }


}

