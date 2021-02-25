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
            TableRelation = Location WHERE("Use As In-Transit" = CONST(No));
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
            TestTableRelation = false;
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
            TestTableRelation = false;
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
            TestTableRelation = false;
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
            TestTableRelation = false;
            Description = 'User ID';
            trigger OnValidate()
            var
                UserMgt: Codeunit 418;
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
            CalcFormula = - Exist("Cust. Ledger Entry" WHERE("Entry No." = FIELD("Cust. Ledger Entry No."), Open = FILTER(Yes)));
            Description = 'Closed';
            Editable = false;
        }
        field(1303; "Remaining Amount"; Decimal)
        {
            ; FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Cust. Ledger Entry No.""=FIELD(Cust. Ledger Entry No.)));
                                                   CaptionML=ENU=Remaining Amount;
            Editable =No;
            AutoFormatType = 1;
            AutoFormatExpr ="Currency Code" }
        field(1304; "Cust. Ledger Entry No."; Integer     ; TableRelation = "Cust. Ledger Entry"."Entry No.";
            TestTableRelation =No;
            CaptionML = ENU =Cust. Ledger Entry No.;
            Editable =No }
        field(1305; "Invoice Discount Amount"; Decimal)
        {
            ; FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Inv. Discount Amount" WHERE(Document No.=FIELD(No.)));
                                                   CaptionML=ENU=Invoice Discount Amount;
                                                   Editable=No;
                                                   AutoFormatType=1 }
field( 1310;Cancelled           ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=Exist("Cancelled Document" WHERE (Source ID=CONST(112),
                                                                                                 Cancelled Doc. No.=FIELD(No.)));
                                                   CaptionML=ENU=Cancelled;
                                                   Editable=No }
field( 1311;Corrective          ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=Exist("Cancelled Document" WHERE (Source ID=CONST(114),
                                                                                                 Cancelled By Doc. No.=FIELD(No.)));
                                                   CaptionML=ENU=Corrective;
                                                   Editable=No }
field( 5050;"Campaign No."        ;Code[20]){        ;TableRelation=Campaign;
                                                   CaptionML=ENU=Campaign No. }
field( 5052;"Sell-to Contact No." ;Code[20]){        ;TableRelation=Contact;
                                                   CaptionML=ENU=Sell-to Contact No. }
field( 5053;"Bill-to Contact No." ;Code[20]){        ;TableRelation=Contact;
                                                   CaptionML=ENU=Bill-to Contact No. }
field( 5055;"Opportunity No."     ;Code[20]){        ;TableRelation=Opportunity;
                                                   CaptionML=ENU=Opportunity No. }
field( 5700;"Responsibility Center";Code[10]){       ;TableRelation="Responsibility Center";
                                                   CaptionML=ENU=Responsibility Center }
field( 7001;"Allow Line Disc."    ;Boolean       Description='Allow Line Disc. }
field( 7200;"Get Shipment Used"   ;Boolean       Description='Get Shipment Used }
field( 50017;  "Job No."             ;Code[20]){        ;Description=KB 23.09.13;
                                                   Editable=No }
field( 50100;  "Assigned Job No."    ;Code[20]){        ;TableRelation=Job;
                                                   CaptionML=[ENU=Assigned Job No.;
                                                              ENG=Assigned Job No.];
                                                   Description=IFRS15;
                                                   Editable=No }
field( 55000;  "Order Type"          ;Code[10]){         }
field( 55001;  "Work Order No."      ;Text[30]){         }
field( 55002;  "User Email"          ;Text[50]){         }
field( 55003;  "Ship-to Freight"     ;Text[30]){         }
field( 55004;  "Order Inserted"     ;Boolean){        }
field( 55005;  "Order Created"       ;Boolean){        }
    }

    keys
    {
        key(PK; MyField)
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
OBJECT Table 55012 Sales Invoice Header_ACk
{
  OBJECT-PROPERTIES
  {
    Date=12/01/20;
           Time =[ 7:03:18 AM];
           Modified =Yes;
           Version List=Smax1.0;
  }
  PROPERTIES
  {
    DataCaptionFields=No.,Sell-to Customer Name;
    OnDelete=VAR
               PostedDeferralHeader@1002 : Record 1704;
               PostSalesDelete@1003 : Codeunit 363;
               DeferralUtilities@1001 : Codeunit 1720;
             BEGIN
             END;

    CaptionML=ENU=Sales Invoice Header;
    LookupPageID=Page143;
    DrillDownPageID=Page143;
  }
  FIELDS
  {
    { 2   ;   ;Sell-to Customer No.;Code20        ;TableRelation=Customer;
                                                   CaptionML=ENU=Sell-to Customer No.;
                                                   NotBlank=Yes }
    { 3   ;   ;No.                 ;Code20        Description='No. }
    { 4   ;   ;Bill-to Customer No.;Code20        ;TableRelation=Customer;
                                                   CaptionML=ENU=Bill-to Customer No.;
                                                   NotBlank=Yes }
    { 5   ;   ;Bill-to Name        ;Text50        Description='Bill-to Name }
    { 6   ;   ;Bill-to Name 2      ;Text50        Description='Bill-to Name 2 }
    { 7   ;   ;Bill-to Address     ;Text50        Description='Bill-to Address }
    { 8   ;   ;Bill-to Address 2   ;Text50        Description='Bill-to Address 2 }
    { 9   ;   ;Bill-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Bill-to City }
    { 10  ;   ;Bill-to Contact     ;Text50        Description='Bill-to Contact }
    { 11  ;   ;Your Reference      ;Text35        Description='Your Reference }
    { 12  ;   ;Ship-to Code        ;Code10        ;TableRelation="Ship-to Address".Code WHERE (Customer No.=FIELD(Sell-to Customer No.));
                                                   CaptionML=ENU=Ship-to Code }
    { 13  ;   ;Ship-to Name        ;Text50        Description='Ship-to Name }
    { 14  ;   ;Ship-to Name 2      ;Text50        Description='Ship-to Name 2 }
    { 15  ;   ;Ship-to Address     ;Text50        Description='Ship-to Address }
    { 16  ;   ;Ship-to Address 2   ;Text50        Description='Ship-to Address 2 }
    { 17  ;   ;Ship-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Ship-to City }
    { 18  ;   ;Ship-to Contact     ;Text50        Description='Ship-to Contact }
    { 19  ;   ;Order Date          ;Date          Description='Order Date }
    { 20  ;   ;Posting Date        ;Date          Description='Posting Date }
    { 21  ;   ;Shipment Date       ;Date          Description='Shipment Date }
    { 22  ;   ;Posting Description ;Text50        Description='Posting Description }
    { 23  ;   ;Payment Terms Code  ;Code10        ;TableRelation="Payment Terms";
                                                   CaptionML=ENU=Payment Terms Code }
    { 24  ;   ;Due Date            ;Date          Description='Due Date }
    { 25  ;   ;Payment Discount %  ;Decimal       Description='Payment Discount %;
                                                   DecimalPlaces=0:5;
                                                   MinValue=0;
                                                   MaxValue=100 }
    { 26  ;   ;Pmt. Discount Date  ;Date          Description='Pmt. Discount Date }
    { 27  ;   ;Shipment Method Code;Code10        ;TableRelation="Shipment Method";
                                                   CaptionML=ENU=Shipment Method Code }
    { 28  ;   ;Location Code       ;Code10        ;TableRelation=Location WHERE (Use As In-Transit=CONST(No));
                                                   CaptionML=ENU=Location Code }
    { 29  ;   ;Shortcut Dimension 1 Code;Code20   ;TableRelation="Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
                                                   CaptionML=ENU=Shortcut Dimension 1 Code;
                                                   CaptionClass='1,2,1' }
    { 30  ;   ;Shortcut Dimension 2 Code;Code20   ;TableRelation="Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
                                                   CaptionML=ENU=Shortcut Dimension 2 Code;
                                                   CaptionClass='1,2,2' }
    { 31  ;   ;Customer Posting Group;Code10      ;TableRelation="Customer Posting Group";
                                                   CaptionML=ENU=Customer Posting Group;
                                                   Editable=No }
    { 32  ;   ;Currency Code       ;Code10        ;TableRelation=Currency;
                                                   CaptionML=ENU=Currency Code;
                                                   Editable=No }
    { 33  ;   ;Currency Factor     ;Decimal       Description='Currency Factor;
                                                   DecimalPlaces=0:15;
                                                   MinValue=0 }
    { 34  ;   ;Customer Price Group;Code10        ;TableRelation="Customer Price Group";
                                                   CaptionML=ENU=Customer Price Group }
    { 35  ;   ;Prices Including VAT;Boolean       Description='Prices Including VAT }
    { 37  ;   ;Invoice Disc. Code  ;Code20        Description='Invoice Disc. Code }
    { 40  ;   ;Customer Disc. Group;Code20        ;TableRelation="Customer Discount Group";
                                                   CaptionML=ENU=Customer Disc. Group }
    { 41  ;   ;Language Code       ;Code10        ;TableRelation=Language;
                                                   CaptionML=ENU=Language Code }
    { 43  ;   ;Salesperson Code    ;Code10        ;TableRelation=Salesperson/Purchaser;
                                                   CaptionML=ENU=Salesperson Code }
    { 44  ;   ;Order No.           ;Code20        ;AccessByPermission=TableData 110=R;
                                                   CaptionML=ENU=Order No. }
    { 46  ;   ;Comment             ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=Exist("Sales Comment Line" WHERE (Document Type=CONST(Posted Invoice),
                                                                                                 No.=FIELD(No.),
                                                                                                 Document Line No.=CONST(0)));
                                                   CaptionML=ENU=Comment;
                                                   Editable=No }
    { 47  ;   ;No. Printed         ;Integer       Description='No. Printed;
                                                   Editable=No }
    { 51  ;   ;On Hold             ;Code3         Description='On Hold }
    { 52  ;   ;Applies-to Doc. Type;Option        Description='Applies-to Doc. Type;
                                                   OptionCaptionML=ENU=" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund";
                                                   OptionString=[ ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund] }
    { 53  ;   ;Applies-to Doc. No. ;Code20        Description='Applies-to Doc. No. }
    { 55  ;   ;Bal. Account No.    ;Code20        ;TableRelation=IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                                                                 ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
                                                   CaptionML=ENU=Bal. Account No. }
    { 60  ;   ;Amount              ;Decimal       ;FieldClass=FlowField;
                                                   CalcFormula=Sum("Sales Invoice Line".Amount WHERE (Document No.=FIELD(No.)));
                                                   CaptionML=ENU=Amount;
                                                   Editable=No;
                                                   AutoFormatType=1;
                                                   AutoFormatExpr="Currency Code" }
    { 61  ;   ;Amount Including VAT;Decimal       ;FieldClass=FlowField;
                                                   CalcFormula=Sum("Sales Invoice Line"."Amount Including VAT" WHERE (Document No.=FIELD(No.)));
                                                   CaptionML=ENU=Amount Including VAT;
                                                   Editable=No;
                                                   AutoFormatType=1;
                                                   AutoFormatExpr="Currency Code" }
    { 70  ;   ;VAT Registration No.;Text20        Description='VAT Registration No. }
    { 73  ;   ;Reason Code         ;Code10        ;TableRelation="Reason Code";
                                                   CaptionML=ENU=Reason Code }
    { 74  ;   ;Gen. Bus. Posting Group;Code10     ;TableRelation="Gen. Business Posting Group";
                                                   CaptionML=ENU=Gen. Bus. Posting Group }
    { 75  ;   ;EU 3-Party Trade    ;Boolean       Description='EU 3-Party Trade }
    { 76  ;   ;Transaction Type    ;Code10        ;TableRelation="Transaction Type";
                                                   CaptionML=ENU=Transaction Type }
    { 77  ;   ;Transport Method    ;Code10        ;TableRelation="Transport Method";
                                                   CaptionML=ENU=Transport Method }
    { 78  ;   ;VAT Country/Region Code;Code10     ;TableRelation=Country/Region;
                                                   CaptionML=ENU=VAT Country/Region Code }
    { 79  ;   ;Sell-to Customer Name;Text50       Description='Sell-to Customer Name }
    { 80  ;   ;Sell-to Customer Name 2;Text50     Description='Sell-to Customer Name 2 }
    { 81  ;   ;Sell-to Address     ;Text50        Description='Sell-to Address }
    { 82  ;   ;Sell-to Address 2   ;Text50        Description='Sell-to Address 2 }
    { 83  ;   ;Sell-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Sell-to City }
    { 84  ;   ;Sell-to Contact     ;Text50        Description='Sell-to Contact }
    { 85  ;   ;Bill-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Bill-to Post Code }
    { 86  ;   ;Bill-to County      ;Text30        Description='Bill-to County }
    { 87  ;   ;Bill-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Bill-to Country/Region Code }
    { 88  ;   ;Sell-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Sell-to Post Code }
    { 89  ;   ;Sell-to County      ;Text30        Description='Sell-to County }
    { 90  ;   ;Sell-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Sell-to Country/Region Code }
    { 91  ;   ;Ship-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Ship-to Post Code }
    { 92  ;   ;Ship-to County      ;Text30        Description='Ship-to County }
    { 93  ;   ;Ship-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Ship-to Country/Region Code }
    { 94  ;   ;Bal. Account Type   ;Option        Description='Bal. Account Type;
                                                   OptionCaptionML=ENU=G/L Account,Bank Account;
                                                   OptionString=G/L Account,Bank Account }
    { 97  ;   ;Exit Point          ;Code10        ;TableRelation="Entry/Exit Point";
                                                   CaptionML=ENU=Exit Point }
    { 98  ;   ;Correction          ;Boolean       Description='Correction }
    { 99  ;   ;Document Date       ;Date          Description='Document Date }
    { 100 ;   ;External Document No.;Code35       Description='External Document No. }
    { 101 ;   ;Area                ;Code10        ;TableRelation=Area;
                                                   CaptionML=ENU=Area }
    { 102 ;   ;Transaction Specification;Code10   ;TableRelation="Transaction Specification";
                                                   CaptionML=ENU=Transaction Specification }
    { 104 ;   ;Payment Method Code ;Code10        ;TableRelation="Payment Method";
                                                   CaptionML=ENU=Payment Method Code }
    { 105 ;   ;Shipping Agent Code ;Code10        ;TableRelation="Shipping Agent";
                                                   AccessByPermission=TableData 5790=R;
                                                   CaptionML=ENU=Shipping Agent Code }
    { 106 ;   ;Package Tracking No.;Text30        Description='Package Tracking No. }
    { 107 ;   ;Pre-Assigned No. Series;Code10     ;TableRelation="No. Series";
                                                   CaptionML=ENU=Pre-Assigned No. Series }
    { 108 ;   ;No. Series          ;Code10        ;TableRelation="No. Series";
                                                   CaptionML=ENU=No. Series;
                                                   Editable=No }
    { 110 ;   ;Order No. Series    ;Code10        ;TableRelation="No. Series";
                                                   CaptionML=ENU=Order No. Series }
    { 111 ;   ;Pre-Assigned No.    ;Code20        Description='Pre-Assigned No. }
    { 112 ;   ;User ID             ;Code50        ;TableRelation=User."User Name";
                                                   OnLookup=VAR
                                                              UserMgt@1000 : Codeunit 418;
                                                            BEGIN
                                                              UserMgt.LookupUserID("User ID");
                                                            END;

                                                   TestTableRelation=No;
                                                   CaptionML=ENU=User ID }
    { 113 ;   ;Source Code         ;Code10        ;TableRelation="Source Code";
                                                   CaptionML=ENU=Source Code }
    { 114 ;   ;Tax Area Code       ;Code20        ;TableRelation="Tax Area";
                                                   CaptionML=ENU=Tax Area Code }
    { 115 ;   ;Tax Liable          ;Boolean       Description='Tax Liable }
    { 116 ;   ;VAT Bus. Posting Group;Code10      ;TableRelation="VAT Business Posting Group";
                                                   CaptionML=ENU=VAT Bus. Posting Group }
    { 119 ;   ;VAT Base Discount % ;Decimal       Description='VAT Base Discount %;
                                                   DecimalPlaces=0:5;
                                                   MinValue=0;
                                                   MaxValue=100 }
    { 131 ;   ;Prepayment No. Series;Code10       ;TableRelation="No. Series";
                                                   CaptionML=ENU=Prepayment No. Series }
    { 136 ;   ;Prepayment Invoice  ;Boolean       Description='Prepayment Invoice }
    { 137 ;   ;Prepayment Order No.;Code20        Description='Prepayment Order No. }
    { 151 ;   ;Quote No.           ;Code20        Description='Quote No.;
                                                   Editable=No }
    { 200 ;   ;Work Description    ;BLOB          Description='Work Description }
    { 480 ;   ;Dimension Set ID    ;Integer       ;TableRelation="Dimension Set Entry";
                                                   CaptionML=ENU=Dimension Set ID;
                                                   Editable=No }
    { 600 ;   ;Payment Service Set ID;Integer     Description='Payment Service Set ID }
    { 710 ;   ;Document Exchange Identifier;Text50Description='Document Exchange Identifier }
    { 711 ;   ;Document Exchange Status;Option    Description='Document Exchange Status;
                                                   OptionCaptionML=ENU=Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient;
                                                   OptionString=Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient }
    { 712 ;   ;Doc. Exch. Original Identifier;Text50;
                                                   CaptionML=ENU=Doc. Exch. Original Identifier }
    { 720 ;   ;Coupled to CRM      ;Boolean       Description='Coupled to Dynamics CRM }
    { 1200;   ;Direct Debit Mandate ID;Code35     ;TableRelation="SEPA Direct Debit Mandate" WHERE (Customer No.=FIELD(Bill-to Customer No.));
                                                   CaptionML=ENU=Direct Debit Mandate ID }
    { 1302;   ;Closed              ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=-Exist("Cust. Ledger Entry" WHERE (Entry No.=FIELD(Cust. Ledger Entry No.),
                                                                                                  Open=FILTER(Yes)));
                                                   CaptionML=ENU=Closed;
                                                   Editable=No }
    { 1303;   ;Remaining Amount    ;Decimal       ;FieldClass=FlowField;
                                                   CalcFormula=Sum("Detailed Cust. Ledg. Entry".Amount WHERE (Cust. Ledger Entry No.=FIELD(Cust. Ledger Entry No.)));
                                                   CaptionML=ENU=Remaining Amount;
                                                   Editable=No;
                                                   AutoFormatType=1;
                                                   AutoFormatExpr="Currency Code" }
    { 1304;   ;Cust. Ledger Entry No.;Integer     ;TableRelation="Cust. Ledger Entry"."Entry No.";
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Cust. Ledger Entry No.;
                                                   Editable=No }
    { 1305;   ;Invoice Discount Amount;Decimal    ;FieldClass=FlowField;
                                                   CalcFormula=Sum("Sales Invoice Line"."Inv. Discount Amount" WHERE (Document No.=FIELD(No.)));
                                                   CaptionML=ENU=Invoice Discount Amount;
                                                   Editable=No;
                                                   AutoFormatType=1 }
    { 1310;   ;Cancelled           ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=Exist("Cancelled Document" WHERE (Source ID=CONST(112),
                                                                                                 Cancelled Doc. No.=FIELD(No.)));
                                                   CaptionML=ENU=Cancelled;
                                                   Editable=No }
    { 1311;   ;Corrective          ;Boolean       ;FieldClass=FlowField;
                                                   CalcFormula=Exist("Cancelled Document" WHERE (Source ID=CONST(114),
                                                                                                 Cancelled By Doc. No.=FIELD(No.)));
                                                   CaptionML=ENU=Corrective;
                                                   Editable=No }
    { 5050;   ;Campaign No.        ;Code20        ;TableRelation=Campaign;
                                                   CaptionML=ENU=Campaign No. }
    { 5052;   ;Sell-to Contact No. ;Code20        ;TableRelation=Contact;
                                                   CaptionML=ENU=Sell-to Contact No. }
    { 5053;   ;Bill-to Contact No. ;Code20        ;TableRelation=Contact;
                                                   CaptionML=ENU=Bill-to Contact No. }
    { 5055;   ;Opportunity No.     ;Code20        ;TableRelation=Opportunity;
                                                   CaptionML=ENU=Opportunity No. }
    { 5700;   ;Responsibility Center;Code10       ;TableRelation="Responsibility Center";
                                                   CaptionML=ENU=Responsibility Center }
    { 7001;   ;Allow Line Disc.    ;Boolean       Description='Allow Line Disc. }
    { 7200;   ;Get Shipment Used   ;Boolean       Description='Get Shipment Used }
    { 50017;  ;Job No.             ;Code20        ;Description=KB 23.09.13;
                                                   Editable=No }
    { 50100;  ;Assigned Job No.    ;Code20        ;TableRelation=Job;
                                                   CaptionML=[ENU=Assigned Job No.;
                                                              ENG=Assigned Job No.];
                                                   Description=IFRS15;
                                                   Editable=No }
    { 55000;  ;Order Type          ;Code10         }
    { 55001;  ;Work Order No.      ;Text30         }
    { 55002;  ;User Email          ;Text50         }
    { 55003;  ;Ship-to Freight     ;Text30         }
    { 55004;  ;Order Inserted      ;Boolean        }
    { 55005;  ;Order Created       ;Boolean        }
  }
  KEYS
  {
    {    ;No.                                     ;Clustered=Yes }
    {    ;Order No.                                }
    {    ;Pre-Assigned No.                         }
    {    ;Sell-to Customer No.,External Document No.;
                                                   MaintainSQLIndex=No }
    {    ;Sell-to Customer No.,Order Date         ;MaintainSQLIndex=No }
    {    ;Sell-to Customer No.                     }
    {    ;Prepayment Order No.,Prepayment Invoice  }
    {    ;Bill-to Customer No.                     }
    {    ;Posting Date                             }
    {    ;Document Exchange Status                 }
  }
  FIELDGROUPS
  {
    { 1   ;DropDown            ;No.,Sell-to Customer No.,Bill-to Customer No.,Posting Date,Posting Description }
    { 2   ;Brick               ;No.,Sell-to Customer Name,Amount,Due Date,Amount Including VAT }
  }
  CODE
  {

    BEGIN
    {
      KMS:KMS1701-KMSDIVS13.2-21/02/2017-RVI
      Added fields "Bank No.", "Bank Name", "Bank Account No.", "Bank Branch No.", "IBAN",
      KMS:KMS1701-KMSDIVS13.3-21/02/2017-RVI
      Added fields "Delivery Person Name", "Identity Card No.", "Identity Card Authority", "Vehicle Reg. No.",
      "Delivery Transport Method", "Expedition Date", "Expedition Time", "Security No."
      KMS:KMS1701-KMSD39413-21/02/2017-RVI
      Added fields "Not Declaration 394", "Invoicing Mode"
      KMS:KMS1701-21/02/2017-RVI
      Added field "Customer Contract No."
      KMS:KMS1701-KMSCTVA14-20/03/2017-MMI
      Add function GetCheckVatText
      TM TF IFRS15 02/07/18 'IFRS15 Services'
        Fields added
        - 50100 "Assigned Job No."                              CODE20
    }
    END.
  }
}