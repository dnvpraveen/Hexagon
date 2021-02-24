table 56002 "Product Cat Hierarchy"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product Cat ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Product Cat ID';
        }
        field(2; "Parent Product Cat ID"; Code[20])
        {
            Description = 'Parent Product Cat ID';
        }
        field(10; name; Text[50])
        {
            Description = 'Name';
        }
        field(11; "Type"; Integer)
        {
            Description = 'Type';
        }
    }

    keys
    {
        key(PK; "Product Cat ID")
        {
            Clustered = true;
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