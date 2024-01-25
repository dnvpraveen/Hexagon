tableextension 57054 VendorExt extends Vendor
{
    fields
    {
        field(50001; "Purchase G/L Account"; Code[20])
        {
            Caption = 'Purchase G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = filter(Posting));
        }

        field(50002; "Dividir Factura"; Boolean)
        {
            Caption = 'Dividir Valor Factura';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = filter(Posting));
        }
    }
}
