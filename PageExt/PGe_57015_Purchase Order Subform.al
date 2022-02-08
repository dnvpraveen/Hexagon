pageextension 57015 "Hex Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            { }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}