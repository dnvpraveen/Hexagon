pageextension 50012 PurchaseInvoicesExt extends "Purchase Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("AkkOn-SAT UUID stamp"; Rec."AkkOn-SAT UUID stamp") { }
        }
    }
}