tableextension 57008 "Hex Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        //Description=IFRS15
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';

        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';

        }
        field(55006; "Order Type"; Code[10])
        {
            Description = 'Order Type';

        }
        field(55007; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';

        }

    }


}
