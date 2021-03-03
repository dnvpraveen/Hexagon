page 55030 HexInventoryBalance
{
    Caption = 'HexInventoryBalance';
    PageType = List;
    SourceTable = HexInventoryBalance;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field(ERPCompanyNo; ERPCompanyNo)
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Serial No."; "Serial No.")
                {
                }
                field("Lot No."; "Lot No.")
                {
                }
                field(Status; Status)
                {
                }
                field(Message; Message)
                {
                }
                field(ModifyDate; ModifyDate)
                {
                }
                field(TargetSystem; TargetSystem)
                {
                }
            }
        }
    }

    actions
    {
    }
}

