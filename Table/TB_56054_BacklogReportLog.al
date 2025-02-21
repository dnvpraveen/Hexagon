table 56054 "Update Product CAT"
{
    Caption = 'Update Product CAT';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Codigo de Producto"; code[50])
        {
            Caption = 'Codigo Producto';
            TableRelation = Item."No.";
        }
        field(2; "Product CAT Code"; code[50])
        {
            Caption = 'Codigo Product CAT';

        }
    }
    keys
    {
        key(PK; "Codigo de Producto")
        {
            Clustered = true;
        }
    }
}
