table 56052 TempSalesDim
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Dimension Set ID"; Integer)
        {
            Description = 'Dimension Set ID';
        }
        field(2; "Dimension Code"; Code[20])
        {
            Description = 'Dimension Code';
        }
        field(3; "Dimension Value Code"; Code[20])
        {
            Description = 'Dimension Value Code';
        }
        field(4; "Dimension Value ID"; Integer)
        {
            Description = 'Dimension Value ID';
        }
        field(5; "Dimension Name"; Text[30])
        {
            Description = 'Dimension Name';
        }
        field(6; "Dimension Value Name"; Text[50])
        {
            Description = 'Dimension Value Name';
        }

        field(7; "Sales order no"; code[20])
        {

        }
    }
    keys
    {
        key(pk; "Dimension Set ID", "Dimension Code")
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