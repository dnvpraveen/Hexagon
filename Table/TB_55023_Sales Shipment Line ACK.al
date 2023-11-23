Table 55023 "Sales Shipment Line - ACK"
{
    Caption = 'Sales Shipment Line - ACK';
    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Shipment Header";

            //trigger OnValidate()
            //begin
            //UpdateDocumentId();
            //end;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Sales Line Type_HGN")
        {
            Caption = 'Type';
        }
        field(6; "No."; Code[20])
        {
            //CaptionClass = GetCaptionClass(FieldNo("No."));
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Item Entry';
        }
        field(39; "Item Shpt. Entry No."; Integer)
        {
            Caption = 'Item Shpt. Entry No.';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(65; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(66; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
        }
        field(73; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment';
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Enum "Tax Calculation Type_HGN")
        {
            Caption = 'VAT Calculation Type';
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            TableRelation = "Sales Shipment Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            CalcFormula = Lookup("Sales Shipment Header"."Currency Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Currency Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Enum "IC Partner Reference Type_HGN")
        {
            Caption = 'IC Partner Ref. Type';
            DataClassification = CustomerContent;
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';
            DataClassification = CustomerContent;
        }
        field(131; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(138; "IC Item Reference No."; Code[50])
        {
            //AccessByPermission = TableData "Item Reference" = R;
            Caption = 'IC Item Reference No.';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions();
            end;
        }
        field(826; "Authorized for Credit Card"; Boolean)
        {
            Caption = 'Authorized for Credit Card';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            Editable = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Item Filter" = FIELD("No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
            ObsoleteState = Removed;

        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
            ObsoleteState = Removed;

        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
            ObsoleteState = Removed;

        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
            ObsoleteState = Removed;

        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = IF (Type = CONST(Item)) "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Catalog';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            ObsoleteReason = 'Product Groups became first level children of Item Categories.';
            ObsoleteState = Removed;

        }
        field(5725; "Item Reference No."; Code[50])
        {
            //AccessByPermission = TableData "Item Reference" = R;
            Caption = 'Item Reference No.';
        }
        field(5726; "Item Reference Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure (Item Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5727; "Item Reference Type"; Enum "Item Reference Type_HGN")
        {
            Caption = 'Item Reference Type';
        }
        field(5728; "Item Reference Type No."; Code[30])
        {
            Caption = 'Item Reference Type No.';
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            Editable = false;
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            Editable = false;
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            Editable = false;
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            Caption = 'Planned Shipment Date';
            Editable = false;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(5812; "Item Charge Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Item Charge Base Amount';
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method_HGN")
        {
            Caption = 'Price Calculation Method';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(8000; "Document Id"; Guid)
        {
            Caption = 'Document Id';
            trigger OnValidate()
            begin
                //UpdateDocumentNo();
            end;
        }

        field(55000; "Smax Line No."; Text[30])
        {
            Caption = 'Smax Line No.';
        }
        field(55001; "Action Code"; Integer)
        {
            Caption = 'Action Code';
        }
        field(55004; "Order Inserted";
        Boolean)
        {
            Caption = 'Order Inserted';
        }
        field(55005; "Order Created";
        Boolean)
        {
            Caption = 'Order Created';
        }
        field(55006; "Order Type"; Code[10])
        {
            Caption = 'Order Type';
        }
        field(55007; "Work Order No."; Text[30])
        {
            Caption = 'Work Order No.';
        }
        field(55008; "Ready to Invoice"; Boolean)
        {
            Caption = 'Ready to Invoice';
        }
        field(55011; "Line Status"; Text[30])
        {
            Caption = 'Line Status';
        }
        field(55014; "Hybris Order No."; Code[20])
        {
            Caption = 'Hybris Order No.';
        }
        field(55015; HybrisPoCreated; Boolean)
        {
            Caption = 'HybrisPoCreated';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Order No.", "Order Line No.", "Posting Date")
        {
        }
        key(Key3; "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key4; "Item Shpt. Entry No.")
        {
        }
        key(Key5; "Sell-to Customer No.")
        {
        }
        key(Key6; "Bill-to Customer No.")
        {
        }
        key(Key7; "Document Id")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Line No.", "Sell-to Customer No.", Type, "No.", "Shipment Date")
        {
        }
    }

    var
        Currency: Record Currency;
        SalesShptHeader: Record "Sales Shipment Header";
        PostedATOLink: Record "Posted Assemble-to-Order Link";
        DimMgt: Codeunit DimensionManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        CurrencyRead: Boolean;

        Text000: Label 'Shipment No. %1:';
        Text001: Label 'The program cannot find this Sales line.';

    procedure GetCurrencyCode(): Code[10]
    begin
        if "Document No." = SalesShptHeader."No." then
            exit(SalesShptHeader."Currency Code");
        if SalesShptHeader.Get("Document No.") then
            exit(SalesShptHeader."Currency Code");
        exit('');
    end;
}

