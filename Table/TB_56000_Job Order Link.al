OBJECT Table 50000 Job Order Link
{
  OBJECT-PROPERTIES
  {
    Date=22-02-20;
           Time =[ 5:17:34 AM];
           Modified =Yes;
           Version List=HEXGBJOB.01;
  }
  PROPERTIES
  {
    LookupPageID=Page50000;
    DrillDownPageID=Page50000;
  }
  FIELDS
  {
    { 1   ;   ;Job No.             ;Code20         }
    { 2   ;   ;Line No.            ;Integer       ;CaptionML=[ENU=Line No.;
                                                              ENG=Line No.] }
    { 3   ;   ;Sales Doc. Type     ;Option        ;OptionCaptionML=[ENU=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order;
                                                                    ENG=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order];
                                                   OptionString=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order }
    { 4   ;   ;Order No.           ;Code20         }
    { 5   ;   ;Invoice Doc. Type   ;Option        ;OptionCaptionML=[ENU=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order;
                                                                    ENG=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order];
                                                   OptionString=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order }
    { 6   ;   ;Invoice No.         ;Code20         }
    { 7   ;   ;Purch Doc. Type     ;Option        ;OptionCaptionML=[ENU=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order;
                                                                    ENG=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order];
                                                   OptionString=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order }
    { 8   ;   ;Purch Order No.     ;Code20         }
    { 9   ;   ;Purch Invoice Doc. Type;Option     ;OptionCaptionML=[ENU=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order;
                                                                    ENG=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order];
                                                   OptionString=Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order }
    { 10  ;   ;Purch Invoice No.   ;Code20         }
  }
  KEYS
  {
    {    ;Job No.,Line No.                        ;Clustered=Yes }
    {    ;Sales Doc. Type,Order No.                }
  }
  FIELDGROUPS
  {
  }
  CODE
  {

    BEGIN
    END.
  }
}