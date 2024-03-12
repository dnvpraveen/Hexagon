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
        addafter(Name)
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
                Caption = 'E-Mail';
            }
            field("AkkOn-Customer email"; Rec."AkkOn-Customer email")
            {
                ApplicationArea = all;
                Caption = 'Contact email AkkOn';
            }
            field("AkkOn-SAT Fiscal Regim"; Rec."AkkOn-SAT Fiscal Regim")
            {
                ApplicationArea = all;
                Caption = 'Fiscal Regim';
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