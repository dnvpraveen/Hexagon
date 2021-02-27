tableextension 57023 "Hex Sales Line" extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';
        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55004; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55006; "Order Type"; Code[10])
        {
            Description = 'Order Type';
        }
        field(55007; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';
        }
        field(55008; "Ready to Invoice"; Boolean) { }
    }

    var
        myInt: Integer;
}