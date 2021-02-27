
table 55011 HexPriceBook
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            //AutoIncrement = false;
            Description = 'Entry No.';
        }
        field(2; ERPCompanyNo; Code[10])
        {
            Description = 'ERPCompanyNo';
        }
        field(10; "Item No."; Code[20])
        {
            Description = 'Item No.';
            NotBlank = true;
        }
        field(20; "Sales Code"; Code[20])
        {
            Description = 'Sales Code';
        }
        field(30; "Currency Code"; Code[10])
        {
            Description = 'Currency Code';
        }
        field(40; "Starting Date"; Date)
        {
            Description = 'Starting Date';
        }
        field(50; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
            MinValue = 0;
            AutoFormatType = 2;
        }
        field(70; "Price Includes VAT"; Boolean)
        {
            Description = 'Price Includes VAT';
        }
        field(100; "Allow Invoice Disc."; Boolean)
        {
            Description = 'Allow Invoice Disc.';
        }
        field(130; "Sales Type"; Option)
        {

            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
        }
        field(140; "Minimum Quantity"; Decimal)
        {

            Description = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(150; "Ending Date"; Date)
        {
            Description = 'Ending Date';
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Description = 'Unit of Measure Code';
        }
        field(5700; "Variant Code"; Code[10])
        {
            Description = 'Variant Code';
        }
        field(50009; Status; Option)
        {
            OptionMembers = New,Pending,Failure,Success;
            OptionCaption = '= New,Pending,Failure,Success';
        }
        field(50011; Created; Code[10])
        {
            Description = 'Created';
        }
        field(50012; "User ID"; Code[50])
        {
            ; TableRelation = User."User Name";
            Description = 'User ID';
        }
        field(50013; Message; Text[250])
        {
            Description = 'Message';
        }
        field(50018; ModifyDate; DateTime)
        {
            Description = 'ModifyDate';
        }
        field(50019; TargetSystem; Code[10])
        {
            Description = 'TargetSystem';
        }
    }

    keys
    {
        key(PK; "Entry No.", ERPCompanyNo)
        {
            Clustered = true;
        }
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