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
    }

    actions
    {
        // Add changes to page actions here
    }


}