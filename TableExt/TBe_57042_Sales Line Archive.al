tableextension 57042 "hex Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        // Add changes to table fields here
        field(50007; "Doc. Line Discount %_HGN"; Decimal)
        {
            CaptionML = ENU = 'Doc. Line Discount %';
        }
        field(50008; "Doc. Line Amount_HGN"; Decimal)
        {
            CaptionML = ENU = 'Doc. Line Discount %';
        }
        field(50011; "Doc. Unit Price_HGN"; Decimal)
        {
            Caption = 'Doc. Unit Price_HGN';
            DataClassification = CustomerContent;
        }
        field(50012; "Doc. Qty_HGN"; Decimal)
        {
            Caption = 'Doc. Qty_HGN';
            DataClassification = CustomerContent;
        }
        field(50013; "Doc. VAT %_HGN"; Decimal)
        {
            Caption = 'Doc. VAT %_HGN';
            DataClassification = CustomerContent;
        }
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';
        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55006; "Order Type"; Code[10])
        {
            Description = 'Order Type';
        }
        field(55007; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';
        }
        field(55008; "Ready to Invoice"; Boolean)
        {
            Description = 'Ready to Invoice';
        }
        field(55011; "Line Status"; Text[30])
        {
            Description = 'Line Status';
        }
    }


}