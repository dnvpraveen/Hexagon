pageextension 57040 "Hex Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
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