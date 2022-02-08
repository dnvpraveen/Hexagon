pageextension 57048 "Hex Vendor List" extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Fax No.")
        {
            //  field()
            //{ }
            field("VAT Registration No."; "VAT Registration No.")
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