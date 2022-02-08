pageextension 57047 "Hex Customer List" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter("CFDI Purpose")
        {
            field("AkkOn-Tax ID No."; "AkkOn-Tax ID No.")
            { }
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