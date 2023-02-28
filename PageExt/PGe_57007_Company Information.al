pageextension 57007 "Hex Company Information" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("ERP Company No."; "ERP Company No.")
            {
                Caption = 'ERP Company No.';
            }
        }
        addafter(Shipping)
        {
            group("Financial Reporting File")
            {
                field("Intercompany Partner Dim_HGN"; "Intercompany Partner Dim_HGN")
                {
                    Caption = 'Intercompany Partner Dim';
                }
                field("Product Category Dim_HGN"; "Product Category Dim_HGN")
                {
                    Caption = 'Product Category Dim';
                }
                field("Custom2 Dim (Country)_HGN"; "Custom2 Dim (Country)_HGN")
                {
                    Caption = 'Custom2 Dim (Country)';
                }
                field("Cost Center Dim_HGN"; "Cost Center Dim_HGN")
                {
                    Caption = 'Cost Center Dim';
                }
                field("Entity No._HGN"; "Entity No._HGN")
                {
                    Caption = 'Entity No';
                }
                field("Separat. for Fin Exp File_HGN"; "Separat. for Fin Exp File_HGN")
                {
                    Caption = 'Separat. for Fin Exp File';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}