pageextension 57012 "Hex Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        //addlast()
        addafter("Shipment Date")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Editable = true;
            }
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
            field("Job No."; "Job No.")
            { }
            field("Job Planning Line No."; "Job Planning Line No.")
            { }
            field("Job Task No."; "Job Task No.") { }
            field("VAT Identifier"; "VAT Identifier")
            {
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