
table 56003 "Hyperion Account"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Code';

        }
        field(5; "Type"; Option)
        {
            OptionMembers = Leaf,Total;
        }
        field(10; "Parent Code"; code[20])
        {
            Description = 'Parent Code';
        }
        field(11; Name; text[50])
        {
            Description = 'Name';
        }
        field(20; "G/L Account Range"; Text[250])
        {
            Description = 'G/L Account Range';
        }
        field(21; "Cost Centre Range"; text[250])
        {
            Description = 'Cost Centre Range';
        }
    }

    keys
    {
        key(pk; "Code")
        {
            Clustered = true;
        }
        key("Hyperion Account"; "type")
        {
            Unique = true;

        }
    }

    var
        myInt: Integer;

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