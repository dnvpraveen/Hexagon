tableextension 57025 "Hex Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Exchange Rate Date"; Date)
        {
            Description = 'Exchange Rate Date';
        }
        field(50001; "Exch. Rate Table"; Code[20])
        {
            Description = 'Exch. Rate Table';
        }
        field(50002; "VAT Bank Account No."; Code[20])
        {
            Description = 'VAT Bank Account No.';
        }
        field(50003; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        field(50100; "Assigned Job No."; Code[20])
        {
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
        field(55008; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(60000; "Cancel / Short Close"; Option)
        {
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = ,Cancelled,"Short Closed";
            Description = 'Cancel / Short Close';
            Editable = false;
        }
        field(60001; "User Created"; Boolean)
        {
            Description = 'User Created';
        }
    }

    var
        myInt: Integer;

    trigger OnModify()
    var
        HexInventorySmax: Codeunit HexInventorySmax;
        HexCustomer: Record Customer;
    begin
        IF HexCustomer.GET(Rec."Sell-to Customer No.") THEN
            HexInventorySmax.HexCustomerCreditCheck(HexCustomer);//HEXSmax1
    end;
}