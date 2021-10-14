pageextension 57043 "Hex Deferral Template Card" extends "Deferral Template Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Deferral Account")
        {
            field("P&L Deferral Account"; "P&L Deferral Account")
            {
                Editable = true;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}