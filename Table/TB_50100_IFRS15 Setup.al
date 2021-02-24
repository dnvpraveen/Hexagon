table 50100 "IFRS15 Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Description = 'Primary Key';
        }
        field(20; "IFRS15 Active"; Boolean)
        {
            Description = 'IFRS15 Active';
        }
        field(30; "Revenue Recognition Account"; Code[20])
        {
            Description = 'Revenue Recognition Account';
            TableRelation = "G/L Account";
        }


        field(40; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Description = 'Source Code';

        }
        field(50; "Recognise Revenue Confirm. Msg"; Text[250])
        {
            Description = 'Recognise Revenue Confirmation Message';
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