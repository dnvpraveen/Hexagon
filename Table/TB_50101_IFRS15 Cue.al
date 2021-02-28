table 50101 "IFRS15 Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Description = 'Primary Key';
        }
        field(2; "Perf. Oblig Status Blank"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Task" WHERE("IFRS15 Perf. Obligation Status" = filter(''), "Job Task Type" = CONST(Posting)));
            Description = 'Perf. Obligation Status is Blank';
        }
        field(3; "Perf. Oblig Status Calc"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Task" WHERE("IFRS15 Perf. Obligation Status" = CONST(Calculated), "Job Task Type" = CONST(Posting)));
            Description = 'Perf. Obligation Status is Calculated';
        }
        field(4; "Perf. Oblig Status ReadyToPost"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Task" WHERE("IFRS15 Perf. Obligation Status" = CONST("Ready to Post"), "Job Task Type" = CONST(Posting)));
            Description = 'Perf. Obligation Status is Ready To Post';
        }
        field(5; "Perf. Oblig Status Posted"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Task" WHERE("IFRS15 Perf. Obligation Status" = CONST(Posted), "Job Task Type" = CONST(Posting)));
            Description = 'Perf. Obligation Status is Posted';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}