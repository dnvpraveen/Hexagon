tableextension 57034 "Hex Transfer Shipment Header" extends "Transfer Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Sell-to Customer No."; Code[20])
        {
            Description = 'Sell-to Customer No.';
        }
        field(55002; "Order Type"; Code[2])
        {
            Description = 'Order Type';
        }
        field(55005; "Sell-to Customer Name"; Text[50])
        {
            Description = 'Sell-to Customer Name';
        }
        field(55008; "Original Order No."; Text[35])
        {
            Description = 'Original Order No.';
        }
        field(55009; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }

        field(55012; "Target System"; Text[30])
        {
            Description = 'Target System';
        }
        field(55013; "Smax Order No."; Text[35])
        {
            Description = 'Smax Order No.';
        }
        field(55014; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55016; "Parts Order No."; Text[30])
        {
            Description = 'Parts Order No.';
        }

        field(55018; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55019; "Order Disptached"; Boolean)
        {
            Description = 'Order Disptached';
        }
        field(55020; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }

        field(55021; "Integration Completed"; Boolean)
        {
            Description = 'Integration Completed';
        }
        field(55022; "Header Status"; Option)
        {
            Description = 'Header Status';
            OptionMembers = " ",Closed,Shipped,"Partially Shipped",Completed;
            OptionCaption = '  ,Closed,Shipped,Partially Shipped,Completed';
        }
        // field(55025; "Sales Order No."; Code[20])
        //{
        //  Description = 'Sales Order No.';
        //}
        field(55023; "Ship-to Address"; Text[50])
        {
            Description = '"Ship-to Address"';
        }
        field(55024; "Ship-to Address2"; Text[50])
        {
            Description = 'Ship-to Address2';
        }
        field(55025; "Ship-to City"; Code[30])
        {
            Description = 'Ship-to City';
        }
        field(55026; "Ship-to Country"; Code[10])
        {
            Description = 'Ship-to Country';
        }
        field(55027; "Ship-to State"; Code[10])
        {
            Description = 'Ship-to State';
        }
        field(55028; "Zip Code"; Code[10])
        {
            Description = 'Zip Code';
        }
    }

    var
        myInt: Integer;
}