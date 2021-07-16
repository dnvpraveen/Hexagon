page 55013 "Sales Invoice Line ACK"
{
    PageType = ListPart;
    SourceTable = "Sales Invoice Line_Ack";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
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
                field("Location Code"; "Location Code")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Job No."; "Job No.")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Smax Line No."; "Smax Line No.")
                {
                }
                field("Action Code"; "Action Code")
                {
                }
                field("Order Created"; "Order Created")
                {
                }
            }
        }
    }

    actions
    {
    }
}

