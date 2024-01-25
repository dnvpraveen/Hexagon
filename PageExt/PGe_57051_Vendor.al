pageextension 57051 VendorPagExt extends "Vendor Card"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("G/L Purchase Account"; Rec."Purchase G/L Account") { }

        }
    }
}
