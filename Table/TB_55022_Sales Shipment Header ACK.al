Table 55022 "Sales Shipment Header - ACK"
{
    DataClassification = ToBeClassified;

    FIELDS
    {
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
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            Description = 'Location Code ';
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Description = 'Shortcut Dimension 1 Code';
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Description = 'Shortcut Dimension 2 Code';
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            TableRelation = "Customer Posting Group";
            Description = 'Customer Posting Group';
            Editable = false;
        }
        field(32; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Currency Code';
            Editable = false;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Description = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Description = 'Customer Price Group';
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Description = 'Prices Including VAT';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Description = 'Invoice Disc. Code';
        }
        field(40; "Customer Disc. Group"; Code[20])
        {
            TableRelation = "Customer Discount Group";
            Description = 'Customer Disc. Group';
        }
        field(41; "Language Code"; Code[10])
        {
            TableRelation = Language;
            Description = 'Language Code';
        }
        field(43; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            Description = 'Salesperson Code';
        }
        field(44; "Order No."; Code[20])
        {
            Description = 'Order No.';
        }
        field(46; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = CONST(Shipment),
           "No." = FIELD("No."), "Document Line No." = CONST(0)));
            Description = 'Comment';
            Editable = false;
        }
        field(47; "No. Printed"; Integer)
        {
            Description = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Description = 'On Hold ';
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type_HGN")
        {
            Description = 'Applies-to Doc. Type';
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Description = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            //TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            //ELSE
            //IF (Bal.Account Type=CONST(Bank Account)) "Bank Account";
            Description = 'Bal. Account No.';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Description = 'VAT Registration No.';
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
        field(98; Correction; Boolean)
        {
            Description = 'Correction';
        }
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
            //OnValidate =BEGIN
            //IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
            //VALIDATE("Shipping Agent Service Code",'');
            //END;
            //AccessByPermission = TableData 5790 = R;
            Description = 'Shipping Agent Code';
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Description = 'Package Tracking No.';
        }
        field(109; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'No. Series';
            Editable = false;
        }
        field(110; "Order No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Order No. Series';
        }
        field(112; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
            //OnLookup =VAR
            //UserMgt@1000 : Codeunit 418;
            //BEGIN
            //UserMgt.LookupUserID("User ID");
            //UserMgt.LookupUserIDNoEdit("User ID"); //CO4.30: Controling - UserLookup;
            //END;
            //TestTableRelation =No;
            Description = 'User ID';
            //Description=CO ';
        }
        field(113; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Description = 'Source Code';
        }
        field(114; "Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Description = 'Tax Area Code';
        }
        field(115; "Tax Liable"; Boolean)
        {
            Description = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Description = 'VAT Bus. Posting Group';
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Description = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(151; "Quote No."; Code[20])
        {
            Description = 'Quote No.';
            Editable = False;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            //OnLookup =BEGIN
            //ShowDimensions;
            //END;
            Description = 'Dimension Set ID';
            //Editable=No ';
        }
        field(5050; "Campaign No."; Code[20])
        {
            TableRelation = Campaign;
            Description = 'Campaign No.';
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
        field(5055; "Opportunity No."; Code[20])
        {
            TableRelation = Opportunity;
            Description = 'Opportunity No.';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
            Description = 'Responsibility Center';
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
            AccessByPermission = TableData 5790 = R;
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
        field(7001; "Allow Line Disc."; Boolean)
        {
            Description = 'Allow Line Disc.';
        }
        field(11700; "Bank Account Code"; Code[20])
        {
            //TableRelation = "Bank Account" WHERE("Account Type" = CONST("Bank Account"));
            Description = 'Bank Account Code';
        }
        field(11701; "Bank Account No."; Text[30])
        {
            Description = 'Bank Account No.';
        }
        field(11702; "Bank Branch No."; Text[20])
        {
            Description = 'Bank Branch No.';
        }
        field(11707; "IBAN"; Code[50])
        {
            Description = 'IBAN';
        }
        field(11708; "SWIFT Code"; Code[20])
        {
            Description = 'SWIFT Code';
        }
        field(11709; "Bank Name"; Text[50])
        {
            Description = 'Bank Name';
        }
        field(11790; "Registration No."; Text[20])
        {
            Description = 'Registration No.';
        }
        field(11791; "Tax Registration No."; Text[20])
        {
            Description = 'Tax Registration No.';
        }
        field(11792; "Original User ID"; Code[50])
        {
            TableRelation = User."User Name";
            //OnLookup =VAR
            //LoginMgt@1220000 : Codeunit 418;
            //BEGIN
            // NAVCZ
            //LoginMgt.LookupUserID("Original User ID");
            // NAVCZ
            //LoginMgt.LookupUserIDNoEdit("Original User ID"); //CO4.30: Controling - UserLookup;
            //END;
            //ValidateTableRelation=No;
            //TestTableRelation=No;
            Description = 'Original User ID';
            //Description=CO ';
        }
        field(11793; "Quote Validity"; Date)
        {
            Description = 'Quote Validity';
        }
        field(11794; "Expedition Date"; Date)
        {
            Description = 'Expedition Date';
        }
        field(11795; "Expedition Time"; Time)
        {
            Description = 'Expedition Time';
        }
        field(11796; "Delivery Transport Method"; Code[10])
        {
            TableRelation = "Transport Method";
            Description = 'Delivery Transport Method';
        }
        field(31060; "Perform. Country/Region Code"; Code[10])
        {
            //TableRelation = "Registration Country/Region"."Country/Region Code" WHERE(Type = CONST(" "), "No." = FILTER(''));
            Description = 'Perform. Country/Region Code';
        }
        field(31063; "Physical Transfer"; Boolean)
        {
            Description = 'Physical Transfer';
        }
        field(31064; "Intrastat Exclude"; Boolean)
        {
            Description = 'Intrastat Exclude';
        }
        field(31065; "Industry Code"; Code[20])
        {
            //TableRelation="Industry Code";
            Description = 'Industry Code';
        }
        field(31066; "EU 3-Party Intermediate Role"; Boolean)
        {
            Description = 'EU 3-Party Intermediate Role';
        }
        field(50017; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        field(50100; "Assigned Job No."; Code[20])
        {
            TableRelation = Job;
            Description = 'Assigned Job No.';
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
        field(55014; "Hybris Order No."; Code[20])
        {
            Description = 'Hybris Order No.';
        }
        field(55015; HybrisPoCreated; Boolean)
        {
            Description = 'HybrisPoCreated';
        }
        field(55016; HybrisPurchaseOrder; Code[25])
        {
            Description = 'HybrisPurchaseOrder';
        }
        field(55019; "Zero Value Order"; Boolean)
        {
            Description = 'Zero Value Order';
        }
        field(55050; "Cancel / Short Close"; Option)
        {
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = ,Cancelled,"Short Closed";
            Description = 'Cancel / Short Close';
        }
    }
    KEYS
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Order No.")
        {
        }
        key(Key3; "Bill-to Customer No.")
        {
        }
        key(Key4; "Sell-to Customer No.")
        {
        }
        key(Key5; "Posting Date")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Sell-to Customer No.", "Sell-to Customer Name", "Posting Date", "Posting Description")
        {
        }
    }
}

