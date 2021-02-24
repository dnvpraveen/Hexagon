table 56004 "Hyperion Account Members"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "G/L Account"; code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'G/L Account';

        }
        field(2; "Cost Centre"; code[20])
        {
            Description = 'Cost Centre';
        }
        field(10; "Hyperion Account"; code[20])
        {
            Description = 'Hyperion Account';
        }

    }

    keys
    {
        key(PK; "G/L Account", "Cost Centre")
        {
            Clustered = true;
        }
        key("Hyperion Account Members"; "Hyperion Account")
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