pageextension 57033 "Hex Posted Transfer Shipments" extends "Posted Transfer Shipments"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Smax Order No."; "Smax Order No.")
            {
            }
            field("Parts Order No."; "Parts Order No.")
            {
            }
            field("External Document No."; "External Document No.")
            {
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
            }
            field("Sell-to Customer Name"; "Sell-to Customer Name")
            {
            }
            field("Header Status"; "Header Status")
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