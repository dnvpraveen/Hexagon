pageextension 57015 "Hex Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addafter("Tax Group Code")
        {
            field("Sales Order"; Rec."Sales Order")
            {
                ApplicationArea = all;
            }
            field("To Stock"; Rec."To Stock")
            {
                ApplicationArea = all;
            }
            field("Quantity in SO"; Rec."Quantity in SO")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
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