page 50001 "Purch. Line Inspection List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            field(gtxtMessage; gtxtMessage)
            {
            }
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {

                    trigger OnValidate()
                    begin
                        VALIDATE("Qty. to Receive", gdecQtyToReceive);
                    end;
                }
                field("Bin Code"; "Bin Code")
                {

                    trigger OnValidate()
                    begin
                        VALIDATE("Qty. to Receive", gdecQtyToReceive);
                    end;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        gdecQtyToReceive := "Qty. to Receive";
    end;

    trigger OnOpenPage()
    begin
        gtxtMessage := 'Inspection is required for the following items';
    end;

    var
        gtxtMessage: Text[100];
        gdecQtyToReceive: Decimal;
}

