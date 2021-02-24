OBJECT Table 55014 ITD Proforma Records
{
  OBJECT-PROPERTIES
  {
    Date=04/06/20;
           Time =[ 1:56:06 AM];
           Modified =Yes;
           Version List=Smax1.0;
  }
  PROPERTIES
  {
  }
  FIELDS
  {
    { 1   ;   ;Job No.             ;Code20        ;CaptionML=[ENU=Job No.;
                                                              ENG=Job No.];
                                                   NotBlank=Yes }
    { 2   ;   ;Job Task No.        ;Code20        ;OnValidate=VAR
                                                                Job@1000 : Record 167;
                                                                Cust@1001 : Record 18;
                                                              BEGIN
                                                              END;

                                                   CaptionML=[ENU=Job Task No.;
                                                              ENG=Job Task No.];
                                                   NotBlank=Yes }
    { 3   ;   ;Line No.            ;Integer        }
    { 4   ;   ;ERP Company No.     ;Code10         }
    { 5   ;   ;Opportunity No.     ;Code10         }
    { 6   ;   ;Customer No.        ;Code20         }
    { 7   ;   ;Name                ;Text50         }
    { 8   ;   ;Address             ;Text50         }
    { 9   ;   ;Address 2           ;Text50         }
    { 10  ;   ;Post Code           ;Code10         }
    { 11  ;   ;Country /Region Code;Code10         }
    { 12  ;   ;External Doc No.    ;Text35         }
    { 13  ;   ;Order Type          ;Code2          }
    { 14  ;   ;Sales Order No.     ;Code20         }
    { 15  ;   ;Order Date          ;Date           }
    { 16  ;   ;Promised Delivery Date;Date         }
    { 17  ;   ;Location Code       ;Code10         }
    { 18  ;   ;Type                ;Option        ;OptionCaptionML=ENU=Resource,Item,G/L Account,Text;
                                                   OptionString=Resource,Item,G/L Account,Text }
    { 19  ;   ;No.                 ;Code20         }
    { 20  ;   ;Description         ;Text50         }
    { 21  ;   ;Quantity            ;Decimal        }
    { 22  ;   ;Unit Price          ;Decimal        }
    { 23  ;   ;Activity Type       ;Option        ;OptionCaptionML=ENU=" ,Purchase,Installation,Training,Programming,Warranty";
                                                   OptionString=[ ,Purchase,Installation,Training,Programming,Warranty] }
    { 24  ;   ;IP                  ;Boolean        }
    { 25  ;   ;Serial No.          ;Code20         }
    { 26  ;   ;Shipment No.        ;Code20         }
    { 27  ;   ;Shipment Date       ;Date           }
    { 28  ;   ;Invoice No.         ;Code20         }
    { 29  ;   ;Invoice Date        ;Date           }
    { 30  ;   ;Start Date          ;Date           }
    { 31  ;   ;End Date            ;Date           }
    { 32  ;   ;CPQ Item            ;Code10         }
    { 33  ;   ;Status              ;Option        ;OptionCaptionML=ENU=Planning,Quote,Open,Completed;
                                                   OptionString=Planning,Quote,Open,Completed }
    { 34  ;   ;Integration Status  ;Option        ;OptionCaptionML=ENU=" ,InProgress,Successful,Failure";
                                                   OptionString=[ ,InProgress,Successful,Failure] }
    { 35  ;   ;Response Status     ;Option        ;OptionCaptionML=ENU=" ,Created,Modified,Processed,UpdatedtoSmax";
                                                   OptionString=[ ,Created,Modified,Processed,UpdatedtoSmax] }
    { 36  ;   ;Integration Completed;Boolean       }
    { 37  ;   ;Currency Code       ;Code10        ;TableRelation=Currency }
    { 38  ;   ;Customer Type       ;Code2          }
    { 39  ;   ;Sales Order LineNo  ;Integer        }
    { 40  ;   ;Back Order Qty      ;Integer        }
    { 41  ;   ;Message             ;Text250        }
    { 42  ;   ;IP Code             ;Code20        ;FieldClass=Normal }
    { 43  ;   ;IP Serial No.       ;Code20        ;FieldClass=Normal }
    { 44  ;   ;Target System       ;Code10         }
    { 45  ;   ;Shipment Status     ;Text30         }
    { 46  ;   ;Smax Order No.      ;Text35         }
    { 47  ;   ;Smax Order for IP   ;Text35         }
    { 48  ;   ;IP Created          ;Boolean        }
    { 49  ;   ;Shipment Done       ;Boolean        }
    { 50  ;   ;Invoice Closed      ;Boolean        }
    { 51  ;   ;Invoice Status      ;Text30         }
    { 52  ;   ;PO Value            ;Decimal        }
    { 53  ;   ;Invoice Inserted    ;Boolean        }
    { 54  ;   ;Invoice Created     ;Boolean        }
    { 55  ;   ;Smax Line No        ;Text30         }
    { 56  ;   ;Smax Work order     ;Text30         }
    { 107 ;   ;Qty to Invoice      ;Decimal        }
    { 108 ;   ;Entry No.           ;Integer        }
  }
  KEYS
  {
    {    ;Job No.,Job Task No.,Line No.,Entry No. ;Clustered=Yes }
    { No ;                                         }
  }
  FIELDGROUPS
  {
  }
  CODE
  {

    PROCEDURE IPCreated@1000000000(JobRecordsforSmax@1000000000 : Record 55000);
    VAR
      LJobRecordsforSmax@1000000001 : Record 55000;
    BEGIN
      IF JobRecordsforSmax."IP Created" THEN BEGIN
        LJobRecordsforSmax.RESET;
        LJobRecordsforSmax.SETRANGE("Job No.",JobRecordsforSmax."Job No.");
        LJobRecordsforSmax.SETRANGE("IP Created",FALSE);
        IF LJobRecordsforSmax.FINDSET THEN
          REPEAT
            LJobRecordsforSmax."IP Created" := TRUE;
            LJobRecordsforSmax.MODIFY;
          UNTIL LJobRecordsforSmax.NEXT = 0;
      END;
    END;

    BEGIN
    END.
  }
}