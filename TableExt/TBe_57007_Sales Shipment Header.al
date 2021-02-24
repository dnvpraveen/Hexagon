tableextension 57007 "Hex Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        //Description=IFRS15
        field(50100; "Assigned Job No."; Code[20])
        {
            Description = 'Assigned Job No.';

        }

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

    }


}