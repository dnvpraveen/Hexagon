tableextension 57042 "hex Sales Line Archive" extends "Sales Line Archive"
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
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
    }

    var
}