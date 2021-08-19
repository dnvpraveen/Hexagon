pageextension 57040 "Hex Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }

        }
        addafter("Variant Code")
        {
            field("Smax Line No."; "Smax Line No.")
            {
                Description = 'Smax Line No.';
            }
            field("Action Code"; "Action Code")
            {
                Description = 'Action Code';
            }
            field("Line Status"; "Line Status")
            {
                Description = 'Line Status';
            }
            field("Order Created"; "Order Created")
            {
                Description = 'Order Created';
            }
            field("Order Inserted"; "Order Inserted")
            {
                Description = 'Order Inserted';

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