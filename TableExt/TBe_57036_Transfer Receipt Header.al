tableextension 57036 "Hex Transfer Receipt Header" extends "Transfer Receipt Header"
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
            OptionMembers = " ",Closed,Shipped,"Partially shipped",Completed;
            OptionCaption = '" ",Closed,Shipped,Partially shipped,Completed';
        }
        field(55025; "Sales Order No."; Code[20])
        {
            Description = 'Sales Order No.';
        }

    }

    var
        myInt: Integer;
}