tableextension 57035 "Hex Transfer Shipment Line" extends "Transfer Shipment Line"
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
        field(55002; "Line Status"; Option)
        {
            Description = 'Line Status';
            OptionMembers = " ",Closed,Shipped,"Partially shipped",Completed;
            OptionCaption = ' ,Closed,Shipped,Partially shipped,Completed';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55006; "Order Dispatched"; Boolean)
        {
            Description = 'Order Dispatched';
        }
    }

}