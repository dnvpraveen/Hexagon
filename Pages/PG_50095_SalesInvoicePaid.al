page 50095 "Sales Invoice Paid "
{
    ApplicationArea = All;
    Caption = 'Sales Invoice Paid ';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Action Code"; Rec."Action Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Action Code field.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
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
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attached to Line No. field.';
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
                field("Line Status"; Rec."Line Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Status field.';
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
                field("Order Created"; Rec."Order Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Created field.';
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
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Package Tracking No. field.';
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
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepayment Line field.';
                }
                field("Price description"; Rec."Price description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price description field.';
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
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                }
                field("Ready to Invoice"; Rec."Ready to Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ready to Invoice field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
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
                field("Smax Line No."; Rec."Smax Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Smax Line No. field.';
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
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Order No. field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Fecha de Pago"; detalleCust."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Documento Pago"; detalleCust."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Amount $"; CustomerLedger."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Currency Code"; CustomerLedger."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Clear(detalleCust);
        Clear(CustomerLedger);
        CustomerLedger.Reset();
        CustomerLedger.SetRange("Document No.", rec."Document No.");
        if CustomerLedger.FindSet() then begin
            CustomerLedger.CalcFields("Amount (LCY)");

            detalleCust.Reset();
            detalleCust.SetRange("Cust. Ledger Entry No.", CustomerLedger."Entry No.");
            detalleCust.SetRange("Entry Type", detalleCust."Entry Type"::Application);
            if detalleCust.FindSet() then;
        end;
    end;

    var
        CustomerLedger: Record "Cust. Ledger Entry";
        detalleCust: Record "Detailed Cust. Ledg. Entry";
}
