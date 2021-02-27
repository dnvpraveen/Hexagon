codeunit 55009 "Compare Records"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}

OBJECT Codeunit 55009 Compare Records
{
  OBJECT-PROPERTIES
  {
    Date=04-06-20;
    Time=[ 2:56:48 AM];
    Modified=Yes;
    Version List=;
  }
  PROPERTIES
  {
    OnRun=BEGIN
          END;

  }
  CODE
  {

    PROCEDURE ComparePurchaseRecord@1102152000(VAR "PONo."@1102152000 : Code[20]) : Boolean;
    VAR
      FldRef1@1102152018 : FieldRef;
      FldRef2@1102152017 : FieldRef;
      PurchaseHead1@1102152016 : Record 38;
      PurchHeadArch1@1102152015 : Record 5109;
      i@1102152014 : Integer;
      Flag@1102152013 : Boolean;
      ArchiveManagement@1102152012 : Codeunit 5063;
      PurchaseHead@1102152011 : RecordRef;
      PurchaseHeadArch@1102152010 : RecordRef;
      PurchaseLine@1102152009 : RecordRef;
      PurchaseLineArchive@1102152008 : RecordRef;
      PurchaseLine1@1102152007 : Record 39;
      PurchaseLineArchive1@1102152006 : Record 5110;
      j@1102152005 : Integer;
      FldRef3@1102152004 : FieldRef;
      FldRef4@1102152003 : FieldRef;
      Flag1@1102152002 : Boolean;
      k@1102152001 : Integer;
    BEGIN
      CLEAR(PurchaseHead);
      CLEAR(PurchaseHeadArch);
      CLEAR(Flag);
      CLEAR(Flag1);
      CLEAR(FldRef1);
      CLEAR(FldRef2);
      CLEAR(FldRef3);
      CLEAR(FldRef4);
      CLEAR(PurchaseLine);
      CLEAR(PurchaseLineArchive);


      PurchaseHead1.RESET;
      PurchaseHead1.SETRANGE("Document Type",PurchaseHead1."Document Type"::Order);
      PurchaseHead1.SETRANGE("No.","PONo.");
      IF PurchaseHead1.FINDFIRST THEN
         PurchaseHead.GETTABLE(PurchaseHead1);


      PurchHeadArch1.RESET;
      PurchHeadArch1.SETRANGE("Document Type",PurchHeadArch1."Document Type"::Order);
      PurchHeadArch1.SETRANGE("No.","PONo.");
      PurchHeadArch1.SETFILTER("Version No.",'<>%1',0);
      IF PurchHeadArch1.FINDLAST THEN BEGIN
         PurchaseHeadArch.GETTABLE(PurchHeadArch1);


        Flag:=FALSE;
        FOR i := 1 TO PurchaseHead.FIELDCOUNT DO BEGIN
          IF PurchaseHead.FIELDEXIST(i) THEN BEGIN
             FldRef1 := PurchaseHead.FIELD(i);
             IF PurchaseHeadArch.FIELDEXIST(i) THEN
             FldRef2 := PurchaseHeadArch.FIELD(i);
             IF (FldRef1.NUMBER = FldRef2.NUMBER) AND (FldRef1.NUMBER<>120) THEN BEGIN
               IF FldRef1.NAME = FldRef2.NAME THEN
                 IF FORMAT(FldRef1.VALUE) <> FORMAT(FldRef2.VALUE) THEN
                   Flag := TRUE;
             END;
          END;
        END;

        Flag1:=FALSE;
        IF NOT Flag THEN BEGIN
          PurchaseLine1.RESET;
          PurchaseLine1.SETRANGE("Document Type",PurchaseLine1."Document Type"::Order);
          PurchaseLine1.SETRANGE("Document No.","PONo.");
          IF PurchaseLine1.FINDFIRST THEN BEGIN
            REPEAT
             PurchaseLine.GETTABLE(PurchaseLine1);

             PurchaseLineArchive1.RESET;
             PurchaseLineArchive1.SETRANGE("Document Type",PurchHeadArch1."Document Type");
             PurchaseLineArchive1.SETRANGE("Document No.",PurchaseLine1."Document No.");
             PurchaseLineArchive1.SETRANGE("Version No.",PurchHeadArch1."Version No.");
             PurchaseLineArchive1.SETRANGE("Line No.",PurchaseLine1."Line No.");
             IF PurchaseLineArchive1.FINDFIRST THEN
               PurchaseLineArchive.GETTABLE(PurchaseLineArchive1);

             FOR j := 1 TO PurchaseLineArchive.FIELDCOUNT DO BEGIN
               IF PurchaseLineArchive.FIELDEXIST(j) THEN
                 IF PurchaseLine.FIELDEXIST(j) THEN BEGIN
                   FldRef3 := PurchaseLine.FIELD(j);
                   FldRef4 := PurchaseLineArchive.FIELD(j);
                   IF FldRef3.ACTIVE = FldRef4.ACTIVE THEN BEGIN
                      IF FldRef3.NUMBER = FldRef4.NUMBER THEN
                         IF FldRef3.NAME = FldRef4.NAME THEN
                            IF FORMAT(FldRef3.VALUE) <> FORMAT(FldRef4.VALUE) THEN
                              Flag1 := TRUE;
                   END;
                 END;
               END;
             UNTIL PurchaseLine1.NEXT = 0;
          END;
        END;
      END ELSE BEGIN  //Archive record not available.... which means its fresh PO
        Flag:=TRUE;
        Flag1:=TRUE;
      END;


      IF Flag OR Flag1 THEN
          ArchiveManagement.ArchivePurchDocumentdirect(PurchaseHead1)
      ELSE
          MESSAGE('Document is unchanged..... document will not be archived...');
    END;

    PROCEDURE CompareSalesRecord@1000000000(VAR "SONo."@1102152000 : Code[20]) : Boolean;
    VAR
      FldRef1@1102152018 : FieldRef;
      FldRef2@1102152017 : FieldRef;
      SalesHead1@1102152016 : Record 36;
      SalesHeadArch1@1102152015 : Record 5107;
      i@1102152014 : Integer;
      Flag@1102152013 : Boolean;
      ArchiveManagement@1102152012 : Codeunit 5063;
      SalesHead@1102152011 : RecordRef;
      SalesHeadArch@1102152010 : RecordRef;
      SalesLine@1102152009 : RecordRef;
      SalesLineArchive@1102152008 : RecordRef;
      SalesLine1@1102152007 : Record 37;
      SalesLineArchive1@1102152006 : Record 5108;
      j@1102152005 : Integer;
      FldRef3@1102152004 : FieldRef;
      FldRef4@1102152003 : FieldRef;
      Flag1@1102152002 : Boolean;
      k@1102152001 : Integer;
    BEGIN
      CLEAR(SalesHead);
      CLEAR(SalesHeadArch);
      CLEAR(Flag);
      CLEAR(Flag1);
      CLEAR(FldRef1);
      CLEAR(FldRef2);
      CLEAR(FldRef3);
      CLEAR(FldRef4);
      CLEAR(SalesLine);
      CLEAR(SalesLineArchive);


      SalesHead1.RESET;
      SalesHead1.SETRANGE("Document Type",SalesHead1."Document Type"::Order);
      SalesHead1.SETRANGE("No.","SONo.");
      IF SalesHead1.FINDFIRST THEN
         SalesHead.GETTABLE(SalesHead1);


      SalesHeadArch1.RESET;
      SalesHeadArch1.SETRANGE("Document Type",SalesHeadArch1."Document Type"::Order);
      SalesHeadArch1.SETRANGE("No.","SONo.");
      SalesHeadArch1.SETFILTER("Version No.",'<>%1',0);
      IF SalesHeadArch1.FINDLAST THEN BEGIN
         SalesHeadArch.GETTABLE(SalesHeadArch1);

        Flag:=FALSE;
        FOR i := 1 TO SalesHead.FIELDCOUNT DO BEGIN
          IF SalesHead.FIELDEXIST(i) THEN BEGIN
             FldRef1 := SalesHead.FIELD(i);
             IF SalesHeadArch.FIELDEXIST(i) THEN
             FldRef2 := SalesHeadArch.FIELD(i);
             IF (FldRef1.NUMBER = FldRef2.NUMBER) AND (FldRef1.NUMBER<>120) THEN BEGIN
               IF FldRef1.NAME = FldRef2.NAME THEN
                 IF FORMAT(FldRef1.VALUE) <> FORMAT(FldRef2.VALUE) THEN
                   Flag := TRUE;
             END;
          END;
        END;


        Flag1:=FALSE;
        IF NOT Flag THEN BEGIN
          SalesLine1.RESET;
          SalesLine1.SETRANGE("Document Type",SalesLine1."Document Type"::Order);
          SalesLine1.SETRANGE("Document No.","SONo.");
          IF SalesLine1.FINDFIRST THEN BEGIN
            REPEAT
             SalesLine.GETTABLE(SalesLine1);

             SalesLineArchive1.RESET;
             SalesLineArchive1.SETRANGE("Document Type",SalesHeadArch1."Document Type");
             SalesLineArchive1.SETRANGE("Document No.",SalesLine1."Document No.");
             SalesLineArchive1.SETRANGE("Version No.",SalesHeadArch1."Version No.");
             SalesLineArchive1.SETRANGE("Line No.",SalesLine1."Line No.");
             IF SalesLineArchive1.FINDFIRST THEN
               SalesLineArchive.GETTABLE(SalesLineArchive1);

             FOR j := 1 TO SalesLineArchive.FIELDCOUNT DO BEGIN
               IF SalesLineArchive.FIELDEXIST(j) THEN
                 IF SalesLine.FIELDEXIST(j) THEN BEGIN
                   FldRef3 := SalesLine.FIELD(j);
                   FldRef4 := SalesLineArchive.FIELD(j);
                   IF FldRef3.ACTIVE = FldRef4.ACTIVE THEN BEGIN
                      IF FldRef3.NUMBER = FldRef4.NUMBER THEN
                         IF FldRef3.NAME = FldRef4.NAME THEN
                            IF FORMAT(FldRef3.VALUE) <> FORMAT(FldRef4.VALUE) THEN
                              Flag1 := TRUE;
                   END;
                 END;
               END;
             UNTIL SalesLine1.NEXT = 0;
          END;
        END;
      END ELSE BEGIN  //Archive record not available.... which means its fresh SO
        Flag:=TRUE;
        Flag1:=TRUE;
      END;


      IF Flag OR Flag1 THEN
          ArchiveManagement.ArchiveSalesDocumentdirect(SalesHead1)
      ELSE
          MESSAGE('Document is unchanged..... document will not be archived...');
    END;

    BEGIN
    END.
  }
}

