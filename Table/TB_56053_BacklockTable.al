table 56053 Backlog_HGN
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50]) { DataClassification = CustomerContent; }
        field(2; "Sell-to Customer No."; Code[50]) { DataClassification = CustomerContent; }
        field(3; "Sell-to Customer Name"; Text[200]) { DataClassification = CustomerContent; }
        field(4; "External Document No."; Code[50]) { DataClassification = CustomerContent; }
        field(5; "PRODUCT CAT Code"; Code[50]) { DataClassification = CustomerContent; }
        field(6; "Document Date"; Date) { DataClassification = CustomerContent; }
        field(7; "Promised Delivery Date"; Date) { DataClassification = CustomerContent; }
        field(8; "Currency Code"; Code[50]) { DataClassification = CustomerContent; }
        field(9; "Amount"; Decimal) { DataClassification = CustomerContent; }
        field(10; "Amount LCY"; Decimal) { DataClassification = CustomerContent; }
        field(11; "Tipo Reporte"; Option)
        {
            OptionMembers = "Sales Line","Job Line","Deferral";
            DataClassification = SystemMetadata;
        }
        field(13; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(14; "Product CAT Name"; code[100])
        {
            Caption = 'Product CAT Name';
            DataClassification = ToBeClassified;
        }
        field(15; "Item Description"; code[100])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
        }
        field(16; "Item No."; code[100])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(17; "MTK Sector Name"; code[100])
        {
            Caption = 'MTK Sector Name';
            DataClassification = ToBeClassified;
        }
        field(18; "MTK Sector Code"; code[100])
        {
            Caption = 'MTK Sector Code';
            DataClassification = ToBeClassified;
        }
        field(19; Q1; Decimal)
        {
            Caption = 'Q1';
            DataClassification = ToBeClassified;
        }
        field(20; Q2; Decimal)
        {
            Caption = 'Q2';
            DataClassification = ToBeClassified;
        }
        field(21; Q3; Decimal)
        {
            Caption = 'Q3';
            DataClassification = ToBeClassified;
        }
        field(22; Q4; Decimal)
        {
            Caption = 'Q4';
            DataClassification = ToBeClassified;
        }
        field(23; NextYear; Decimal)
        {
            Caption = 'Next Year';
            DataClassification = ToBeClassified;
        }
        field(24; "Fecha Generacion"; date)
        {
            Caption = 'Next Year';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }


}
