table 55013 "Sales Invoice Line_Ack"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Description = 'Sell-to Customer No.';
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            TableRelation = "Sales Invoice Header_ACk";
            Description = 'Document No.';
        }
        field(4; "Line No."; Integer)
        {
            Description = 'Line No.';
        }
        field(5; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = ,"G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Description = 'No.';
        }
        field(7; "Location Code"; Code[10])
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            Description = 'Location Code';
        }
        field(8; "Posting Group"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            Description = 'Posting Group';
            Editable = false;
        }
        field(10; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        field(11; Description; Text[50])
        {
            Description = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Description = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Description = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Description = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
            AutoFormatType = 2;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            Description = 'Unit Cost (LCY)';
            AutoFormatType = 2;
        }
        field(25; "VAT %"; Decimal)
        {
            Description = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Description = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            Description = 'Line Discount Amount';
            AutoFormatType = 1;
        }
        field(29; Amount; Decimal)
        {
            Description = 'Amount';
            AutoFormatType = 1;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            Description = 'Amount Including VAT';
            AutoFormatType = 1;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            InitValue = Yes;
            Description = 'Allow Invoice Disc.';
        }
        field(34; "Gross Weight"; Decimal)
        {
            Description = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Description = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Description = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Description = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            AccessByPermission = TableData 27 = R;
            Description = 'Appl.-to Item Entry';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            Description = 'Shortcut Dimension 1 Code';
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Description = 'Shortcut Dimension 2 Code';
        }
        field(42; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Description = 'Customer Price Group';
        }
        field(45; "Job No."; Code[20])
        {
            TableRelation = Job;
            Description = 'Job No.';
        }
        field(52; "Work Type Code"; Code[10])
        {
            TableRelation = "Work Type";
            Description = 'Work Type Code';
        }
        field(63; "Shipment No."; Code[20])
        {
            Description = 'Shipment No.';
            Editable = false;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Description = 'Shipment Line No.';
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Description = 'Bill-to Customer No.';
            Editable = false;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            Description = 'Inv. Discount Amount';
            AutoFormatType = 1;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData 223 = R;
            Description = 'Drop Shipment';
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
            Description = 'Gen. Bus. Posting Group';
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            Description = 'Gen. Prod. Posting Group';
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Description = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            TableRelation = "Transaction Type";
            Description = 'Transaction Type';
        }
        field(79; "Transport Method"; Code[10])
        {
            TableRelation = "Transport Method";
            Description = 'Transport Method';
        }
        field(80; "Attached to Line No."; Integer)
        {
            TableRelation = "Sales Invoice Line"."Line No." WHERE("Document No." = FIELD("Document No."));
            Description = 'Attached to Line No.';
        }
        field(81; "Exit Point"; Code[10])
        {
            TableRelation = "Entry/Exit Point";
            Description = 'Exit Point';
        }
        field(82; "Area"; Code[10])
        {
            TableRelation = Area;
            Description = 'Area';
        }
        field(83; "Transaction Specification"; Code[10])
        {
            TableRelation = "Transaction Specification";
            Description = 'Transaction Specification';
        }
        field(84; "Tax Category"; Code[10])
        {
            Description = 'Tax Category';
        }
        field(85; "Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Description = 'Tax Area Code';
        }
        field(86; "Tax Liable"; Boolean)
        {
            Description = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group";
            Description = 'Tax Group Code';
        }
        field(88; "VAT Clause Code"; Code[10])
        {
            TableRelation = "VAT Clause";
            Description = 'VAT Clause Code';
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Description = 'VAT Bus. Posting Group';
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Description = 'VAT Prod. Posting Group';
        }
        field(97; "Blanket Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            Description = 'Blanket Order No.';
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
              "Document No." = FIELD("Blanket Order No."));
            Description = 'Blanket Order Line No.';
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            Description = 'VAT Base Amount';
            Editable = false;
            AutoFormatType = 1;
        }
        field(100; "Unit Cost"; Decimal)
        {
            Description = 'Unit Cost';
            Editable = false;
            AutoFormatType = 2;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Description = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            Description = 'Line Amount';
            AutoFormatType = 1;
        }
        field(104; "VAT Difference"; Decimal)
        {
            Description = 'VAT Difference';
            AutoFormatType = 1;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Description = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Description = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.';
            OptionMembers = ,"G/L Account",Item,,,"Charge (Item)","Cross reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Description = 'IC Partner Reference';
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Description = 'Prepayment Line';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            TableRelation = "IC Partner";
            Description = 'IC Partner Code';
        }
        field(131; "Posting Date"; Date)
        {
            Description = 'Posting Date';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            Description = 'Dimension Set ID';
            Editable = false;
        }
        field(1001; "Job Task No."; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
            Description = 'Job Task No.';
            Editable = false;
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            Description = 'Job Contract Entry No.';
            Editable = false;
        }
        field(1700; "Deferral Code"; Code[10])
        {
            TableRelation = "Deferral Template"."Deferral Code";
            Description = 'Deferral Code';
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            Description = 'Variant Code';
        }
        field(5403; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"), "Item Filter" = FIELD("No."), "Variant Filter" = FIELD("Variant Code"));
            Description = 'Bin Code';
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Description = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            Description = 'Unit of Measure Code';
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Description = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Description = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            TableRelation = "Depreciation Book";
            Description = 'Depreciation Book Code';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Description = 'Depr. until FA Posting Date';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            TableRelation = "Depreciation Book";
            Description = 'Duplicate in Depreciation Book';
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Description = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
            Description = 'Responsibility Center';
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            AccessByPermission = TableData 5717 = R;
            Description = 'Cross-Reference No.';
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            Description = 'Unit of Measure (Cross Ref.)';
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Description = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = ,Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Description = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Category";
            Description = 'Item Category Code';
        }
        field(5710; Nonstock; Boolean)
        {
            Description = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            TableRelation = Purchasing;
            Description = 'Purchasing Code';
        }
        field(5712; "Product Group Code"; Code[10])
        {
            // TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            Description = 'Product Group Code';
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData 27 = R;
            Description = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            TableRelation = "Return Reason";
            Description = 'Return Reason Code';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            InitValue = Yes;
            Description = 'Allow Line Disc.';
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            TableRelation = "Customer Discount Group";
            Description = 'Customer Disc. Group';
        }
        field(50500; "Unit Price (QC)"; Decimal)
        {
            Description = 'Unit Price (QC)';
            //Description=KMS1704-KMSMOFT17;
            AutoFormatType = 2;
        }
        field(50501; "Quote Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Quote Currency Code';
            //Description=KMS1704-KMSMOFT17;
            Editable = false;
        }
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';
        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(56000; "Quote Currency Amount"; Decimal)
        {
            Description = 'Quote Currency Amount';
        }
        field(14103540; "Document Line No."; Integer)
        {
            Description = 'Document Line No.';
            //Description=VLDM4.0;
        }
    }


    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}


//   {    ;Document No.,Line No.                   ;SumIndexFields=Amount,Amount Including VAT;
//                                                  MaintainSIFTIndex=No;
//                                                  Clustered=Yes }
//   {    ;Blanket Order No.,Blanket Order Line No. }
//   {    ;Sell-to Customer No.                     }
//   { No ;Sell-to Customer No.,Type,Document No.  ;MaintainSQLIndex=No }
//   {    ;Shipment No.,Shipment Line No.           }
//   {    ;Job Contract Entry No.                   }
//   {    ;Bill-to Customer No.                     }
//   {    ;Document No.,Document Line No.           }
//     PROPERTIES
// {
//   Permissions=TableData 32=r,
//               TableData 5802=r;
//   OnDelete=VAR
//              SalesDocLineComments@1000 : Record 44;
//              PostedDeferralHeader@1001 : Record 1704;
//            BEGIN
//            END;

//   CaptionML=ENU=Sales Invoice Line;
//   LookupPageID=Page526;
//   DrillDownPageID=Page526;
// }
