table 50102 "Financial Data Exp. Buffer_HGN"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(4; "Intercompany Partner"; Code[20])
        {
            Caption = 'Intercompany Partner';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(5; "Product Cat"; Code[20])
        {
            Caption = 'Product Cat';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(6; "Custom2 Dim"; Code[20])
        {
            Caption = 'Custom2 Dim';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(7; "Cost Center Dim"; Code[20])
        {
            Caption = 'Cost Center Dim';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(20; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = CustomerContent;
        }
        field(21; "Initial Balance"; Decimal)
        {
            Caption = 'Initial Balance';
            DataClassification = CustomerContent;
        }
        field(22; "Net Change"; Decimal)
        {
            Caption = 'Net Change';
            DataClassification = CustomerContent;
        }
        field(23; "Balance at Date"; Decimal)
        {
            Caption = 'Balance at Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Year, Month, "G/L Account No.", "Intercompany Partner", "Product Cat", "Custom2 Dim", "Cost Center Dim")
        {
            Clustered = true;
        }
    }
}

