pageextension 57041 "Hex Posted Transfer Shpt Subf" extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipping Time")
        {
            field("Line Status"; "Line Status")
            { }
            field("Smax Line No."; "Smax Line No.")
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