pageextension 57011 "Hex Sales Order" extends "Sales Order"
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
            field("Order Created"; "Order Created")
            {
                Caption = 'Order Created';
            }
            field("Order Inserted"; "Order Inserted")
            {
                Caption = 'Order Inserted';
            }
            field("Action Code"; "Action Code")
            {
                Caption = 'Action Code';
            }
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("Release")
        {
            action(CancelOrder)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Order';
                Image = "Order";

                trigger OnAction()
                var
                    HexSMAX: Codeunit "Hex Smax Stage Ext";
                begin
                    HexSMAX.CancelOrder(Rec);
                end;
            }
            action(ShortCloseOrder)
            {
                ApplicationArea = Suite;
                Caption = 'Short Close Order';
                Image = "Order";

                trigger OnAction()
                var
                    HexSMAX: Codeunit "Hex Smax Stage Ext";
                begin
                    HexSMAX.ShortCloseOrder(Rec);
                end;
            }
        }


    }
}