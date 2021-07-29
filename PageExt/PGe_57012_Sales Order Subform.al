pageextension 57012 "Hex Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        //addlast()
        addafter("Shipment Date")
        {
            field("Smax Line No."; "Smax Line No.")
            {
                Editable = false;
            }
            field("Order Created"; "Order Created")
            {
                Editable = false;
            }
            field("Order Inserted"; "Order Inserted")
            {
                Editable = false;
            }
            field("Ready to Invoice"; "Ready to Invoice")
            {
                Editable = true;
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