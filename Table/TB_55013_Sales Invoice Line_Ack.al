OBJECT Table 55013 Sales Invoice Line_Ack
{
  OBJECT-PROPERTIES
  {
    Date=11/10/20;
           Time =[ 9:51:17 AM];
           Modified =Yes;
           Version List=Smax1.0;
  }
  PROPERTIES
  {
    Permissions=TableData 32=r,
                TableData 5802=r;
    OnDelete=VAR
               SalesDocLineComments@1000 : Record 44;
               PostedDeferralHeader@1001 : Record 1704;
             BEGIN
             END;

    CaptionML=ENU=Sales Invoice Line;
    LookupPageID=Page526;
    DrillDownPageID=Page526;
  }
  FIELDS
  {
    { 2   ;   ;Sell-to Customer No.;Code20        ;TableRelation=Customer;
                                                   CaptionML=ENU=Sell-to Customer No.;
                                                   Editable=No }
    { 3   ;   ;Document No.        ;Code20        ;TableRelation="Sales Invoice Header_ACk";
                                                   CaptionML=ENU=Document No. }
    { 4   ;   ;Line No.            ;Integer       ;CaptionML=ENU=Line No. }
    { 5   ;   ;Type                ;Option        ;CaptionML=ENU=Type;
                                                   OptionCaptionML=ENU=" ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)";
                                                   OptionString=[ ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)] }
    { 6   ;   ;No.                 ;Code20        ;CaptionML=ENU=No. }
    { 7   ;   ;Location Code       ;Code10        ;TableRelation=Location WHERE (Use As In-Transit=CONST(No));
                                                   CaptionML=ENU=Location Code }
    { 8   ;   ;Posting Group       ;Code10        ;TableRelation=IF (Type=CONST(Item)) "Inventory Posting Group"
                                                                 ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
                                                   CaptionML=ENU=Posting Group;
                                                   Editable=No }
    { 10  ;   ;Shipment Date       ;Date          ;CaptionML=ENU=Shipment Date }
    { 11  ;   ;Description         ;Text50        ;CaptionML=ENU=Description }
    { 12  ;   ;Description 2       ;Text50        ;CaptionML=ENU=Description 2 }
    { 13  ;   ;Unit of Measure     ;Text10        ;CaptionML=ENU=Unit of Measure }
    { 15  ;   ;Quantity            ;Decimal       ;CaptionML=ENU=Quantity;
                                                   DecimalPlaces=0:5 }
    { 22  ;   ;Unit Price          ;Decimal       ;CaptionML=ENU=Unit Price;
                                                   AutoFormatType=2 }
    { 23  ;   ;Unit Cost (LCY)     ;Decimal       ;CaptionML=ENU=Unit Cost (LCY);
                                                   AutoFormatType=2 }
    { 25  ;   ;VAT %               ;Decimal       ;CaptionML=ENU=VAT %;
                                                   DecimalPlaces=0:5;
                                                   Editable=No }
    { 27  ;   ;Line Discount %     ;Decimal       ;CaptionML=ENU=Line Discount %;
                                                   DecimalPlaces=0:5;
                                                   MinValue=0;
                                                   MaxValue=100 }
    { 28  ;   ;Line Discount Amount;Decimal       ;CaptionML=ENU=Line Discount Amount;
                                                   AutoFormatType=1 }
    { 29  ;   ;Amount              ;Decimal       ;CaptionML=ENU=Amount;
                                                   AutoFormatType=1 }
    { 30  ;   ;Amount Including VAT;Decimal       ;CaptionML=ENU=Amount Including VAT;
                                                   AutoFormatType=1 }
    { 32  ;   ;Allow Invoice Disc. ;Boolean       ;InitValue=Yes;
                                                   CaptionML=ENU=Allow Invoice Disc. }
    { 34  ;   ;Gross Weight        ;Decimal       ;CaptionML=ENU=Gross Weight;
                                                   DecimalPlaces=0:5 }
    { 35  ;   ;Net Weight          ;Decimal       ;CaptionML=ENU=Net Weight;
                                                   DecimalPlaces=0:5 }
    { 36  ;   ;Units per Parcel    ;Decimal       ;CaptionML=ENU=Units per Parcel;
                                                   DecimalPlaces=0:5 }
    { 37  ;   ;Unit Volume         ;Decimal       ;CaptionML=ENU=Unit Volume;
                                                   DecimalPlaces=0:5 }
    { 38  ;   ;Appl.-to Item Entry ;Integer       ;AccessByPermission=TableData 27=R;
                                                   CaptionML=ENU=Appl.-to Item Entry }
    { 40  ;   ;Shortcut Dimension 1 Code;Code20   ;CaptionML=ENU=Shortcut Dimension 1 Code }
    { 41  ;   ;Shortcut Dimension 2 Code;Code20   ;TableRelation="Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
                                                   CaptionML=ENU=Shortcut Dimension 2 Code }
    { 42  ;   ;Customer Price Group;Code10        ;TableRelation="Customer Price Group";
                                                   CaptionML=ENU=Customer Price Group }
    { 45  ;   ;Job No.             ;Code20        ;TableRelation=Job;
                                                   CaptionML=ENU=Job No. }
    { 52  ;   ;Work Type Code      ;Code10        ;TableRelation="Work Type";
                                                   CaptionML=ENU=Work Type Code }
    { 63  ;   ;Shipment No.        ;Code20        ;CaptionML=ENU=Shipment No.;
                                                   Editable=No }
    { 64  ;   ;Shipment Line No.   ;Integer       ;CaptionML=ENU=Shipment Line No.;
                                                   Editable=No }
    { 68  ;   ;Bill-to Customer No.;Code20        ;TableRelation=Customer;
                                                   CaptionML=ENU=Bill-to Customer No.;
                                                   Editable=No }
    { 69  ;   ;Inv. Discount Amount;Decimal       ;CaptionML=ENU=Inv. Discount Amount;
                                                   AutoFormatType=1 }
    { 73  ;   ;Drop Shipment       ;Boolean       ;AccessByPermission=TableData 223=R;
                                                   CaptionML=ENU=Drop Shipment }
    { 74  ;   ;Gen. Bus. Posting Group;Code10     ;TableRelation="Gen. Business Posting Group";
                                                   CaptionML=ENU=Gen. Bus. Posting Group }
    { 75  ;   ;Gen. Prod. Posting Group;Code10    ;TableRelation="Gen. Product Posting Group";
                                                   CaptionML=ENU=Gen. Prod. Posting Group }
    { 77  ;   ;VAT Calculation Type;Option        ;CaptionML=ENU=VAT Calculation Type;
                                                   OptionCaptionML=ENU=Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax;
                                                   OptionString=Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax }
    { 78  ;   ;Transaction Type    ;Code10        ;TableRelation="Transaction Type";
                                                   CaptionML=ENU=Transaction Type }
    { 79  ;   ;Transport Method    ;Code10        ;TableRelation="Transport Method";
                                                   CaptionML=ENU=Transport Method }
    { 80  ;   ;Attached to Line No.;Integer       ;TableRelation="Sales Invoice Line"."Line No." WHERE (Document No.=FIELD(Document No.));
                                                   CaptionML=ENU=Attached to Line No. }
    { 81  ;   ;Exit Point          ;Code10        ;TableRelation="Entry/Exit Point";
                                                   CaptionML=ENU=Exit Point }
    { 82  ;   ;Area                ;Code10        ;TableRelation=Area;
                                                   CaptionML=ENU=Area }
    { 83  ;   ;Transaction Specification;Code10   ;TableRelation="Transaction Specification";
                                                   CaptionML=ENU=Transaction Specification }
    { 84  ;   ;Tax Category        ;Code10        ;CaptionML=ENU=Tax Category }
    { 85  ;   ;Tax Area Code       ;Code20        ;TableRelation="Tax Area";
                                                   CaptionML=ENU=Tax Area Code }
    { 86  ;   ;Tax Liable          ;Boolean       ;CaptionML=ENU=Tax Liable }
    { 87  ;   ;Tax Group Code      ;Code10        ;TableRelation="Tax Group";
                                                   CaptionML=ENU=Tax Group Code }
    { 88  ;   ;VAT Clause Code     ;Code10        ;TableRelation="VAT Clause";
                                                   CaptionML=ENU=VAT Clause Code }
    { 89  ;   ;VAT Bus. Posting Group;Code10      ;TableRelation="VAT Business Posting Group";
                                                   CaptionML=ENU=VAT Bus. Posting Group }
    { 90  ;   ;VAT Prod. Posting Group;Code10     ;TableRelation="VAT Product Posting Group";
                                                   CaptionML=ENU=VAT Prod. Posting Group }
    { 97  ;   ;Blanket Order No.   ;Code20        ;TableRelation="Sales Header".No. WHERE (Document Type=CONST(Blanket Order));
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Blanket Order No. }
    { 98  ;   ;Blanket Order Line No.;Integer     ;TableRelation="Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                                                                Document No.=FIELD(Blanket Order No.));
                                                   TestTableRelation=No;
                                                   CaptionML=ENU=Blanket Order Line No. }
    { 99  ;   ;VAT Base Amount     ;Decimal       ;CaptionML=ENU=VAT Base Amount;
                                                   Editable=No;
                                                   AutoFormatType=1 }
    { 100 ;   ;Unit Cost           ;Decimal       ;CaptionML=ENU=Unit Cost;
                                                   Editable=No;
                                                   AutoFormatType=2 }
    { 101 ;   ;System-Created Entry;Boolean       ;CaptionML=ENU=System-Created Entry;
                                                   Editable=No }
    { 103 ;   ;Line Amount         ;Decimal       ;CaptionML=ENU=Line Amount;
                                                   AutoFormatType=1 }
    { 104 ;   ;VAT Difference      ;Decimal       ;CaptionML=ENU=VAT Difference;
                                                   AutoFormatType=1 }
    { 106 ;   ;VAT Identifier      ;Code10        ;CaptionML=ENU=VAT Identifier;
                                                   Editable=No }
    { 107 ;   ;IC Partner Ref. Type;Option        ;CaptionML=ENU=IC Partner Ref. Type;
                                                   OptionCaptionML=ENU=" ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.";
                                                   OptionString=[ ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.] }
    { 108 ;   ;IC Partner Reference;Code20        ;CaptionML=ENU=IC Partner Reference }
    { 123 ;   ;Prepayment Line     ;Boolean       ;CaptionML=ENU=Prepayment Line;
                                                   Editable=No }
    { 130 ;   ;IC Partner Code     ;Code20        ;TableRelation="IC Partner";
                                                   CaptionML=ENU=IC Partner Code }
    { 131 ;   ;Posting Date        ;Date          ;CaptionML=ENU=Posting Date }
    { 480 ;   ;Dimension Set ID    ;Integer       ;TableRelation="Dimension Set Entry";
                                                   CaptionML=ENU=Dimension Set ID;
                                                   Editable=No }
    { 1001;   ;Job Task No.        ;Code20        ;TableRelation="Job Task"."Job Task No." WHERE (Job No.=FIELD(Job No.));
                                                   CaptionML=ENU=Job Task No.;
                                                   Editable=No }
    { 1002;   ;Job Contract Entry No.;Integer     ;CaptionML=ENU=Job Contract Entry No.;
                                                   Editable=No }
    { 1700;   ;Deferral Code       ;Code10        ;TableRelation="Deferral Template"."Deferral Code";
                                                   CaptionML=ENU=Deferral Code }
    { 5402;   ;Variant Code        ;Code10        ;TableRelation=IF (Type=CONST(Item)) "Item Variant".Code WHERE (Item No.=FIELD(No.));
                                                   CaptionML=ENU=Variant Code }
    { 5403;   ;Bin Code            ;Code20        ;TableRelation=Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                                 Item Filter=FIELD(No.),
                                                                                 Variant Filter=FIELD(Variant Code));
                                                   CaptionML=ENU=Bin Code }
    { 5404;   ;Qty. per Unit of Measure;Decimal   ;CaptionML=ENU=Qty. per Unit of Measure;
                                                   DecimalPlaces=0:5;
                                                   Editable=No }
    { 5407;   ;Unit of Measure Code;Code10        ;TableRelation=IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                                                                 ELSE "Unit of Measure";
                                                   CaptionML=ENU=Unit of Measure Code }
    { 5415;   ;Quantity (Base)     ;Decimal       ;CaptionML=ENU=Quantity (Base);
                                                   DecimalPlaces=0:5 }
    { 5600;   ;FA Posting Date     ;Date          ;CaptionML=ENU=FA Posting Date }
    { 5602;   ;Depreciation Book Code;Code10      ;TableRelation="Depreciation Book";
                                                   CaptionML=ENU=Depreciation Book Code }
    { 5605;   ;Depr. until FA Posting Date;Boolean;CaptionML=ENU=Depr. until FA Posting Date }
    { 5612;   ;Duplicate in Depreciation Book;Code10;
                                                   TableRelation="Depreciation Book";
                                                   CaptionML=ENU=Duplicate in Depreciation Book }
    { 5613;   ;Use Duplication List;Boolean       ;CaptionML=ENU=Use Duplication List }
    { 5700;   ;Responsibility Center;Code10       ;TableRelation="Responsibility Center";
                                                   CaptionML=ENU=Responsibility Center }
    { 5705;   ;Cross-Reference No. ;Code20        ;AccessByPermission=TableData 5717=R;
                                                   CaptionML=ENU=Cross-Reference No. }
    { 5706;   ;Unit of Measure (Cross Ref.);Code10;TableRelation=IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.));
                                                   CaptionML=ENU=Unit of Measure (Cross Ref.) }
    { 5707;   ;Cross-Reference Type;Option        ;CaptionML=ENU=Cross-Reference Type;
                                                   OptionCaptionML=ENU=" ,Customer,Vendor,Bar Code";
                                                   OptionString=[ ,Customer,Vendor,Bar Code] }
    { 5708;   ;Cross-Reference Type No.;Code30    ;CaptionML=ENU=Cross-Reference Type No. }
    { 5709;   ;Item Category Code  ;Code20        ;TableRelation=IF (Type=CONST(Item)) "Item Category";
                                                   CaptionML=ENU=Item Category Code }
    { 5710;   ;Nonstock            ;Boolean       ;CaptionML=ENU=Nonstock }
    { 5711;   ;Purchasing Code     ;Code10        ;TableRelation=Purchasing;
                                                   CaptionML=ENU=Purchasing Code }
    { 5712;   ;Product Group Code  ;Code10        ;TableRelation="Product Group".Code WHERE (Item Category Code=FIELD(Item Category Code));
                                                   CaptionML=ENU=Product Group Code }
    { 5811;   ;Appl.-from Item Entry;Integer      ;AccessByPermission=TableData 27=R;
                                                   CaptionML=ENU=Appl.-from Item Entry;
                                                   MinValue=0 }
    { 6608;   ;Return Reason Code  ;Code10        ;TableRelation="Return Reason";
                                                   CaptionML=ENU=Return Reason Code }
    { 7001;   ;Allow Line Disc.    ;Boolean       ;InitValue=Yes;
                                                   CaptionML=ENU=Allow Line Disc. }
    { 7002;   ;Customer Disc. Group;Code20        ;TableRelation="Customer Discount Group";
                                                   CaptionML=ENU=Customer Disc. Group }
    { 50500;  ;Unit Price (QC)     ;Decimal       ;CaptionML=ENU=Unit Price (QC);
                                                   Description=KMS1704-KMSMOFT17;
                                                   AutoFormatType=2 }
    { 50501;  ;Quote Currency Code ;Code10        ;TableRelation=Currency;
                                                   CaptionML=ENU=Quote Currency Code;
                                                   Description=KMS1704-KMSMOFT17;
                                                   Editable=No }
    { 55000;  ;Smax Line No.       ;Text30         }
    { 55001;  ;Action Code         ;Integer        }
    { 55005;  ;Order Created       ;Boolean        }
    { 56000;  ;Quote Currency Amount;Decimal       }
    { 14103540;;Document Line No.  ;Integer       ;CaptionML=ENU=Document Line No.;
                                                   Description=VLDM4.0 }
  }
  KEYS
  {
    {    ;Document No.,Line No.                   ;SumIndexFields=Amount,Amount Including VAT;
                                                   MaintainSIFTIndex=No;
                                                   Clustered=Yes }
    {    ;Blanket Order No.,Blanket Order Line No. }
    {    ;Sell-to Customer No.                     }
    { No ;Sell-to Customer No.,Type,Document No.  ;MaintainSQLIndex=No }
    {    ;Shipment No.,Shipment Line No.           }
    {    ;Job Contract Entry No.                   }
    {    ;Bill-to Customer No.                     }
    {    ;Document No.,Document Line No.           }
  }
  FIELDGROUPS
  {
  }
  CODE
  {

    BEGIN
    {
      KMS:KMS1701-KMSACRS13-07/03/2017-MMI
      Manage resource purchase (change TableRelation for No.)
      KMS:KMS1701-KMSCTVA14-20/03/2017-MMI
      Added new function which returns VAT Clause Description
      Version        Date          Description
      ********************************************************
      VLDM4.00 : Added "Document Line No." field.
      VLDM4.05   : 15th june 2015    Added DM specific modification
    }
    END.
  }
}