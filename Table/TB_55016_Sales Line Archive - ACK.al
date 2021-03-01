table 55016 "Sales Line Archive - ACK"
{
    //DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Description = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Description = 'Sell-to Customer No.';
        }
        field(3; "Document No."; Code[20])
        {
            TableRelation = "Sales Header Archive - ACK"."No." WHERE("Document Type" = FIELD("Document Type"), "Version No." = field("Version No."));
            Description = 'Document No.';
        }
        field(4; "Line No."; Integer)
        {
            Description = 'Line No.';
        }
        field(5; Type; Option)
        {
            Description = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = ,"G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST("")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
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
        }
        field(9; "Quantity Disc. Code"; Code[20])
        {
            Description = 'Quantity Disc. Code';
        }
        field(10; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        field(11; Description; Text[50]) { Description = 'Description'; }
        field(12; "Description 2"; Text[50]) { Description = 'Description 2'; }
        field(13; "Unit of Measure"; Text[10]) { Description = 'Unit of Measure'; }
        field(15; Quantity; Decimal)
        {
            Description = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Description = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Description = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            AccessByPermission = TableData 110 = R;
            Description = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
            AutoFormatType = 2;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
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
        }
        field(26; "Quantity Disc. %"; Decimal)
        {
            Description = 'Quantity Disc. %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
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
            AutoFormatExpression = '<Currency Code>';
        }
        field(29; Amount; Decimal)
        {
            Description = 'Amount';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            Description = 'Amount Including VAT';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            InitValue = True;
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Description = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Description = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
        }
        field(42; "Price Group Code"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Description = 'Price Group Code';
        }
        field(43; "Allow Quantity Disc."; Boolean)
        {
            InitValue = True;
            Description = 'Allow Quantity Disc.';
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
        field(55; "Cust./Item Disc. %"; Decimal)
        {
            Description = 'Cust./Item Disc. %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            Description = 'Outstanding Amount';
            ;
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Description = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            Description = 'Shipped Not Invoiced';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            AccessByPermission = TableData 110 = R;
            Description = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Description = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Shipment No."; Code[20])
        {
            Description = 'Shipment No.';
        }
        field(64; "Shipment Line No."; Integer)
        {
            Description = 'Shipment Line No.';
        }
        field(67; "Profit %"; Decimal)
        {
            Description = 'Profit %';
            DecimalPlaces = 0 : 5;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Description = 'Bill-to Customer No.';
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            Description = 'Inv. Discount Amount';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(71; "Purchase Order No."; Code[20])
        {
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            Description = 'Purchase Order No.';
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Purchase Order No."));
            Description = 'Purch. Order Line No.';
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
            TableRelation = "Sales Line Archive"."Line No." where("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."),
            "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No."));
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
        field(91; "Currency Code "; Code[10])
        {
            TableRelation = Currency;
            Description = 'Currency Code';
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            Description = 'Outstanding Amount (LCY)';
            AutoFormatType = 1;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            Description = 'Shipped Not Invoiced (LCY)';
            AutoFormatType = 1;
        }
        field(96; Reserve; Option)
        {
            AccessByPermission = TableData 110 = R;
            Description = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            Description = 'Blanket Order No.';
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"), "Document No." = FIELD("Blanket Order No."));
            Description = 'Blanket Order Line No.';
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            Description = 'VAT Base Amount';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(100; "Unit Cost"; Decimal)
        {
            Description = 'Unit Cost';
            AutoFormatType = 2;
            AutoFormatExpression = '<Currency Code>';
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Description = 'System-Created Entry';
        }
        field(103; "Line Amount"; Decimal)
        {
            Description = 'Line Amount';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
        }
        field(104; "VAT Difference"; Decimal)
        {
            Description = 'VAT Difference';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            ;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            Description = 'Inv. Disc. Amount to Invoice';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Description = 'VAT Identifier';
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Description = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.';
            OptionMembers = ,"G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Description = 'IC Partner Reference';
        }
        field(109; "Prepayment %"; Decimal)
        {
            Description = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            Description = 'Prepmt. Line Amount';
            MinValue = 0;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Line Amount"));
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            Description = 'Prepmt. Amt. Inv.';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Amt. Inv."));
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            Description = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            Description = 'Prepayment Amount';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            Description = 'Prepmt. VAT Base Amt.';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Description = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            Editable = false;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Description = 'Prepmt. VAT Calc. Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            Editable = false;
        }
        field(117; "Prepayment VAT Identifier"; Code[10])
        {
            Description = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Description = 'Prepayment Tax Area Code';
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Description = 'Prepayment Tax Liable';
        }
        field(120; "Prepayment Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group";
            Description = 'Prepayment Tax Group Code';
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            Description = 'Prepmt Amt to Deduct';
            MinValue = 0;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt to Deduct"));
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            Description = 'Prepmt Amt Deducted';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt Deducted"));
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Description = 'Prepayment Line';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            Description = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(130; "IC Partner Code"; Code[20])
        {
            TableRelation = "IC Partner";
            Description = 'IC Partner Code';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            Description = 'Dimension Set ID';
            Editable = false;
        }
        field(1700; "Deferral Code"; Code[10])
        {
            TableRelation = "Deferral Template"."Deferral Code";
            Description = 'Deferral Code';
        }
        field(1702; "Returns Deferral Start Date"; Date)
        {
            Description = 'Returns Deferral Start Date';
        }
        field(5047; "Version No."; Integer)
        {
            Description = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Description = 'Doc. No. Occurrence';
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            Description = 'Variant Code';
        }
        field(5403; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            Description = 'Bin Code';
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            ; InitValue = 1;
            Description = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
        }
        field(5405; Planned; Boolean)
        {
            Description = 'Planned';
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
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Description = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Description = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Description = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Description = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Description = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Description = 'Qty. Invoiced (Base)';
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
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Description = 'Out-of-Stock Substitution';
        }
        field(5702; "Substitution Available"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Item Substitution" WHERE(Type = CONST(Item), "No." = FIELD("No."), "Substitute Type" = CONST(Item)));
            Description = 'Substitution Available';
            Editable = false;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) Item;
            Description = 'Originally Ordered No.';
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
            Description = 'Originally Ordered Var. Code';
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
            TableRelation = "Item Category";
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
        field(5713; "Special Order"; Boolean)
        {
            Description = 'Special Order';
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            Description = 'Special Order Purchase No.';
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                "Document No." = FIELD("Special Order Purchase No."));
            Description = 'Special Order Purch. Line No.';
        }
        field(5752; "Completely Shipped"; Boolean) { Description = 'Completely Shipped'; }
        field(5790; "Requested Delivery Date"; Date)
        {
            AccessByPermission = TableData 99000880 = R;
            Description = 'Requested Delivery Date';
        }
        field(5791; "Promised Delivery Date"; Date) { Description = 'Promised Delivery Date'; }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData 5790 = R;
            Description = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData 14 = R;
            Description = 'Outbound Whse. Handling Time';
        }
        field(5794; "Planned Delivery Date"; Date) { Description = 'Planned Delivery Date'; }
        field(5795; "Planned Shipment Date"; Date) { Description = 'Planned Shipment Date'; }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            TableRelation = "Shipping Agent";
            AccessByPermission = TableData 5790 = R;
            Description = 'Shipping Agent Code';
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            Description = 'Shipping Agent Service Code';
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            InitValue = True;
            AccessByPermission = TableData 5800 = R;
            Description = 'Allow Item Charge Assignment';
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            Description = 'Return Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Description = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Description = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0 : 5;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Description = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5807; "Return Amt. Rcd. Not Invd."; Decimal)
        {
            Description = 'Return Amt. Rcd. Not Invd.';
            AutoFormatType = 1;
            AutoFormatExpression = '<Currency Code>';
        }
        field(5808; "Ret. Amt. Rcd. Not Invd. (LCY)"; Decimal)
        {
            Description = 'Ret. Amt. Rcd. Not Invd. (LCY)';
            AutoFormatType = 1;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Description = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Description = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData 27 = R;
            Description = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract), "Customer No." = FIELD("Sell-to Customer No."),
                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
            Description = 'Service Contract No.';
        }
        field(5901; "Service Order No."; Code[20])
        {
            Description = 'Service Order No.';
        }
        field(5902; "Service Item No."; Code[20])
        {
            TableRelation = "Service Item"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'Service Item No.';
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Description = 'Appl.-to Service Entry';
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Description = 'Service Item Line No.';
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            TableRelation = "Service Price Adjustment Group";
            Description = 'Serv. Price Adjmt. Gr. Code';
        }
        field(5909; "BOM Item No."; Code[20])
        {
            TableRelation = Item;
            Description = 'BOM Item No.';
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Description = 'Return Receipt No.';
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Description = 'Return Receipt Line No.';
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            TableRelation = "Return Reason";
            Description = 'Return Reason Code';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            InitValue = True;
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

            AutoFormatType = 2;
        }
        field(50501; "Quote Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Quote Currency Code';

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
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
            Clustered = true;
        }

        key(Doc; "Document Type", "Document No.", "Line No.", "Doc. No. Occurrence", "Version No.")
        {

        }
        key(Sell; "Sell-to Customer No.")
        {

        }
        key(Bill; "Bill-to Customer No.")
        {

        }
        Key(Doc3; Type, "No.")
        {

        }
    }




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




    LOCAL PROCEDURE GetCaptionClass(FieldNumber: Integer): Text[80];
    VAR
        SalesHeaderArchive: Record 5107;
    BEGIN
        IF NOT SalesHeaderArchive.GET("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.") THEN BEGIN
            SalesHeaderArchive."No." := '';
            SalesHeaderArchive.INIT;
        END;
        IF SalesHeaderArchive."Prices Including VAT" THEN
            EXIT('2,1,' + GetFieldCaption(FieldNumber));

        EXIT('2,0,' + GetFieldCaption(FieldNumber));
    END;

    LOCAL PROCEDURE GetFieldCaption(FieldNumber: Integer): Text[100];
    VAR
        Field: Record 2000000041;
    BEGIN
        Field.GET(DATABASE::"Sales Line", FieldNumber);
        EXIT(Field."Field Caption");
    END;


}
