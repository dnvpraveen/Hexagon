table 56001 "Sales Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Description = 'Entry No';

        }
        field(10; "Posting Date"; Date)
        {
            Description = 'Posting date';
        }
        field(11; "Order No."; Code[20])
        {
            Description = 'Order No.';
        }

        field(13; "Line No."; Integer)
        {
            Description = 'Line No.';
        }
        field(19; Type; Option)
        {
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
            OptionCaptionML = ENU = '" ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)"';
            Description = 'Type';
        }
        field(20; "No."; Code[20])
        {
            Description = 'No.';
        }
        field(21; "Product Cat"; Code[20])
        {
            Description = 'Product Cat';
        }
        field(30; "Unit of Measure"; Code[10])
        {
            Description = 'Unit of Measure';
        }
        field(31; "Order Qty"; Decimal)
        {
            Description = 'Order Qty';
        }
        field(32; "Ship Qty"; Decimal)
        {
            Description = 'Ship Qty';
        }
        field(33; "Invoice Qty"; Decimal)
        {
            Description = 'Invoice Qty';
        }
        field(34; "Currency Code"; Code[10])
        {
            Description = 'Currency Code';
        }
        field(35; "Order Amount"; Decimal)
        {
            Description = 'Order Amount';
        }
        field(36; "Ship Amount"; Decimal)
        {
            Description = 'Ship Amount';
        }
        field(37; "Invoice Amount"; Decimal)
        {
            Description = 'Invoice Amount';
        }
        field(38; "Order Amount (LCY)"; Decimal)
        {
            Description = 'Order Amount (LCY)';
        }
        field(39; "Ship Amount (LCY)"; Decimal)
        {
            Description = 'Ship Amount (LCY)';
        }
        field(40; "Invoice Amount (LCY)"; Decimal)
        {
            Description = 'Invoice Amount (LCY)';
        }
        field(50; "Planned Shipment date"; Date)
        {
            Description = 'Planned Shipment date';
        }
        field(60; "Customer No."; Code[20])
        {
            Description = 'Customer No.';
        }
        field(61; "Vendor No."; Code[20])
        {
            Description = 'Vendor No.';
        }
        field(70; "Invoice No."; Code[20])
        {
            Description = 'Invoice No.';
        }
        field(71; "Bill-to Customer No."; Code[20])
        {
            Description = 'Bill-to Customer No.';
        }
        field(72; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        field(73; "Salesperson Code"; Code[10])
        {
            Description = 'Salesperson Code';
        }
        field(74; "Created By"; Code[50])
        {
            Description = 'Created By';
        }
        field(75; "Promised Delivery Date"; Date)
        {
            Description = 'Promised Delivery Date';
        }
        field(76; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
        }
        field(77; "Requested Delivery Date"; Date)
        {
            Description = 'Requested Delivery Date';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SIFTKeyOnCode; "Order No.", "Line No.")
        {
            //Clustered = true;
            SumIndexFields = "Order Qty", "Ship Qty", "Invoice Qty", "Order Amount", "Ship Amount", "Invoice Amount";
            MaintainSqlIndex = false;
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