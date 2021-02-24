table 56006 "Sales Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Description = 'Entry No.';
        }
        field(2; "Sales Order No."; Code[20])
        {
            Description = 'Sales Order No.';
        }
        field(3; "Sales Order Date"; Date)
        {
            Description = 'Sales Order Date';
        }
        field(4; "Request Delivery Date"; Date)
        {
            Description = 'Request Delivery Date';
        }
        field(5; "Document No."; Code[20])
        {
            Description = 'Document No.';
        }
        field(6; "Posting Date"; Date)
        {
            Description = 'Posting Date';
        }
        field(7; "Document Type"; Option)
        {
            OptionCaption = ' ,Invoice,CreditMemo';
            OptionMembers = ,Invoice,CreditMemo;
        }
        field(8; "Document Line No."; Integer)
        {
            Description = 'Document Line No.';
        }
        field(9; "G/L Account No."; Code[20])
        {
            Description = 'G/L Account No.';
        }
        field(10; "Customer No."; Code[20])
        {
            Description = 'Customer No.';
        }
        field(11; "Customer Name"; Text[50])
        {
            Description = 'Customer Name';
        }
        field(12; "Ship-to Name"; Text[50])
        {
            Description = 'Ship-to Name';
        }
        field(13; "Sell-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Description = 'Sell-to Country/Region Code';
        }
        field(14; "Location Code"; Code[10])
        {
            Description = 'Location Code';
        }
        field(15; "Product Cat"; Code[10])
        {
            Description = 'Product Cat';
        }
        field(16; "HM Location"; Code[10])
        {
            Description = 'HM Location';
        }
        field(17; "Currency Code"; Code[10])
        {
            Description = 'Currency Code';
        }
        field(18; "Currency Factor"; Decimal)
        {
            Description = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(19; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        field(20; "Item No."; Code[20])
        {
            Description = 'Item No.';
        }
        field(21; "Item Description"; Text[50])
        {
            Description = 'Item Description';
        }
        field(22; "Amount Excl Tax"; Decimal)
        {
            Description = 'Amount Excl Tax';
        }
        field(23; "Tax Amount"; Decimal)
        {
            Description = 'Tax Amount';
        }
        field(24; "Amount Incl Tax"; Decimal)
        {
            Description = 'Amount Incl Tax';
        }
        field(25; "VAT %"; Decimal)
        {
            Description = 'VAT %';
        }
        field(26; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            Description = 'Dimension Set ID';
            Editable = false;
        }
        field(27; "Inter Company"; Code[20])
        {
            Description = 'Inter Company';
        }
        field(28; "Cost Centre"; Code[10])
        {
            Description = 'Cost Centre';
        }
        field(29; "Sales Order Line No."; Integer)
        {
            Description = 'Sales Order Line No.';
        }
        // field(30; "Type"; Option)
        // {

        //     OptionCaption = ' , G/L Account, Item, Resource, Fixed Asset, Charge (Item)';
        //     OptionString = ,"G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        // }
        field(31; Filter; Code[15])
        {
            Description = 'Filter';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        //key()
        // {

        //}
        //  key("Document Type", "Document No.", "Document Line No.")
        //{

        //}
    }


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