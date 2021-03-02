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
    }

    actions
    {
        // Add changes to page actions here
    }

}