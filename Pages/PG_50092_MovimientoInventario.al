page 50092 "Movimiento Inventario"
{
    ApplicationArea = All;
    Caption = 'Movimiento Inventario';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    UsageCategory = Lists;
    Permissions = tabledata "Item Ledger Entry" = rmid;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("AkkOn-Entry/Exit Date"; Rec."AkkOn-Entry/Exit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AkkOn-Entry/Exit Date field.';
                }
                field("AkkOn-Entry/Exit No."; Rec."AkkOn-Entry/Exit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AkkOn-Entry/Exit No. field.';
                }
                field("Applied Entry to Adjust"; Rec."Applied Entry to Adjust")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applied Entry to Adjust field.';
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Entry field.';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field("Assemble to Order"; Rec."Assemble to Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assemble to Order field.';
                }
                field("Completely Invoiced"; Rec."Completely Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completely Invoiced field.';
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Actual) field.';
                }
                field("Cost Amount (Actual) (ACY)"; Rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Actual) (ACY) field.';
                }
                field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Expected) field.';
                }
                field("Cost Amount (Expected) (ACY)"; Rec."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Expected) (ACY) field.';
                }
                field("Cost Amount (Non-Invtbl.)"; Rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Non-Invtbl.) field.';
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Amount (Non-Invtbl.)(ACY) field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Derived from Blanket Order"; Rec."Derived from Blanket Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Derived from Blanket Order field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drop Shipment field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry/Exit Point field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoiced Quantity field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Tracking"; Rec."Item Tracking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Tracking field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Job Purchase"; Rec."Job Purchase")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Purchase field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                }
                field("Last Invoice Date"; Rec."Last Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Invoice Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nonstock field.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Open field.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Type field.';
                }
                field("Original Order No."; Rec."Original Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Original Order No. field.';
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Originally Ordered No. field.';
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Originally Ordered Var. Code field.';
                }
                field("Out-of-Stock Substitution"; Rec."Out-of-Stock Substitution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Out-of-Stock Substitution field.';
                }
                field("Parts Order No."; Rec."Parts Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parts Order No. field.';
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positive field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Line No. field.';
                }
                field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
                }
                field("Purchase Amount (Expected)"; Rec."Purchase Amount (Expected)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Amount (Expected) field.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserved Quantity field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Amount (Actual) field.';
                }
                field("Sales Amount (Expected)"; Rec."Sales Amount (Expected)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Amount (Expected) field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Shipped Qty. Not Returned"; Rec."Shipped Qty. Not Returned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipped Qty. Not Returned field.';
                }
                field("Shpt. Method Code"; Rec."Shpt. Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shpt. Method Code field.';
                }
                field("Smax Order No."; Rec."Smax Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Smax Order No. field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Type field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Specification field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Method field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Warranty Date field.';
                }
                field("Zero Value Order"; Rec."Zero Value Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zero Value Order field.';
                }
            }
        }
    }
}
