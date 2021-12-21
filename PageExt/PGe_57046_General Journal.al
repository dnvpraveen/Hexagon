pageextension 57046 "Hex General Journal" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("VAT %"; "VAT %")
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