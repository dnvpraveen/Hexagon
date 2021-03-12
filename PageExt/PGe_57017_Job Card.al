pageextension 57017 "Hex Job Card" extends "Job Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Opportunity No."; "Opportunity No.")
            {
                Caption = 'Opportunity No.';
            }
            field("CurrencyCode"; "Currency Code")
            {
                Caption = 'Currency Code';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    CurrencyCheck;
                end;
            }
            field("Order Type"; "Order Type")
            {
                Caption = 'Order Type';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    IF "Order Type" = "Order Type"::System THEN
                        fill := FALSE
                    ELSE
                        fill := TRUE;
                end;
            }
            Field("Product Serial No."; "Product Serial No.")
            {
                Caption = 'Product Serial No.';
                Editable = fill;
            }
        }

        addafter("% Invoiced")
        {
            field("Total Revenue to Recognize"; "Total Revenue to Recognize")
            {
                Caption = 'Total Revenue to Recognize';
            }
            field("Total Rev to Recognize (LCY)"; "Total Rev to Recognize (LCY)")
            {
                Caption = 'Total Rev to Recognize (LCY)';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("Plan&ning")
        {

            action(OrderPlanning)
            {
                ApplicationArea = Suite;
                Caption = 'Order Planning';
                RunObject = Page 5522;
                Image = "Order";

            }
            action(RevenueRecognistion)
            {
                ApplicationArea = Suite;
                Caption = 'Revenue Recognistion';
                Runobject = Report 50099;
                Image = "Order";


            }
        }
    }

    var
        fill: Boolean;


}