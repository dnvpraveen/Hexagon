pageextension 57058 PurchaseLineEXT extends "Purchase Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Sales Order"; Rec."Sales Order")
            {
                ApplicationArea = all;
            }
            field(CustomerName; SalesHeader."Sell-to Customer Name")
            {
                Caption = 'Sales Order Customer Name';
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    var



    begin
        Clear(SalesHeader);
        if SalesHeader.get(SalesHeader."Document Type"::Order, rec."Sales Order") then;

    end;

    var
        SalesHeader: Record "Sales Header";
}
