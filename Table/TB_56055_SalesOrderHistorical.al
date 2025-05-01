table 56055 SalesOrderHistorical
{
    Caption = 'SalesOrderHistorical';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }

        field(3; week; Integer)
        {
            Caption = 'Week';
            DataClassification = ToBeClassified;
        }
        field(4; Month; Text[50])
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
        field(5; Account; Text[200])
        {
            Caption = 'Account';
            DataClassification = ToBeClassified;
        }

        field(6; CustomerPO; Text[200])
        {
            Caption = 'Account';
            DataClassification = ToBeClassified;
        }

        field(7; Currency; code[50])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(8; "Order Amount"; Decimal)
        {
            Caption = 'Order Amount';
            DataClassification = ToBeClassified;
        }

        field(9; "Amount USD"; Decimal)
        {
            Caption = 'Amount USD';
            DataClassification = ToBeClassified;
        }

        field(10; "Amount MXN"; Decimal)
        {
            Caption = 'Amount MXN';
            DataClassification = ToBeClassified;
        }

        field(11; "Produc CAT"; code[50])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }

        field(12; "Produc CAT Name"; Text[100])
        {
            Caption = 'Product CAT Name';
            DataClassification = ToBeClassified;
        }

        field(13; Grupo; Text[100])
        {
            Caption = 'Product CAT Name';
            DataClassification = ToBeClassified;
        }
        field(14; "SAT type"; Text[100])
        {
            Caption = 'SAT Type';
            DataClassification = ToBeClassified;
        }
        field(15; "MKT Sector Code"; Text[100])
        {
            Caption = 'MKT Sector Code';
            DataClassification = ToBeClassified;
        }

        field(16; "MKT Sector Name"; Text[100])
        {
            Caption = 'MKT Sector Name';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
