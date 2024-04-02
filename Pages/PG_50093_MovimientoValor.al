page 50093 "Movimiento Valor"
{
    ApplicationArea = All;
    Caption = 'Movimiento Valor';
    PageType = List;
    SourceTable = "Value Entry";
    UsageCategory = Lists;
    Permissions = tabledata "Value Entry" = rimd;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Adjustment; Rec.Adjustment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Adjustment field.';
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Entry field.';
                }
                field("Average Cost Exception"; Rec."Average Cost Exception")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Average Cost Exception field.';
                }
                field("Capacity Ledger Entry No."; Rec."Capacity Ledger Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capacity Ledger Entry No. field.';
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
                field("Cost Posted to G/L"; Rec."Cost Posted to G/L")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Posted to G/L field.';
                }
                field("Cost Posted to G/L (ACY)"; Rec."Cost Posted to G/L (ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Posted to G/L (ACY) field.';
                }
                field("Cost per Unit"; Rec."Cost per Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost per Unit field.';
                }
                field("Cost per Unit (ACY)"; Rec."Cost per Unit (ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost per Unit (ACY) field.';
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
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discount Amount field.';
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
                field("Exp. Cost Posted to G/L (ACY)"; Rec."Exp. Cost Posted to G/L (ACY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exp. Cost Posted to G/L (ACY) field.';
                }
                field("Expected Cost"; Rec."Expected Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Cost field.';
                }
                field("Expected Cost Posted to G/L"; Rec."Expected Cost Posted to G/L")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Cost Posted to G/L field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
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
                field(Inventoriable; Rec.Inventoriable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventoriable field.';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoiced Quantity field.';
                }
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Charge No. field.';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Ledger Entry No. field.';
                }
                field("Item Ledger Entry Quantity"; Rec."Item Ledger Entry Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Ledger Entry Quantity field.';
                }
                field("Item Ledger Entry Type"; Rec."Item Ledger Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Ledger Entry Type field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Job Ledger Entry No."; Rec."Job Ledger Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Ledger Entry No. field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
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
                field("Partial Revaluation"; Rec."Partial Revaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Partial Revaluation field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
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
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason Code field.';
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
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Source Posting Group"; Rec."Source Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Posting Group field.';
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
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valuation Date field.';
                }
                field("Valued By Average Cost"; Rec."Valued By Average Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valued By Average Cost field.';
                }
                field("Valued Quantity"; Rec."Valued Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valued Quantity field.';
                }
                field("Variance Type"; Rec."Variance Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variance Type field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
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
