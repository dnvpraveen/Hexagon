codeunit 55001 "Update ITDW to  Planning Lines"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
}

OBJECT Codeunit 55001 Update ITDW to  Planning Lines
{
  OBJECT-PROPERTIES
  {
    Date=14-07-20;
    Time=11:35:14 PM;
    Modified=Yes;
    Version List=Smax1.0;
  }
  PROPERTIES
  {
    OnRun=BEGIN
            UpdatePlanningLines;
            OrderInsertedfromSMAX;

            GSalesHeader.RESET;
            GSalesHeader.SETRANGE("Action Code",4);
            IF GSalesHeader.FINDSET THEN BEGIN
              REPEAT
                CancelOrder(GSalesHeader);
              UNTIL GSalesHeader.NEXT = 0;
            END;

            GSalesHeader.RESET;
            GSalesHeader.SETRANGE("Action Code",5);
            IF GSalesHeader.FINDSET THEN BEGIN
              REPEAT
                ShortCloseOrder(GSalesHeader);
              UNTIL GSalesHeader.NEXT = 0;
            END;
          END;

  }
  CODE
  {
    VAR
      GSalesHeader@1000000000 : Record 36;

    PROCEDURE UpdatePlanningLines@1000000000();
    VAR
      ITDWProformaRecords@1000000000 : Record 55014;
      JobPlanningLine@1000000001 : Record 1003;
    BEGIN
      ITDWProformaRecords.RESET;
      ITDWProformaRecords.SETRANGE("Invoice Inserted",FALSE);
      ITDWProformaRecords.SETRANGE("Integration Completed",FALSE);
      IF ITDWProformaRecords.FINDSET THEN BEGIN
        REPEAT
           IF JobPlanningLine.GET(ITDWProformaRecords."Job No.",ITDWProformaRecords."Job Task No.",
                                     ITDWProformaRecords."Line No.") THEN BEGIN
            JobPlanningLine.VALIDATE("Qty. to Transfer to Journal",ITDWProformaRecords."Qty to Invoice");
            //JobPlanningLine.VALIDATE("Currency Code",ITDWProformaRecords."Currency Code");
            JobPlanningLine.VALIDATE("Unit Price",ITDWProformaRecords."Unit Price");
            JobPlanningLine."Smax Order No." := ITDWProformaRecords."Smax Order No.";
            JobPlanningLine."Smax Order for IP" := ITDWProformaRecords."Smax Order for IP";
            JobPlanningLine."Smax Line No" := ITDWProformaRecords."Smax Line No";
            JobPlanningLine."IP Serial No." := ITDWProformaRecords."IP Code";
            JobPlanningLine."IP Code" := ITDWProformaRecords."IP Serial No.";
            JobPlanningLine.MODIFY;
            FromPlanningLineToJnlLine(JobPlanningLine);
          END;
          ITDWProformaRecords."Invoice Inserted" := TRUE;
          ITDWProformaRecords."Integration Completed" := TRUE;
          ITDWProformaRecords.MODIFY;
        UNTIL ITDWProformaRecords.NEXT = 0;
      END;
    END;

    PROCEDURE OrderInsertedfromSMAX@1000000001();
    VAR
      SalesHeader@1000000003 : Record 36;
      TransferHeader@1000000002 : Record 5740;
      LSalesLine@1000000001 : Record 37;
      LTransferLine@1000000000 : Record 5741;
    BEGIN
      SalesHeader.RESET;
      SalesHeader.SETRANGE("Order Created",TRUE);
      SalesHeader.SETRANGE("Order Inserted",FALSE);
      IF SalesHeader.FINDSET THEN BEGIN
        REPEAT
          LSalesLine.RESET;
          LSalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
          LSalesLine.SETRANGE("Document No.",SalesHeader."No.");
          IF LSalesLine.FINDSET THEN BEGIN
            REPEAT
              LSalesLine."Order Inserted" := TRUE;
              LSalesLine.MODIFY;
            UNTIL LSalesLine.NEXT = 0;
            SalesHeader."Order Inserted" := TRUE;
            SalesHeader.MODIFY;
          END;
        UNTIL SalesHeader.NEXT = 0;
      END;

      TransferHeader.RESET;
      TransferHeader.SETRANGE("Order Created",TRUE);
      TransferHeader.SETRANGE("Order Inserted",FALSE);
      IF TransferHeader.FINDSET THEN BEGIN
        REPEAT
          LTransferLine.RESET;
          LTransferLine.SETRANGE("Document No.",TransferHeader."No.");
          IF LTransferLine.FINDSET THEN BEGIN
            REPEAT
              LTransferLine."Order Inserted" := TRUE;
              LTransferLine.MODIFY;
            UNTIL LTransferLine.NEXT = 0;
            TransferHeader."Order Inserted" := TRUE;
            TransferHeader.MODIFY;
          END;
        UNTIL TransferHeader.NEXT = 0;
      END;
    END;

    PROCEDURE CancelOrder@1102154001(SalesHeader@1000 : Record 36);
    VAR
      OrderStatusValue@1102154000 : Text[50];
      Text001@1102154002 : TextConst 'ENU=Do you want to Cancel the Order No. %1';
      Text052@1102154003 : TextConst 'ENU=You cananot Cancel the order,You have to Short Close the order for Line No. %1 and Item No. %2';
      Text051@1102154004 : TextConst 'ENU=You cannot Canel/Short Close the order,Project is pending for this Order';
      SalesLine@1001 : Record 37;
    BEGIN
      OrderStatusValue:='Cancel';
      IF OrderStatusValue='Cancel' THEN BEGIN
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.",SalesHeader."No.");
        SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN
          REPEAT
            IF SalesLine."Quantity Shipped">0 THEN
              ERROR(Text052,SalesLine."Line No.",SalesLine."No.");
          UNTIL SalesLine.NEXT=0;
      END;
      CancelCloseOrder(OrderStatusValue,SalesHeader);
    END;

    PROCEDURE ShortCloseOrder@1102154002(SalesHeader@1000 : Record 36);
    VAR
      OrderStatusValue@1102154000 : Text[50];
      Text001@1102154004 : TextConst 'ENU=Do you want to Short Close the Order No. %1';
      Text051@1102154003 : TextConst 'ENU=You cananot Close  the order,You have to Cancel the order for Line No. %1and Item No. %2';
      Text052@1102154002 : TextConst 'ENU=You cannot Canel/Short Close the order,Project is pending for this Order';
    BEGIN
      OrderStatusValue:='Close';
      CancelCloseOrder(OrderStatusValue,SalesHeader);
    END;

    PROCEDURE CancelCloseOrder@1102154003(VAR OrderStatus@1102154000 : Text[50];VAR SalesHeader@1102154001 : Record 36);
    VAR
      CancelShortClose@1102154005 : Text[50];
      SalesLine@1102154006 : Record 37;
      SalesShipLine@1102154007 : Record 111;
      Text050@1102154002 : TextConst 'ENU=Invoice is pending for Line No. %1 and Item No. %2, still want to Short Close the order?';
      ArchiveManagement@1000000000 : Codeunit 5063;
      NoShipment@1000000001 : Boolean;
    BEGIN
      SalesLine.RESET;
      SalesLine.SETRANGE("Document No.",SalesHeader."No.");
      SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
      SalesLine.SETFILTER(Type,'<>%1',SalesLine.Type::" ");
      IF SalesLine.FIND('-') THEN BEGIN
        REPEAT
          SalesShipLine.INIT;
          SalesShipLine.SETRANGE(SalesShipLine."Order No.",SalesLine."Document No.");
          SalesShipLine.SETRANGE(SalesShipLine."Order Line No.",SalesLine."Line No.");
          IF SalesShipLine.FIND('-') THEN BEGIN
            REPEAT
              IF SalesShipLine."Qty. Shipped Not Invoiced"<>0 THEN
                NoShipment := TRUE;
            UNTIL SalesShipLine.NEXT=0;
          END;
        UNTIL SalesLine.NEXT=0;
      END;

      IF NOT NoShipment THEN BEGIN
        //IF CONFIRM(Text050,FALSE,SalesShipLine."Order Line No.",SalesShipLine."No.") THEN BEGIN
          IF OrderStatus='Close' THEN BEGIN
            SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
            SalesHeader.MODIFY;
            ArchiveManagement.ArchiveSalesDocument2(SalesHeader);
          END;
        //END ELSE
          //EXIT;
      END ELSE BEGIN
        IF OrderStatus='Close' THEN BEGIN
            SalesHeader."Cancel / Short Close" := SalesHeader."Cancel / Short Close"::"Short Closed";
            SalesHeader.MODIFY;
            ArchiveManagement.ArchiveSalesDocument2(SalesHeader);
          END;
      END;

      IF OrderStatus='Cancel' THEN BEGIN
        SalesHeader."Cancel / Short Close":= SalesHeader."Cancel / Short Close"::Cancelled;
        SalesHeader.MODIFY;
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);
      END;

      SalesLine.RESET;
      SalesLine.SETRANGE("Document No.",SalesHeader."No.");
      SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
      IF SalesLine.FIND('-') THEN BEGIN
        REPEAT
          SalesLine.DELETE;
        UNTIL SalesLine.NEXT=0;
      END;
      SalesHeader.DELETE;
    END;

    PROCEDURE FromPlanningLineToJnlLine@9(JobPlanningLine@1000 : Record 1003);
    VAR
      JobTask@1005 : Record 1001;
      JobJnlLine2@1006 : Record 210;
      NoSeriesMgt@1009 : Codeunit 396;
      ItemTrackingMgt@1010 : Codeunit 6500;
      JobJnlLine@1011 : Record 210;
      JobJournalBatch@1001 : Record 237;
      JobJnlPostLine@1002 : Codeunit 1012;
    BEGIN
      JobPlanningLine.TESTFIELD("Qty. to Transfer to Journal");

      JobJnlLine.INIT;
      JobJnlLine.VALIDATE("Journal Template Name",'Job');
      JobJnlLine.VALIDATE("Journal Batch Name",'Default');
      JobJnlLine2.SETRANGE("Journal Template Name",'Job');
      JobJnlLine2.SETRANGE("Journal Batch Name",'Default');
      IF JobJnlLine2.FINDLAST THEN
        JobJnlLine.VALIDATE("Line No.",JobJnlLine2."Line No." + 10000)
      ELSE
        JobJnlLine.VALIDATE("Line No.",10000);

      JobJnlLine.VALIDATE("Job No.",JobPlanningLine."Job No.");
      JobJnlLine."Job Task No." := JobPlanningLine."Job Task No.";

      IF JobPlanningLine."Usage Link" THEN BEGIN
        JobJnlLine."Job Planning Line No." := JobPlanningLine."Line No.";
        JobJnlLine."Line Type" := JobPlanningLine."Line Type" + 1;
      END;

      JobTask.GET(JobPlanningLine."Job No.",JobPlanningLine."Job Task No.");
      JobJnlLine."Posting Group" := JobTask."Job Posting Group";
      JobJnlLine."Posting Date" := WORKDATE;
      JobJnlLine."Document Date" := WORKDATE;
      JobJournalBatch.GET(JobJnlLine."Journal Template Name",JobJnlLine."Journal Batch Name");
      IF JobJournalBatch."No. Series" <> '' THEN
        JobJnlLine."Document No." := NoSeriesMgt.GetNextNo(JobJournalBatch."No. Series",WORKDATE,FALSE)
      ELSE
        JobJnlLine."Document No." := JobPlanningLine."Document No.";

      JobJnlLine.Type := JobPlanningLine.Type;
      JobJnlLine."No." := JobPlanningLine."No.";
      JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
      JobJnlLine."Gen. Bus. Posting Group" := JobPlanningLine."Gen. Bus. Posting Group";
      JobJnlLine."Gen. Prod. Posting Group" := JobPlanningLine."Gen. Prod. Posting Group";
      JobJnlLine."Serial No." := JobPlanningLine."Serial No.";
      JobJnlLine."Lot No." := JobPlanningLine."Lot No.";
      JobJnlLine.Description := JobPlanningLine.Description;
      JobJnlLine."Description 2" := JobPlanningLine."Description 2";
      JobJnlLine.VALIDATE("Unit of Measure Code",JobPlanningLine."Unit of Measure Code");
      JobJnlLine."Currency Code" := JobPlanningLine."Currency Code";
      JobJnlLine."Currency Factor" := JobPlanningLine."Currency Factor";
      JobJnlLine."Resource Group No." := JobPlanningLine."Resource Group No.";
      JobJnlLine."Location Code" := JobPlanningLine."Location Code";
      JobJnlLine."Work Type Code" := JobPlanningLine."Work Type Code";
      JobJnlLine."Customer Price Group" := JobPlanningLine."Customer Price Group";
      JobJnlLine."Variant Code" := JobPlanningLine."Variant Code";
      JobJnlLine."Bin Code" := JobPlanningLine."Bin Code";
      JobJnlLine."Service Order No." := JobPlanningLine."Service Order No.";
      JobJnlLine."Country/Region Code" := JobPlanningLine."Country/Region Code";
      JobJnlLine.VALIDATE(Quantity,JobPlanningLine."Qty. to Transfer to Journal");
      JobJnlLine.VALIDATE("Qty. per Unit of Measure",JobPlanningLine."Qty. per Unit of Measure");
      JobJnlLine."Direct Unit Cost (LCY)" := JobPlanningLine."Direct Unit Cost (LCY)";
      JobJnlLine.VALIDATE("Unit Cost",JobPlanningLine."Unit Cost");
      JobJnlLine.VALIDATE("Unit Price",JobPlanningLine."Unit Price");
      JobJnlLine.VALIDATE("Line Discount %",JobPlanningLine."Line Discount %");
      ItemTrackingMgt.CopyItemTracking(JobPlanningLine.RowID1,JobJnlLine.RowID1,FALSE);
      JobJnlPostLine.RunWithCheck(JobJnlLine);
    END;

    BEGIN
    END.
  }
}
