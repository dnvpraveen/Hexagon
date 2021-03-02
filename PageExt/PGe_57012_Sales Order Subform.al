pageextension 57012 "Hex Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addlast(Content)
        {
            field("Smax Line No."; "Smax Line No.")
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