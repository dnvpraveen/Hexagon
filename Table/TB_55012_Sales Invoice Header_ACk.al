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
    { 3   ;   ;No.                 ;Code20        ;CaptionML=ENU=No. }
    { 4   ;   ;Bill-to Customer No.;Code20        ;TableRelation=Customer;
                                                   CaptionML=ENU=Bill-to Customer No.;
                                                   NotBlank=Yes }
    { 5   ;   ;Bill-to Name        ;Text50        ;CaptionML=ENU=Bill-to Name }
    { 6   ;   ;Bill-to Name 2      ;Text50        ;CaptionML=ENU=Bill-to Name 2 }
    { 7   ;   ;Bill-to Address     ;Text50        ;CaptionML=ENU=Bill-to Address }
    { 8   ;   ;Bill-to Address 2   ;Text50        ;CaptionML=ENU=Bill-to Address 2 }
    { 9   ;   ;Bill-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Bill-to City }
    { 10  ;   ;Bill-to Contact     ;Text50        ;CaptionML=ENU=Bill-to Contact }
    { 11  ;   ;Your Reference      ;Text35        ;CaptionML=ENU=Your Reference }
    { 12  ;   ;Ship-to Code        ;Code10        ;TableRelation="Ship-to Address".Code WHERE (Customer No.=FIELD(Sell-to Customer No.));
                                                   CaptionML=ENU=Ship-to Code }
    { 13  ;   ;Ship-to Name        ;Text50        ;CaptionML=ENU=Ship-to Name }
    { 14  ;   ;Ship-to Name 2      ;Text50        ;CaptionML=ENU=Ship-to Name 2 }
    { 15  ;   ;Ship-to Address     ;Text50        ;CaptionML=ENU=Ship-to Address }
    { 16  ;   ;Ship-to Address 2   ;Text50        ;CaptionML=ENU=Ship-to Address 2 }
    { 17  ;   ;Ship-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Ship-to City }
    { 18  ;   ;Ship-to Contact     ;Text50        ;CaptionML=ENU=Ship-to Contact }
    { 19  ;   ;Order Date          ;Date          ;CaptionML=ENU=Order Date }
    { 20  ;   ;Posting Date        ;Date          ;CaptionML=ENU=Posting Date }
    { 21  ;   ;Shipment Date       ;Date          ;CaptionML=ENU=Shipment Date }
    { 22  ;   ;Posting Description ;Text50        ;CaptionML=ENU=Posting Description }
    { 23  ;   ;Payment Terms Code  ;Code10        ;TableRelation="Payment Terms";
                                                   CaptionML=ENU=Payment Terms Code }
    { 24  ;   ;Due Date            ;Date          ;CaptionML=ENU=Due Date }
    { 25  ;   ;Payment Discount %  ;Decimal       ;CaptionML=ENU=Payment Discount %;
                                                   DecimalPlaces=0:5;
                                                   MinValue=0;
                                                   MaxValue=100 }
    { 26  ;   ;Pmt. Discount Date  ;Date          ;CaptionML=ENU=Pmt. Discount Date }
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
    { 33  ;   ;Currency Factor     ;Decimal       ;CaptionML=ENU=Currency Factor;
                                                   DecimalPlaces=0:15;
                                                   MinValue=0 }
    { 34  ;   ;Customer Price Group;Code10        ;TableRelation="Customer Price Group";
                                                   CaptionML=ENU=Customer Price Group }
    { 35  ;   ;Prices Including VAT;Boolean       ;CaptionML=ENU=Prices Including VAT }
    { 37  ;   ;Invoice Disc. Code  ;Code20        ;CaptionML=ENU=Invoice Disc. Code }
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
    { 47  ;   ;No. Printed         ;Integer       ;CaptionML=ENU=No. Printed;
                                                   Editable=No }
    { 51  ;   ;On Hold             ;Code3         ;CaptionML=ENU=On Hold }
    { 52  ;   ;Applies-to Doc. Type;Option        ;CaptionML=ENU=Applies-to Doc. Type;
                                                   OptionCaptionML=ENU=" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund";
                                                   OptionString=[ ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund] }
    { 53  ;   ;Applies-to Doc. No. ;Code20        ;CaptionML=ENU=Applies-to Doc. No. }
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
    { 70  ;   ;VAT Registration No.;Text20        ;CaptionML=ENU=VAT Registration No. }
    { 73  ;   ;Reason Code         ;Code10        ;TableRelation="Reason Code";
                                                   CaptionML=ENU=Reason Code }
    { 74  ;   ;Gen. Bus. Posting Group;Code10     ;TableRelation="Gen. Business Posting Group";
                                                   CaptionML=ENU=Gen. Bus. Posting Group }
    { 75  ;   ;EU 3-Party Trade    ;Boolean       ;CaptionML=ENU=EU 3-Party Trade }
    { 76  ;   ;Transaction Type    ;Code10        ;TableRelation="Transaction Type";
                                                   CaptionML=ENU=Transaction Type }
    { 77  ;   ;Transport Method    ;Code10        ;TableRelation="Transport Method";
                                                   CaptionML=ENU=Transport Method }
    { 78  ;   ;VAT Country/Region Code;Code10     ;TableRelation=Country/Region;
                                                   CaptionML=ENU=VAT Country/Region Code }
    { 79  ;   ;Sell-to Customer Name;Text50       ;CaptionML=ENU=Sell-to Customer Name }
    { 80  ;   ;Sell-to Customer Name 2;Text50     ;CaptionML=ENU=Sell-to Customer Name 2 }
    { 81  ;   ;Sell-to Address     ;Text50        ;CaptionML=ENU=Sell-to Address }
    { 82  ;   ;Sell-to Address 2   ;Text50        ;CaptionML=ENU=Sell-to Address 2 }
    { 83  ;   ;Sell-to City        ;Text30        ;TableRelation="Post Code".City;
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Sell-to City }
    { 84  ;   ;Sell-to Contact     ;Text50        ;CaptionML=ENU=Sell-to Contact }
    { 85  ;   ;Bill-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Bill-to Post Code }
    { 86  ;   ;Bill-to County      ;Text30        ;CaptionML=ENU=Bill-to County }
    { 87  ;   ;Bill-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Bill-to Country/Region Code }
    { 88  ;   ;Sell-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Sell-to Post Code }
    { 89  ;   ;Sell-to County      ;Text30        ;CaptionML=ENU=Sell-to County }
    { 90  ;   ;Sell-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Sell-to Country/Region Code }
    { 91  ;   ;Ship-to Post Code   ;Code20        ;TableRelation="Post Code";
                                                   ValidateTableRelation=No;
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Ship-to Post Code }
    { 92  ;   ;Ship-to County      ;Text30        ;CaptionML=ENU=Ship-to County }
    { 93  ;   ;Ship-to Country/Region Code;Code10 ;TableRelation=Country/Region;
                                                   CaptionML=ENU=Ship-to Country/Region Code }
    { 94  ;   ;Bal. Account Type   ;Option        ;CaptionML=ENU=Bal. Account Type;
                                                   OptionCaptionML=ENU=G/L Account,Bank Account;
                                                   OptionString=G/L Account,Bank Account }
    { 97  ;   ;Exit Point          ;Code10        ;TableRelation="Entry/Exit Point";
                                                   CaptionML=ENU=Exit Point }
    { 98  ;   ;Correction          ;Boolean       ;CaptionML=ENU=Correction }
    { 99  ;   ;Document Date       ;Date          ;CaptionML=ENU=Document Date }
    { 100 ;   ;External Document No.;Code35       ;CaptionML=ENU=External Document No. }
    { 101 ;   ;Area                ;Code10        ;TableRelation=Area;
                                                   CaptionML=ENU=Area }
    { 102 ;   ;Transaction Specification;Code10   ;TableRelation="Transaction Specification";
                                                   CaptionML=ENU=Transaction Specification }
    { 104 ;   ;Payment Method Code ;Code10        ;TableRelation="Payment Method";
                                                   CaptionML=ENU=Payment Method Code }
    { 105 ;   ;Shipping Agent Code ;Code10        ;TableRelation="Shipping Agent";
                                                   AccessByPermission=TableData 5790=R;
                                                   CaptionML=ENU=Shipping Agent Code }
    { 106 ;   ;Package Tracking No.;Text30        ;CaptionML=ENU=Package Tracking No. }
    { 107 ;   ;Pre-Assigned No. Series;Code10     ;TableRelation="No. Series";
                                                   CaptionML=ENU=Pre-Assigned No. Series }
    { 108 ;   ;No. Series          ;Code10        ;TableRelation="No. Series";
                                                   CaptionML=ENU=No. Series;
                                                   Editable=No }
    { 110 ;   ;Order No. Series    ;Code10        ;TableRelation="No. Series";
                                                   CaptionML=ENU=Order No. Series }
    { 111 ;   ;Pre-Assigned No.    ;Code20        ;CaptionML=ENU=Pre-Assigned No. }
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
    { 115 ;   ;Tax Liable          ;Boolean       ;CaptionML=ENU=Tax Liable }
    { 116 ;   ;VAT Bus. Posting Group;Code10      ;TableRelation="VAT Business Posting Group";
                                                   CaptionML=ENU=VAT Bus. Posting Group }
    { 119 ;   ;VAT Base Discount % ;Decimal       ;CaptionML=ENU=VAT Base Discount %;
                                                   DecimalPlaces=0:5;
                                                   MinValue=0;
                                                   MaxValue=100 }
    { 131 ;   ;Prepayment No. Series;Code10       ;TableRelation="No. Series";
                                                   CaptionML=ENU=Prepayment No. Series }
    { 136 ;   ;Prepayment Invoice  ;Boolean       ;CaptionML=ENU=Prepayment Invoice }
    { 137 ;   ;Prepayment Order No.;Code20        ;CaptionML=ENU=Prepayment Order No. }
    { 151 ;   ;Quote No.           ;Code20        ;CaptionML=ENU=Quote No.;
                                                   Editable=No }
    { 200 ;   ;Work Description    ;BLOB          ;CaptionML=ENU=Work Description }
    { 480 ;   ;Dimension Set ID    ;Integer       ;TableRelation="Dimension Set Entry";
                                                   CaptionML=ENU=Dimension Set ID;
                                                   Editable=No }
    { 600 ;   ;Payment Service Set ID;Integer     ;CaptionML=ENU=Payment Service Set ID }
    { 710 ;   ;Document Exchange Identifier;Text50;CaptionML=ENU=Document Exchange Identifier }
    { 711 ;   ;Document Exchange Status;Option    ;CaptionML=ENU=Document Exchange Status;
                                                   OptionCaptionML=ENU=Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient;
                                                   OptionString=Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient }
    { 712 ;   ;Doc. Exch. Original Identifier;Text50;
                                                   CaptionML=ENU=Doc. Exch. Original Identifier }
    { 720 ;   ;Coupled to CRM      ;Boolean       ;CaptionML=ENU=Coupled to Dynamics CRM }
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
    { 7001;   ;Allow Line Disc.    ;Boolean       ;CaptionML=ENU=Allow Line Disc. }
    { 7200;   ;Get Shipment Used   ;Boolean       ;CaptionML=ENU=Get Shipment Used }
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