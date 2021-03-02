pageextension 57021 "Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Assigned Job No."; "Assigned Job No.")
            {
                Caption = 'Assigned Job No.';
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