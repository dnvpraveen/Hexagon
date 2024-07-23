pageextension 57057 PurchaseOrderExt extends "Purchase Order List"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.") { }
            field("AkkOn-SAT UUID stamp"; Rec."AkkOn-SAT UUID stamp") { }
        }
    }
}
