pageextension 57032 "Hex Transfer Orders" extends "Transfer Orders"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Parts Order No."; "Parts Order No.")
            {
                Caption = 'Parts order No.';
            }
            field("Smax Order No."; "Smax Order No.")
            {
                Caption = 'Smax Order No.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}