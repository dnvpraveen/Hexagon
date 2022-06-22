table 55015 "Sales Header Archive - ACK"
{
    DataClassification = ToBeClassified;
    //LookupPageID=Page5161;
    //DrillDownPageID=Page5161;

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
            TableRelation = Customer;
            Description = 'Sell-to Customer No.';
        }
        field(3; "No."; Code[20])
        {
            Description = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Description = 'Bill-to Customer No.';
            NotBlank = true;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Description = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Description = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Description = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Description = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
            Description = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[50])
        {
            Description = 'Bill-to Contact';
        }
        field(11; "Your Reference"; Text[35])
        {
            Description = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'Ship-to Code';
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Description = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Description = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Description = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Description = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
            Description = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Description = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Description = 'Order Date';
        }
        field(20; "Posting Date"; Date)
        {
            Description = 'Posting Date';
        }
        field(21; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        field(22; "Posting Description"; Text[50])
        {
            Description = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
            Description = 'Payment Terms Code';
        }
        field(24; "Due Date"; Date)
        {
            Description = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Description = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Description = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            TableRelation = "Shipment Method";
            Description = 'Shipment Method Code';
        }
        field(28; "Location Code"; Code[10])
        {
            ; TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            Description = 'Location Code';
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Description = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Description = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            TableRelation = "Customer Posting Group";
            Description = 'Customer Posting Group';
        }
        field(32; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Currency Code';
        }
        field(33; "Currency Factor"; Decimal)
        {
            Description = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Price Group Code"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Description = 'Price Group Code';
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Description = 'Prices Including VAT';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Description = 'Invoice Disc. Code';
        }
        field(40; "Cust./Item Disc. Gr."; Code[20])
        {
            TableRelation = "Customer Discount Group";
            Description = 'Cust./Item Disc. Gr.';
        }
        field(41; "Language Code"; Code[10])
        {
            ; TableRelation = Language;
            Description = 'Language Code';
        }
        field(43; "Salesperson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Description = 'Salesperson Code';
        }
        field(45; "Order Class"; Code[10])
        {
            Description = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Comment Line Archive" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No."),
            "Document Line No." = CONST(0), "Doc. No. Occurrence" = field("Doc. No. Occurrence"), "Version No." = field("Version No.")));
            Description = 'Comment';
            Editable = false;
        }
        field(47; "No. Printed"; Integer)
        {
            Description = 'No. Printed';
        }
        field(51; "On Hold"; Code[3])
        {
            Description = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Description = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Description = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            Description = 'Bal. Account No.';
        }
        field(57; Ship; Boolean)
        {
            Description = 'Ship';
        }
        field(58; Invoice; Boolean)
        {
            Description = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line Archive".Amount WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.")));
            Description = 'Amount';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line Archive"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.")));
            Description = 'Amount Including VAT';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(62; "Shipping No."; Code[20])
        {
            Description = 'Shipping No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Description = 'Posting No.';
        }
        field(64; "Last Shipping No."; Code[20])
        {
            TableRelation = "Sales Shipment Header";
            Description = 'Last Shipping No.';
        }
        field(65; "Last Posting No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            Description = 'Last Posting No.';
        }
        field(66; "Prepayment No."; Code[20])
        {
            Description = 'Prepayment No.';
        }
        field(67; "Last Prepayment No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            Description = 'Last Prepayment No.';
        }
        field(68; "Prepmt. Cr. Memo No."; Code[20])
        {
            Description = 'Prepmt. Cr. Memo No.';
        }
        field(69; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            Description = 'Last Prepmt. Cr. Memo No.';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Description = 'VAT Registration No.';
        }
        field(71; "Combine Shipments"; Boolean)
        {
            Description = 'Combine Shipments';
        }
        field(73; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Description = 'Reason Code';
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
            Description = 'Gen. Bus. Posting Group';
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Description = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            TableRelation = "Transaction Type";
            Description = 'Transaction Type';
        }
        field(77; "Transport Method"; Code[10])
        {
            TableRelation = "Transport Method";
            Description = 'Transport Method';
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Description = 'VAT Country/Region Code';
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            Description = 'Sell-to Customer Name';
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Description = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[50])
        {
            Description = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Description = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
            Description = 'Sell-to City';
        }
        field(84; "Sell-to Contact"; Text[50])
        {
            Description = 'Sell-to Contact';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Description = 'Bill-to Post Code';
        }
        field(86; "Bill-to County"; Text[30])
        {
            Description = 'Bill-to County';
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Description = 'Bill-to Country/Region Code';
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Description = 'Sell-to Post Code';
        }
        field(89; "Sell-to County"; Text[30])
        {
            Description = 'Sell-to County';
        }
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Description = 'Sell-to Country/Region Code';
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Description = 'Ship-to Post Code';
        }
        field(92; "Ship-to County"; Text[30])
        {
            Description = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Description = 'Ship-to Country/Region Code';
        }
        field(94; "Bal. Account Type"; Option)
        {
            Description = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(97; "Exit Point"; Code[10])
        {
            TableRelation = "Entry/Exit Point";
            Description = 'Exit Point';
        }
        field(98; Correction; Boolean) { Description = 'Correction'; }
        field(99; "Document Date"; Date)
        {
            Description = 'Document Date';
        }
        field(100; "External Document No."; Code[35])
        {
            Description = 'External Document No.';
        }
        field(101; "Area"; Code[10])
        {
            TableRelation = Area;
            Description = 'Area';
        }
        field(102; "Transaction Specification"; Code[10])
        {
            TableRelation = "Transaction Specification";
            Description = 'Transaction Specification';
        }
        field(104; "Payment Method Code"; Code[10])
        {
            TableRelation = "Payment Method";
            Description = 'Payment Method Code';
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            TableRelation = "Shipping Agent";
            AccessByPermission = TableData 5790 = R;
            Description = 'Shipping Agent Code';
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Description = 'Package Tracking No.';
        }
        field(107; "No. Series"; Code[10])
        {
            ; TableRelation = "No. Series";
            Description = 'No. Series';
        }
        field(108; "Posting No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Posting No. Series';
        }
        field(109; "Shipping No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Shipping No. Series';
        }
        field(114; "Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Description = 'Tax Area Code';
        }
        field(115; "Tax Liable"; Boolean) { Description = 'Tax Liable'; }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Description = 'VAT Bus. Posting Group';
        }
        field(117; Reserve; Option)
        {
            Description = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(118; "Applies-to ID"; Code[50]) { Description = 'Applies-to ID'; }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Description = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(120; Status; Option)
        {
            Description = 'Status';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Description = 'Invoice Discount Calculation';
            OptionCaption = 'None,%,Amount';
            OptionMembers = None,"%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            Description = 'Invoice Discount Value';
            AutoFormatType = 1;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Description = 'Send IC Document';
        }
        field(124; "IC Status"; Option)
        {
            Description = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Sell-to IC Partner Code"; Code[20])
        {
            TableRelation = "IC Partner";
            Description = 'Sell-to IC Partner Code';
            Editable = false;
        }
        field(126; "Bill-to IC Partner Code"; Code[20])
        {
            TableRelation = "IC Partner";
            Description = 'Bill-to IC Partner Code';
            Editable = false;
        }

        field(129; "IC Direction"; Option)
        {
            Description = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(130; "Prepayment %"; Decimal)
        {
            Description = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(131; "Prepayment No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Prepayment No. Series';
        }
        field(132; "Compress Prepayment"; Boolean)
        {
            InitValue = True;
            Description = 'Compress Prepayment';
        }
        field(133; "Prepayment Due Date"; Date)
        {
            Description = 'Prepayment Due Date';
        }
        field(134; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Prepmt. Cr. Memo No. Series';
        }
        field(135; "Prepmt. Posting Description"; Text[50])
        {
            Description = 'Prepmt. Posting Description';
        }
        field(138; "Prepmt. Pmt. Discount Date"; Date)
        {
            Description = 'Prepmt. Pmt. Discount Date';
        }
        field(139; "Prepmt. Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
            Description = 'Prepmt. Payment Terms Code';
        }
        field(140; "Prepmt. Payment Discount %"; Decimal)
        {
            Description = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(145; "No. of Archived Versions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Sales Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Description = 'No. of Archived Versions';
            Editable = false;
        }
        field(151; "Sales Quote No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Quote), "No." = FIELD("Sales Quote No."));
            ValidateTableRelation = false;
            Description = 'Sales Quote No.';
            Editable = false;
        }
        field(200; "Work Description"; BLOB)
        {
            Description = 'Work Description';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            Description = 'Dimension Set ID';
            Editable = false;
            trigger OnLookup()
            BEGIN
                ShowDimensions;
            END;

        }
        field(827; "Credit Card No."; Code[20])
        {
            Description = 'Credit Card No.';
        }
        field(5043; "Interaction Exist"; Boolean) { Description = 'Interaction Exist'; }
        field(5044; "Time Archived"; Time) { Description = 'Time Archived'; }
        field(5045; "Date Archived"; Date) { Description = 'Date Archived'; }
        field(5046; "Archived By"; Code[50])
        {
            TableRelation = User."User Name";
            Description = 'Archived By';
            Editable = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            BEGIN
                UserMgt.LookupUserID("Archived By");
            END;
        }
        field(5047; "Version No."; Integer)
        {
            Description = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Description = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            TableRelation = Campaign;
            Description = 'Campaign No.';
        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
            TableRelation = "Customer Template";
            Description = 'Sell-to Customer Template Code';
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            TableRelation = Contact;
            Description = 'Sell-to Contact No.';
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            TableRelation = Contact;
            Description = 'Bill-to Contact No.';
        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
            Description = 'Bill-to Customer Template Code';
        }
        field(5055; "Opportunity No."; Code[20])
        {
            TableRelation = Opportunity."No." WHERE("Contact No." = FIELD("Sell-to Contact No."), Closed = CONST(false));
            Description = 'Opportunity No.';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
            Description = 'Responsibility Center';
        }
        field(5750; "Shipping Advice"; Option)
        {
            AccessByPermission = TableData 110 = R;
            Description = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            //FieldClass = FlowField;
            // CalcFormula = Min("Sales Line Archive - ACK"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Version No." = FIELD("Version No."), "Shipment Date" = FIELD("Date Filter"), "Location Code" = FIELD("Location Filter")));
            Description = 'Completely Shipped';
            Editable = false;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Description = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
            Description = 'Location Filter';
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            AccessByPermission = TableData 99000880 = R;
            Description = 'Requested Delivery Date';
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Description = 'Promised Delivery Date';
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Description = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData 14 = R;
            Description = 'Outbound Whse. Handling Time';
        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            Description = 'Shipping Agent Service Code';
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            //  FieldClass = FlowField;
            //CalcFormula = Exist("Sales Line Archive - ACK" WHERE("Document Type" = FIELD("Document Type"), "Sell-to Customer No." = FIELD("Sell-to Customer No."),
            //          "Document No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No."), "Shipment Date" = filter('Date Filter')));
            Description = 'Late Order Shipping';
            Editable = false;
        }
        field(5796; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Description = 'Date Filter';
        }
        field(5800; Receive; Boolean)
        {
            Description = 'Receive';
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            Description = 'Return Receipt No.';
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
            ; TableRelation = "No. Series";
            Description = 'Return Receipt No. Series';
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            TableRelation = "Return Receipt Header";
            Description = 'Last Return Receipt No.';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Description = 'Allow Line Disc.';
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Description = 'Get Shipment Used';
            Editable = false;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            TableRelation = "User Setup";
            Description = 'Assigned User ID';
        }
        field(55000; "Order Type"; Code[10])
        {
            Description = 'Order Type';
        }
        field(55001; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';
        }
        field(55002; "User Email"; Text[50])
        {
            Description = 'User Email';
        }
        field(55003; "Ship-to Freight"; Text[30])
        {
            Description = 'Ship-to Freight';
        }
        field(55004; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55008; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55011; "Header Status"; Text[30])
        {
            Description = 'Header Status';
        }
        Field(55019; "Zero Value Order"; Boolean)
        {
            Description = 'Zero Value Order';
        }
        field(55050; "Cancel / Short Close"; Option)
        {
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = ,Cancelled,"Short Closed";
            Description = 'Cancel / Short Close';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document Type", "No.", "Doc. No. Occurrence", "Version No.")
        {
            Clustered = true;
        }
        key(Sell; "Document Type", "Sell-to Customer No.")
        {

        }
        key(Bill; "Document Type", "Bill-to Customer No.")
        {

        }
    }

    VAR
        SalesLineArchive: Record "Sales Line Archive";
        DeferralHeaderArchive: Record "Deferral Header Archive";
        NonstockItemMgt: Codeunit "Catalog Item Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        SalesCommentLineArch: Record "Sales Comment Line Archive";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        SalesLineArchive: Record "Sales Line Archive";

    BEGIN
        SalesLineArchive.SETRANGE("Document Type", "Document Type");
        SalesLineArchive.SETRANGE("Document No.", "No.");
        SalesLineArchive.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
        SalesLineArchive.SETRANGE("Version No.", "Version No.");
        SalesLineArchive.SETRANGE(Nonstock, TRUE);
        IF SalesLineArchive.FINDSET(TRUE) THEN
            REPEAT
                NonstockItemMgt.DelNonStockSalesArch(SalesLineArchive);
            UNTIL SalesLineArchive.NEXT = 0;
        SalesLineArchive.SETRANGE(Nonstock);
        SalesLineArchive.DELETEALL;

        SalesCommentLineArch.SETRANGE("Document Type", "Document Type");
        SalesCommentLineArch.SETRANGE("No.", "No.");
        SalesCommentLineArch.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
        SalesCommentLineArch.SETRANGE("Version No.", "Version No.");
        SalesCommentLineArch.DELETEALL;

        DeferralHeaderArchive.SETRANGE("Deferral Doc. Type", DeferralUtilities.GetSalesDeferralDocType);
        DeferralHeaderArchive.SETRANGE("Document Type", "Document Type");
        DeferralHeaderArchive.SETRANGE("Document No.", "No.");
        DeferralHeaderArchive.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
        DeferralHeaderArchive.SETRANGE("Version No.", "Version No.");
        DeferralHeaderArchive.DELETEALL(TRUE);
    END;


    trigger OnRename()
    begin

    end;

    PROCEDURE ShowDimensions();
    var
        DimMgt: Codeunit "DimensionManagement";
    BEGIN
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Document Type", "No."));
    END;

    PROCEDURE SetSecurityFilterOnRespCenter();
    var
        UserSetupMgt: Codeunit "User Setup Management";
    BEGIN
        IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserSetupMgt.GetSalesFilter);
            FILTERGROUP(0);
        END;
    END;
}


