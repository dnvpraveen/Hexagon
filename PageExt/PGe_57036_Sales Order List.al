pageextension 57036 "Hex Sales Order List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Quote No.")
        {
            field("Work Order No."; "Work Order No.")
            {
            }
            field("Order Type"; "Order Type")
            {
            }
        }
        addafter("Posting Date")
        {
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {

            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

}