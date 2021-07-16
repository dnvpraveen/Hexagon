page 55012 "Sales Invoice header ACk"
{
    PageType = Document;
    SourceTable = "Sales Invoice Header_ACk";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("No."; "No.")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Order Created"; "Order Created")
                {
                }
                field("Order Inserted"; "Order Inserted")
                {
                }
                field("Ship-to Freight"; "Ship-to Freight")
                {
                }
                field("Order Type"; "Order Type")
                {
                }
                field("Work Order No."; "Work Order No.")
                {
                }
            }
            part("Sales Invoice Line ACK"; "Sales Invoice Line ACK")
            {
                //SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
    }
}

