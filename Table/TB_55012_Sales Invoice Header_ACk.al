table 55012 "Sales Invoice Header_ACk"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Description = 'Sell-to Customer No.';
            NotBlank = true;
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
            ;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Description = 'Ship-to Contact';
            ;
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
            ;
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
            AccessByPermission = TableData 110 = R;
            Description = 'Order No.';
        }
        field(46; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = CONST("Posted Invoice"), "No." = FIELD("No."), "Document Line No." = CONST(0)));
            Description = 'Comment';
            Editable = true;
        }
        field(47; "No. Printed"; Integer)
        {
            Description = 'No. Printed';
            Editable = false;
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
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            Description = 'Bal. Account No.';
        }
        field(60; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Document No." = FIELD("No.")));
            Description = 'Amount';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Description = 'Amount Including VAT';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
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
            OptionCaption = 'G/L Account, Bank Account';
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
            AccessByPermission = TableData 5790 = R;
            Description = 'Shipping Agent Code';
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Description = 'Package Tracking No.';
        }
        field(107; "Pre-Assigned No. Series"; Code[10])
        {
            ; TableRelation = "No. Series";
            Description = 'Pre-Assigned No. Series';
        }
        field(108; "No. Series"; Code[10])
        {
            ; TableRelation = "No. Series";
            Description = 'No. Series';
            Editable = false;
        }
        field(110; "Order No. Series"; Code[10])
        {
            ; TableRelation = "No. Series";
            Description = 'Order No. Series';
        }
        field(111; "Pre-Assigned No."; Code[20])
        {
            Description = 'Pre-Assigned No.';
        }
        field(112; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
            Description = 'User ID';
            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            BEGIN
                UserMgt.LookupUserID("User ID");
            END;
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
        field(131; "Prepayment No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Description = 'Prepayment No. Series';
        }
        field(136; "Prepayment Invoice"; Boolean)
        {
            Description = 'Prepayment Invoice';
        }
        field(137; "Prepayment Order No."; Code[20])
        {
            Description = 'Prepayment Order No.';
        }
        field(151; "Quote No."; Code[20])
        {
            Description = 'Quote No.';
            Editable = false;
        }
        field(200; "Work Description"; BLOB)
        {
            Description = 'Work Description';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            ; TableRelation = "Dimension Set Entry";
            Description = 'Dimension Set ID';
            Editable = false;
        }
        field(600; "Payment Service Set ID"; Integer)
        {
            Description = 'Payment Service Set ID';
        }
        field(710; "Document Exchange Identifier"; Text[50])
        {
            Description = 'Document Exchange Identifier';
        }
        field(711; "Document Exchange Status"; Option)
        {
            OptionCaption = 'Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient';
            OptionMembers = "Not Sent","Sent to Document Exchange Service","Delivered to Recipient","Delivery Failed","Pending Connection to Recipient";
        }
        field(712; "Doc. Exch. Original Identifier"; Text[50])
        {

            Description = 'Doc. Exch. Original Identifier';
        }
        field(720; "Coupled to CRM"; Boolean)
        {
            Description = 'Coupled to Dynamics CRM';
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."));
            Description = 'Direct Debit Mandate ID';
        }
        field(1302; Closed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = - Exist("Cust. Ledger Entry" WHERE("Entry No." = FIELD("Cust. Ledger Entry No."), Open = FILTER(true)));
            Description = 'Closed';
            Editable = false;
        }
        field(1303; "Remaining Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Cust. Ledger Entry No." = FIELD("Cust. Ledger Entry No.")));
            Description = 'Remaining Amount';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(1304; "Cust. Ledger Entry No."; Integer)
        {
            TableRelation = "Cust. Ledger Entry"."Entry No.";
            Description = 'Cust. Ledger Entry No.';
            Editable = false;
        }
        field(1305; "Invoice Discount Amount"; Decimal)
        {
            ; FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Inv. Discount Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'Invoice Discount Amount';
            Editable = false;
            AutoFormatType = 1;
        }
        field(1310; Cancelled; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Cancelled Document" WHERE("Source ID" = CONST(112), "Cancelled Doc. No." = FIELD("No.")));
            Description = 'Cancelled';
            Editable = false;
        }
        field(1311; Corrective; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Cancelled Document" WHERE("Source ID" = CONST(114), "Cancelled By Doc. No." = FIELD("No.")));
            Description = 'Corrective';
            Editable = false;
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
            ; TableRelation = "Responsibility Center";
            Description = 'Responsibility Center';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Description = 'Allow Line Disc.';
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Description = 'Get Shipment Used';
        }
        field(50017; "Job No."; Code[20])
        {
            Description = 'Job No.';
            Editable = false;
        }
        field(50100; "Assigned Job No."; Code[20])
        {
            TableRelation = Job;
            Description = 'Assigned Job No.';
            Editable = false;
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
        key(PK; "No.")
        {
            Clustered = true;
        }
        //     key("Order No.")
        //     {

        //     }
        //        {    ;Order No.                                }
        // {    ;Pre-Assigned No.                         }
        // {    ;Sell-to Customer No.,External Document No.;
        //                                                MaintainSQLIndex=No }
        // {    ;Sell-to Customer No.,Order Date         ;MaintainSQLIndex=No }
        // {    ;Sell-to Customer No.                     }
        // {    ;Prepayment Order No.,Prepayment Invoice  }
        // {    ;Bill-to Customer No.                     }
        // {    ;Posting Date                             }
        // {    ;Document Exchange Status                 }
    }
    //FIELDGROUPS
    //{
    //{ 1   ;DropDown            ;No.,Sell-to Customer No.,Bill-to Customer No.,Posting Date,Posting Description }
    //{ 2   ;Brick               ;No.,Sell-to Customer Name,Amount,Due Date,Amount Including VAT }
    //}

    // var

    //     PostedHeader: Record "Posted Deferral Header";
    //     PostSalesDelete: Codeunit "PostSales-Delete";
    //     DeferralUtilities: Codeunit "Deferral Utilities";

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
