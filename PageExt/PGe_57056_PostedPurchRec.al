pageextension 57056 PostedPurchRec extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Document Date")
        {
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

