tableextension 57019 "Hex Company Information" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }
        field(50100; "Intercompany Partner Dim_HGN"; Code[20])
        {
            Caption = 'Intercompany Partner Dim';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(50101; "Product Category Dim_HGN"; Code[20])
        {
            Caption = 'Product Category Dim';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(50102; "Custom2 Dim (Country)_HGN"; Code[20])
        {
            Caption = 'Custom2 Dim (Country)';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(50103; "Cost Center Dim_HGN"; Code[20])
        {
            Caption = 'Cost Center Dim';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(50104; "Entity No._HGN"; Code[50])
        {
            Caption = 'Entity No.';
            DataClassification = CustomerContent;
        }
        field(50105; "Separat. for Fin Exp File_HGN"; Enum SeparatorType_HGN)
        {
            Caption = 'Separator for Fin Export File';
            DataClassification = CustomerContent;
        }
    }


}