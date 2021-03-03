page 50005 "Sales Log"
{
    // 
    // 
    // HEXG1016 -GMP 04112014- ICR 1016 sales log Bill to customer - GMP-  Bill to customer No field added to sales log table.

    Editable = false;
    PageType = List;
    SourceTable = "Sales Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Invoice No."; "Invoice No.")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Product Cat"; "Product Cat")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field("Order Qty"; "Order Qty")
                {
                }
                field("Ship Qty"; "Ship Qty")
                {
                }
                field("Invoice Qty"; "Invoice Qty")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Order Amount"; "Order Amount")
                {
                }
                field("Ship Amount"; "Ship Amount")
                {
                }
                field("Invoice Amount"; "Invoice Amount")
                {
                }
                field("Order Amount (LCY)"; "Order Amount (LCY)")
                {
                }
                field("Ship Amount (LCY)"; "Ship Amount (LCY)")
                {
                }
                field("Invoice Amount (LCY)"; "Invoice Amount (LCY)")
                {
                }
                field("Planned Shipment date"; "Planned Shipment date")
                {
                }
                field("Customer No."; "Customer No.")
                {
                }
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                }
                field("Created By"; "Created By")
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

