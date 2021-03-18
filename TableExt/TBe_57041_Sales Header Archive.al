tableextension 57041 "Hex Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Order Type"; Code[10])
        {
            Description = 'Order Type';
        }
        field(55001; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';
        }
        field(55002; "User Email"; Text[50])
        {
            Description = 'User Email';
        }
        field(55003; "Ship-to Freight"; Text[30])
        {
            Description = 'Ship-to Freight';
        }
        field(55004; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55008; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(60000; "Cancel / Short Close"; Option)
        {
            Description = 'Cancel / Short Close';
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = ,Cancelled,"Short Closed";
            Editable = false;
        }
    }

    var
        myInt: Integer;
}