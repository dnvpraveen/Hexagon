page 50090 "Sales Order Detail"
{
    Caption = 'Sales Order Detail';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;
    SourceTableView = WHERE("No." = filter(<> ''));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATO Whse. Outstanding Qty. field.';
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATO Whse. Outstd. Qty. (Base) field.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Item Charge Assignment field.';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appl.-from Item Entry field.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field("Attached Doc Count"; Rec."Attached Doc Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attached Doc Count field.';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attached to Line No. field.';
                }
                field("BOM Item No."; Rec."BOM Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOM Item No. field.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blanket Order Line No. field.';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blanket Order No. field.';
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completely Shipped field.';
                }
                field("Copied From Posted Doc."; Rec."Copied From Posted Doc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Copied From Posted Doc. field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cross-Reference Type field.';
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cross-Reference Type No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deferral Code field.';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
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
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exit Point field.';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Date field.';
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
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Weight field.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner Code field.';
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner Ref. Type field.';
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Partner Reference field.';
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv. Disc. Amount to Invoice field.';
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv. Discount Amount field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Contract Entry No. field.';
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
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                }
                field("Line Discount Calculation"; Rec."Line Discount Calculation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount Calculation field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Weight field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nonstock field.';
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
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outbound Whse. Handling Time field.';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Amount (LCY) field.';
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Qty. (Base) field.';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Package Tracking No. field.';
                }
                field(Planned; Rec.Planned)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned field.';
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Delivery Date field.';
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Shipment Date field.';
                }
                field("Pmt. Discount Amount"; Rec."Pmt. Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pmt. Discount Amount field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment % field.';
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Amount field.';
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Line field.';
                }
                field("Prepayment Tax Area Code"; Rec."Prepayment Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Tax Area Code field.';
                }
                field("Prepayment Tax Group Code"; Rec."Prepayment Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Tax Group Code field.';
                }
                field("Prepayment Tax Liable"; Rec."Prepayment Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Tax Liable field.';
                }
                field("Prepayment VAT %"; Rec."Prepayment VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment VAT % field.';
                }
                field("Prepayment VAT Difference"; Rec."Prepayment VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment VAT Difference field.';
                }
                field("Prepayment VAT Identifier"; Rec."Prepayment VAT Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment VAT Identifier field.';
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt Amt Deducted field.';
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt Amt to Deduct field.';
                }
                field("Prepmt VAT Diff. Deducted"; Rec."Prepmt VAT Diff. Deducted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt VAT Diff. Deducted field.';
                }
                field("Prepmt VAT Diff. to Deduct"; Rec."Prepmt VAT Diff. to Deduct")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt VAT Diff. to Deduct field.';
                }
                field("Prepmt. Amount Inv. (LCY)"; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. Amount Inv. (LCY) field.';
                }
                field("Prepmt. Amount Inv. Incl. VAT"; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. Amount Inv. Incl. VAT field.';
                }
                field("Prepmt. Amt. Incl. VAT"; Rec."Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. Amt. Incl. VAT field.';
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. Amt. Inv. field.';
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. Line Amount field.';
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. VAT Amount Inv. (LCY) field.';
                }
                field("Prepmt. VAT Base Amt."; Rec."Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. VAT Base Amt. field.';
                }
                field("Prepmt. VAT Calc. Type"; Rec."Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepmt. VAT Calc. Type field.';
                }
                field("Price description"; Rec."Price description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price description field.';
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Profit % field.';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Promised Delivery Date field.';
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purch. Order Line No. field.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Assigned field.';
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Invoiced (Base) field.';
                }
                field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Shipped (Base) field.';
                }
                field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Shipped Not Invd. (Base) field.';
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Shipped Not Invoiced field.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field("Qty. to Asm. to Order (Base)"; Rec."Qty. to Asm. to Order (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Asm. to Order (Base) field.';
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Assemble to Order field.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Assign field.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Invoice field.';
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Invoice (Base) field.';
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Ship field.';
                }
                field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Ship (Base) field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Invoiced field.';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Shipped field.';
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalculate Invoice Disc. field.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Delivery Date field.';
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserve field.';
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserved Qty. (Base) field.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserved Quantity field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ret. Qty. Rcd. Not Invd.(Base) field.';
                }
                field("Return Qty. Rcd. Not Invd."; Rec."Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Qty. Rcd. Not Invd. field.';
                }
                field("Return Qty. Received"; Rec."Return Qty. Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Qty. Received field.';
                }
                field("Return Qty. Received (Base)"; Rec."Return Qty. Received (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Qty. Received (Base) field.';
                }
                field("Return Qty. to Receive"; Rec."Return Qty. to Receive")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Qty. to Receive field.';
                }
                field("Return Qty. to Receive (Base)"; Rec."Return Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Qty. to Receive (Base) field.';
                }
                field("Return Rcd. Not Invd."; Rec."Return Rcd. Not Invd.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Rcd. Not Invd. field.';
                }
                field("Return Rcd. Not Invd. (LCY)"; Rec."Return Rcd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Rcd. Not Invd. (LCY) field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
                }
                field("Return Receipt Line No."; Rec."Return Receipt Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Receipt Line No. field.';
                }
                field("Return Receipt No."; Rec."Return Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Receipt No. field.';
                }
                field("Returns Deferral Start Date"; Rec."Returns Deferral Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Returns Deferral Start Date field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Date field.';
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Line No. field.';
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment No. field.';
                }
                field("Shipped Not Inv. (LCY) No VAT"; Rec."Shipped Not Inv. (LCY) No VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipped Not Inv. (LCY) No VAT field.';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipped Not Invoiced field.';
                }
                field("Shipped Not Invoiced (LCY)"; Rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipped Not Invoiced (LCY) field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Time field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Order field.';
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Substitution Available field.';
                }
                field(Subtype; Rec.Subtype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subtype field.';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System-Created Entry field.';
                }

                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Area Code field.';
                }
                field("Tax Category"; Rec."Tax Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Category field.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Group Code field.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Liable field.';
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
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Volume field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure (Cross Ref.) field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Units per Parcel field.';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Use Duplication List field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Calculation Type field.';
                }
                field("VAT Clause Code"; Rec."VAT Clause Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Clause Code field.';
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Difference field.';
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Identifier field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Whse. Outstanding Qty. field.';
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Whse. Outstanding Qty. (Base) field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }

                field("External Document No."; SalesHeader."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No.';
                }
                field("Posted Sales Invoices"; SalesInvoices)
                {
                    ApplicationArea = All;

                }
                field("Product CAT Name"; DimensionsCAT.Name)
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; customer.Name)
                {
                    ApplicationArea = All;

                }
                field("Pending for Invoice"; Rec.Quantity - Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;

                }
                field("Amount in Local Currency"; CurrencyValue)
                {
                    ApplicationArea = All;

                }
                field("Exchange Rate"; ExchangeRate."Relational Exch. Rate Amount")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    VAR
        SalesHeader: Record 36;
        SalesInvoiceHeader: Record 111;
        DimensionsCAT: Record 349;
        SalesInvoices: Code[1024];
        customer: Record 18;
        ExchangeRate: Record 330;
        CurrencyValue: Decimal;


    trigger OnAfterGetRecord()
    begin
        CurrencyValue := 0;
        Clear(SalesHeader);
        Clear(SalesInvoices);
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."Document No.");
        if SalesHeader.FindSet() then;
        Clear(SalesInvoiceHeader);
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("Order No.", Rec."Document No.");
        if SalesInvoiceHeader.FindSet() then
            repeat
                SalesInvoices := SalesInvoices + '|' + SalesInvoiceHeader."No.";
            until SalesInvoiceHeader.Next() = 0;
        Clear(customer);
        customer.Reset();
        customer.SetRange("No.", rec."Sell-to Customer No.");
        if customer.FindSet() then;

        DimensionsCAT.Reset();
        DimensionsCAT.SetRange("Dimension Code", 'PRODUCT CAT');
        DimensionsCAT.SetRange("Code", Rec."Shortcut Dimension 2 Code");
        IF DimensionsCAT.FindSet() then;

        if rec."Currency Code" <> '' then begin
            Clear(ExchangeRate);
            ExchangeRate.Reset();
            ExchangeRate.SetRange("Starting Date", Rec."Posting Date");
            ExchangeRate.SetRange("Currency Code", rec."Currency Code");
            if ExchangeRate.FindSet() then begin
                CurrencyValue := rec."Line Amount" * ExchangeRate."Relational Exch. Rate Amount";
            end else begin
                CurrencyValue := rec."Line Amount";

            end;

        end;



    end;

}
