pageextension 57017 "Hex Job Card" extends "Job Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        action(OrderPlanning)
        {
            ApplicationArea = Suite;
            Caption = 'Order Planning';
            RunObject =Page '5522';
            Image = "Order";

            trigger OnAction()
            begin
                CancelOrder;
            end;
        }
        action(RevenueRecognistion)
        {
            ApplicationArea = Suite;
            Caption = 'Revenue Recognistion';
            Runobject = Report 50099;
                            Image = "Order";

    trigger OnAction()
    begin
        ShortCloseOrder;
    end;
        }
    }

    var
        myInt: Integer;
}