table 55008 "Job Task Master_New"
{
    //DataClassification = ToBeClassified;
    //LookupPageId =
    fields
    {

        field(1; "Job Task Code"; Code[20])
        {
            Description = 'Job Task Code';
        }
        field(2; "Performance Obligation"; Text[50])
        {
            Description = 'Performance Obligation';
        }
        field(3; "Order Type"; Code[2])
        {
            Description = 'Order Type';
        }

        field(4; "Activity Type"; Option)
        {
            Description = 'Activity Type';
            OptionCaption = ' ,Purchase,Installation,Training,Programming,Warranty';
            OptionMembers = ,Purchase,Installation,Training,Programming,Warranty;
        }

    }


    keys
    {
        key(PK; "Job Task Code", "Performance Obligation")
        {
            Clustered = true;
        }
    }

    //   PROPERTIES
    //   {
    //     LookupPageID=Page50037;
    //     DrillDownPageID=Page50037;

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