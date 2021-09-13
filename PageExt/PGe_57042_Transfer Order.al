pageextension 57042 "Hex Transfer Order" extends "Transfer Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Header Status"; "Header Status")
            {
                Editable = true;
            }
        }

        modify("Direct Transfer")
        {
            Editable = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}