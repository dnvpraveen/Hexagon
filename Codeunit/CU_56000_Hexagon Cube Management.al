
codeunit 56000 "Hexagon Cube Management"
{

    //    Documentation
    // This codeunit contains functionality related or needed for
    // generating Hexagon reporting cubes

    //12-02-14 -mdan-
    //Mods in Sales Log functionality:
    //When sales line is deleted, make sure that all Qty and Amounts are shipped and invoiced
    //17-03-14 -mdan-
    //Revert Quantites when handling Credit memo or Return order

    //TEC 31-03-14 -mdan- ignore prepayment lines
    //TEC 20-06-14 -mdan- Ignore pure invoices

    //HEXG1012-GMP 25082014 -Igonre sales log entry for credit memo for direct invoice. Document no - ICR 1012 Sales Log Table V1
    //HEXG1016 -GMP 04112014- ICR 1016 sales log Bill to customer - GMP-  Bill to customer No field added to sales log table.

    trigger OnRun()
    var
        lrecSalesLine: Record "Sales Line";
    begin
        //gfncGenerateAllHyperionAccountMembers();
        //gfncGenerateProductCategoryHierarchy();
        // populate missing prod category
        gblnUseOrderDate := TRUE;
        IF lrecSalesLine.FINDSET THEN
            REPEAT
                lrecSalesLine.MODIFY(TRUE);
            UNTIL lrecSalesLine.NEXT = 0;
        MESSAGE('Done');
    end;

    //<-- Order line related -->()

    procedure gfncSalesLineCreated(VAR p_recSalesLine: Record "Sales Line")
    var
        ldecOrderQty: Decimal;
        ldecShipQty: Decimal;
        ldecInvoiceQty: Decimal;
        ldecOrderAmount: Decimal;
        ldecShipAmount: Decimal;
        ldecInvoiceAmount: Decimal;
    begin
        IF p_recSalesLine."Prepayment Line" THEN EXIT; //TEC 31-03-14 -mdan- ignore prepayment lines
        IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Order) OR
   (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
   // (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Invoice) OR  // TEC 20-06-14 -mdan- Ignore pure invoices
   (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
            ldecOrderQty := p_recSalesLine."Quantity (Base)";
            ldecShipQty := 0;
            ldecInvoiceQty := 0;
            ldecOrderAmount := p_recSalesLine.Amount;
            ldecShipAmount := 0;
            ldecInvoiceAmount := 0;

            IF (ldecOrderQty <> 0) OR (ldecOrderAmount <> 0) THEN
                lfncCreateSalesLogEntry(p_recSalesLine, ldecOrderQty, ldecShipQty, ldecInvoiceQty,
                                                        ldecOrderAmount, ldecShipAmount, ldecInvoiceAmount, '');
        END;
    end;

    procedure gfncSalesLineModified(VAR p_recSalesLine: Record "Sales Line"; p_codInvoiceNo: Code[20])
    var
        lrecSalesLog: Record "Sales Log";
        ldecOrderQty: Decimal;
        ldecShipQty: Decimal;
        ldecInvoiceQty: Decimal;
        ldecOrderAmount: Decimal;
        ldecShipAmount: Decimal;
        ldecInvoiceAmount: Decimal;
        ldecCalcUnitPrice: Decimal;
        lblnRecordChange: Boolean;
        //------------------------Hex1012 Integer
        LRec_SalesHeader: Record "Sales Header";
        LCod_ExtDocNo: Code[35];
        LRec_SalesInvHead: Record "Sales Invoice Header";
        LCod_OrdNo: Code[20];
    begin


        IF p_recSalesLine."Prepayment Line" THEN EXIT; //TEC 31-03-14 -mdan- ignore prepayment lines
        IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Order) OR
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
           // (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Invoice) OR // TEC 20-06-14 -mdan- Ignore pure invoices
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
            lblnRecordChange := FALSE;
            lrecSalesLog.SETCURRENTKEY("Order No.", "Line No.");
            lrecSalesLog.SETRANGE("Order No.", p_recSalesLine."Document No.");
            lrecSalesLog.SETRANGE("Line No.", p_recSalesLine."Line No.");
            lrecSalesLog.CALCSUMS("Order Qty", "Ship Qty", "Invoice Qty", "Order Amount", "Ship Amount", "Invoice Amount");

            IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
               (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
                lrecSalesLog."Order Qty" *= -1;
                lrecSalesLog."Ship Qty" *= -1;
                lrecSalesLog."Invoice Qty" *= -1;
                lrecSalesLog."Order Amount" *= -1;
                lrecSalesLog."Ship Amount" *= -1;
                lrecSalesLog."Invoice Amount" *= -1;
            END;

            //IF lrecSalesLog."Order Qty" <> 0 THEN BEGIN
            //  ldecCalcUnitPrice := lrecSalesLog."Order Amount" / lrecSalesLog."Order Qty";
            //end;

            IF p_recSalesLine."Quantity (Base)" <> 0 THEN BEGIN
                ldecCalcUnitPrice := p_recSalesLine.Amount / p_recSalesLine."Quantity (Base)";
            END;

            IF p_recSalesLine."Quantity (Base)" <> lrecSalesLog."Order Qty" THEN BEGIN
                ldecOrderQty := p_recSalesLine."Quantity (Base)" - lrecSalesLog."Order Qty";
                lblnRecordChange := TRUE;
            END;

            IF p_recSalesLine.Amount <> lrecSalesLog."Order Amount" THEN BEGIN
                ldecOrderAmount := p_recSalesLine.Amount - lrecSalesLog."Order Amount";
                lblnRecordChange := TRUE;
            END;

            IF p_recSalesLine."Qty. Shipped (Base)" <> lrecSalesLog."Ship Qty" THEN BEGIN
                ldecShipQty := p_recSalesLine."Qty. Shipped (Base)" - lrecSalesLog."Ship Qty";
                ldecShipAmount := ldecCalcUnitPrice * p_recSalesLine."Qty. Shipped (Base)" - lrecSalesLog."Ship Amount";
                lblnRecordChange := TRUE;
            END;

            IF p_recSalesLine."Qty. Invoiced (Base)" <> lrecSalesLog."Invoice Qty" THEN BEGIN
                ldecInvoiceQty := p_recSalesLine."Qty. Invoiced (Base)" - lrecSalesLog."Invoice Qty";
                ldecInvoiceAmount := ldecCalcUnitPrice * p_recSalesLine."Qty. Invoiced (Base)" - lrecSalesLog."Invoice Amount";
                lblnRecordChange := TRUE;
            END;


            //HEXG1012 Start
            CLEAR(LCod_ExtDocNo);
            IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") THEN BEGIN
                LRec_SalesHeader.RESET;
                LRec_SalesHeader.SETCURRENTKEY("Document Type", "No.");
                LRec_SalesHeader.SETRANGE("Document Type", LRec_SalesHeader."Document Type"::"Credit Memo");
                LRec_SalesHeader.SETRANGE("No.", p_recSalesLine."Document No.");
                IF LRec_SalesHeader.FINDFIRST THEN BEGIN
                    LCod_ExtDocNo := LRec_SalesHeader."External Document No.";
                    CLEAR(LCod_OrdNo);
                    LRec_SalesInvHead.RESET;
                    LRec_SalesInvHead.SETRANGE("No.", LCod_ExtDocNo);
                    IF LRec_SalesInvHead.FIND('-') THEN BEGIN
                        LCod_OrdNo := LRec_SalesInvHead."Order No.";
                        IF LCod_OrdNo = '' THEN
                            lblnRecordChange := FALSE;
                    END;
                END;
            END;

            //HEXG1012 End
            IF lblnRecordChange THEN
                lfncCreateSalesLogEntry(p_recSalesLine, ldecOrderQty, ldecShipQty, ldecInvoiceQty,
                                                        ldecOrderAmount, ldecShipAmount, ldecInvoiceAmount, p_codInvoiceNo)
            ELSE
                LfnUpdateShipDate(p_recSalesLine, p_recSalesLine."Planned Shipment Date", p_recSalesLine."Shipment Date", p_recSalesLine."Promised Delivery Date", p_recSalesLine."Unit Price", p_recSalesLine."Requested Delivery Date");// 09-May-2016 Gopal
                                                                                                                                                                                                                                          // LfnUpdateShipDate(p_recSalesLine,p_recSalesLine."Planned Shipment Date",p_recSalesLine."Shipment Date",p_recSalesLine."Promised Delivery Date",p_recSalesLine."Unit Price");// 09-May-2016 Gopal

            LRec_SalesHeader.RESET;
            LRec_SalesHeader.SETCURRENTKEY("Document Type", "No.");
            LRec_SalesHeader.SETRANGE("Document Type", p_recSalesLine."Document Type");
            LRec_SalesHeader.SETRANGE("No.", p_recSalesLine."Document No.");
            IF LRec_SalesHeader.FINDFIRST THEN
                lfncUpdateSalesLogEntries(p_recSalesLine, p_recSalesLine."Shortcut Dimension 2 Code", LRec_SalesHeader."Salesperson Code");

        END;
    end;

    procedure gfncSalesLineDeleted(VAR p_recSalesLine: Record "Sales Line"; p_codCaller: Code[20]; p_codInvoiceNo: Code[20])
    var

        lrecSalesLog: Record "Sales Log";
        ldecOrderQty: Decimal;
        ldecShipQty: Decimal;
        ldecInvoiceQty: Decimal;
        ldecOrderAmount: Decimal;
        ldecShipAmount: Decimal;
        ldecInvoiceAmount: Decimal;
    begin


        IF p_recSalesLine."Prepayment Line" THEN EXIT; //TEC 31-03-14 -mdan- ignore prepayment lines
        IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Order) OR
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::Invoice) OR
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
            lrecSalesLog.SETCURRENTKEY("Order No.", "Line No.");
            lrecSalesLog.SETRANGE("Order No.", p_recSalesLine."Document No.");
            lrecSalesLog.SETRANGE("Line No.", p_recSalesLine."Line No.");
            //lrecSalesLog.CALCSUMS("Order Qty", "Order Amount");
            //ldecOrderQty       := -lrecSalesLog."Order Qty";
            //ldecShipQty        := 0;
            //ldecInvoiceQty     := 0;
            //ldecOrderAmount    := -lrecSalesLog."Order Amount";
            //ldecShipAmount     := 0;
            //ldecInvoiceAmount  := 0;
            // Set Ship & invoice quantity
            lrecSalesLog.CALCSUMS("Order Qty", "Ship Qty", "Invoice Qty", "Order Amount", "Ship Amount", "Invoice Amount");

            IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
               (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
                lrecSalesLog."Order Qty" *= -1;
                lrecSalesLog."Ship Qty" *= -1;
                lrecSalesLog."Invoice Qty" *= -1;
                lrecSalesLog."Order Amount" *= -1;
                lrecSalesLog."Ship Amount" *= -1;
                lrecSalesLog."Invoice Amount" *= -1;
            END;

            IF p_codCaller <> 'CU80' THEN BEGIN // Keep order Qty after fully posted
                ldecOrderQty := -lrecSalesLog."Order Qty";
                ldecOrderAmount := -lrecSalesLog."Order Amount";
            END ELSE BEGIN
                ldecShipQty := lrecSalesLog."Order Qty" - lrecSalesLog."Ship Qty";
                ldecInvoiceQty := lrecSalesLog."Order Qty" - lrecSalesLog."Invoice Qty";
                ldecShipAmount := lrecSalesLog."Order Amount" - lrecSalesLog."Ship Amount";
                ldecInvoiceAmount := lrecSalesLog."Order Amount" - lrecSalesLog."Invoice Amount";
            END;

            IF (ldecOrderQty <> 0) OR (ldecShipQty <> 0) OR (ldecInvoiceQty <> 0) OR
               (ldecOrderAmount <> 0) OR (ldecShipQty <> 0) OR (ldecInvoiceQty <> 0) THEN
                lfncCreateSalesLogEntry(p_recSalesLine, ldecOrderQty, ldecShipQty, ldecInvoiceQty,
                                                        ldecOrderAmount, ldecShipAmount, ldecInvoiceAmount, p_codInvoiceNo);
        END;
    end;

    procedure lfncCreateSalesLogEntry(p_recSalesLine: Record "Sales Line"; p_decOrderQty: Decimal; p_decShipQty: Decimal; p_decInvoiceQty: Decimal; p_decOrderAmount: Decimal; p_decShipAmount: Decimal; p_decInvoiceAmount: Decimal; p_codInvoiceNo: Code[20])
    var
        lrecSalesLog: Record "Sales Log";
        lrecItem: Record Item;
        lrecSalesHeader: Record "Sales Header";
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        ldatDate: Date;
        LRec_SalesHeader: Record "Sales Header";
        LCod_ExtDocNo: Code[35];
        LRec_SalesInvHead: Record "Sales Invoice Header";
        LCod_OrdNo: Code[20];
    begin


        lrecSalesHeader.GET(p_recSalesLine."Document Type", p_recSalesLine."Document No.");
        lrecGeneralLedgerSetup.GET();
        IF gblnUseOrderDate THEN BEGIN
            ldatDate := lrecSalesHeader."Posting Date";
            IF ldatDate = 0D THEN ldatDate := lrecSalesHeader."Order Date";
            IF ldatDate = 0D THEN ldatDate := lrecSalesHeader."Document Date";
            IF ldatDate = 0D THEN ldatDate := TODAY;
        END ELSE BEGIN
            ldatDate := TODAY;
        END;

        //HEXG1012 Start
        CLEAR(LCod_ExtDocNo);
        IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") THEN BEGIN
            LRec_SalesHeader.RESET;
            LRec_SalesHeader.SETCURRENTKEY("Document Type", "No.");
            LRec_SalesHeader.SETRANGE("Document Type", LRec_SalesHeader."Document Type"::"Credit Memo");
            LRec_SalesHeader.SETRANGE("No.", p_recSalesLine."Document No.");
            IF LRec_SalesHeader.FINDFIRST THEN BEGIN
                LCod_ExtDocNo := LRec_SalesHeader."External Document No.";
                CLEAR(LCod_OrdNo);
                LRec_SalesInvHead.RESET;
                LRec_SalesInvHead.SETRANGE("No.", LCod_ExtDocNo);
                IF LRec_SalesInvHead.FIND('-') THEN BEGIN
                    LCod_OrdNo := LRec_SalesInvHead."Order No.";
                    IF LCod_OrdNo = '' THEN
                        EXIT;
                END;
            END;
        END;

        //HEXG1012 End

        //
        // revert qty, amount for Credit memo, Return order
        //
        IF (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Credit Memo") OR
           (p_recSalesLine."Document Type" = p_recSalesLine."Document Type"::"Return Order") THEN BEGIN
            p_decOrderQty *= -1;
            p_decShipQty *= -1;
            p_decInvoiceQty *= -1;
            p_decOrderAmount *= -1;
            p_decShipAmount *= -1;
            p_decInvoiceAmount *= -1;
        END;

        //
        // Fill in generic values
        //
        lrecSalesLog.INIT;
        lrecSalesLog."Posting Date" := ldatDate;
        lrecSalesLog."Order No." := p_recSalesLine."Document No.";
        lrecSalesLog."Line No." := p_recSalesLine."Line No.";
        lrecSalesLog.Type := p_recSalesLine.Type;
        lrecSalesLog."No." := p_recSalesLine."No.";
        lrecSalesLog."Product Cat" := p_recSalesLine."Shortcut Dimension 2 Code";
        lrecSalesLog."Unit of Measure" := p_recSalesLine."Unit of Measure Code";
        lrecSalesLog."Currency Code" := p_recSalesLine."Currency Code";
        //lrecSalesLog."Planned Shipment date" := p_recSalesLine."Shipment Date";
        lrecSalesLog."Planned Shipment date" := p_recSalesLine."Planned Shipment Date";
        lrecSalesLog."Shipment Date" := lrecSalesHeader."Posting Date";
        lrecSalesLog."Salesperson Code" := lrecSalesHeader."Salesperson Code";
        lrecSalesLog."Created By" := USERID;

        //HEXG1016 Start
        lrecSalesLog."Customer No." := p_recSalesLine."Sell-to Customer No.";
        lrecSalesLog."Bill-to Customer No." := p_recSalesLine."Bill-to Customer No.";
        lrecSalesLog."Requested Delivery Date" := p_recSalesLine."Requested Delivery Date";     // 09-May-2016 Gopal
                                                                                                //HEXG1016 Stop
        lrecSalesLog."Promised Delivery Date" := p_recSalesLine."Promised Delivery Date";
        lrecSalesLog."Unit Price" := p_recSalesLine."Unit Price";

        IF p_recSalesLine.Type = p_recSalesLine.Type::Item THEN BEGIN
            lrecItem.GET(p_recSalesLine."No.");
            lrecSalesLog."Vendor No." := lrecItem."Vendor No.";
        END;

        //
        // Specific quantities
        //
        lrecSalesLog."Order Qty" := p_decOrderQty;
        lrecSalesLog."Ship Qty" := p_decShipQty;
        lrecSalesLog."Invoice Qty" := p_decInvoiceQty;
        //
        // Specific Amounts
        //
        lrecSalesLog."Order Amount" := p_decOrderAmount;
        lrecSalesLog."Ship Amount" := p_decShipAmount;
        lrecSalesLog."Invoice Amount" := p_decInvoiceAmount;
        //
        // LCY Amounts
        //
        IF p_recSalesLine."Currency Code" <> '' THEN BEGIN
            lrecSalesLog."Order Amount (LCY)" :=
              ROUND(p_decOrderAmount / lrecSalesHeader."Currency Factor", lrecGeneralLedgerSetup."Amount Rounding Precision");
            lrecSalesLog."Ship Amount (LCY)" :=
              ROUND(p_decShipAmount / lrecSalesHeader."Currency Factor", lrecGeneralLedgerSetup."Amount Rounding Precision");
            lrecSalesLog."Invoice Amount (LCY)" :=
              ROUND(p_decInvoiceAmount / lrecSalesHeader."Currency Factor", lrecGeneralLedgerSetup."Amount Rounding Precision");
        END ELSE BEGIN
            lrecSalesLog."Order Amount (LCY)" := p_decOrderAmount;
            lrecSalesLog."Ship Amount (LCY)" := p_decShipAmount;
            lrecSalesLog."Invoice Amount (LCY)" := p_decInvoiceAmount;
        END;

        lrecSalesLog."Invoice No." := p_codInvoiceNo;

        lrecSalesLog.INSERT(TRUE);
    end;

    procedure lfncUpdateSalesLogEntries(p_recSalesLine: Record "Sales Line"; p_codProductCat: Code[20]; p_codSalesPerson: Code[10])
    var
        lrecSalesLog: Record "Sales Log";
        lrecItem: Record Item;
        lrecSalesHeader: Record "Sales Header";
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
    begin


        lrecSalesHeader.GET(p_recSalesLine."Document Type", p_recSalesLine."Document No.");
        lrecGeneralLedgerSetup.GET();
        lrecSalesLog.SETCURRENTKEY("Order No.", "Line No.");
        lrecSalesLog.SETRANGE("Order No.", p_recSalesLine."Document No.");
        lrecSalesLog.SETRANGE("Line No.", p_recSalesLine."Line No.");
        IF lrecSalesLog.FINDSET(TRUE) THEN
            REPEAT
                IF lrecSalesLog."Product Cat" <> p_codProductCat THEN BEGIN
                    lrecSalesLog."Product Cat" := p_codProductCat;
                    lrecSalesLog.MODIFY;
                END;
                // Global Update for Plann shipment date HexGlobal GMP Start
                IF lrecSalesLog."Salesperson Code" <> p_codSalesPerson THEN BEGIN
                    lrecSalesLog."Salesperson Code" := p_codSalesPerson;
                    lrecSalesLog.MODIFY;
                END;

            // Global Update for Plann shipment date HexGlobal GMP End
            UNTIL lrecSalesLog.NEXT = 0;
    end;

    procedure LfnUpdateShipDate(p_recSalesLine: Record "Sales Line"; p_datePlannShipmentDate: Date; p_dateShipmentDate: Date; p_datePromisedDel: Date; p_UnitPrice: Decimal; p_dateRequestDeliveryDate: Date)
    var

        lrecSalesLog: Record "Sales Log";
        lrecSalesHeader: Record "Sales Header";
    begin


        // Global Update for Plann shipment date HexGlobal GMP Start
        lrecSalesHeader.GET(p_recSalesLine."Document Type", p_recSalesLine."Document No.");
        lrecSalesLog.SETCURRENTKEY("Order No.", "Line No.");
        lrecSalesLog.SETRANGE("Order No.", p_recSalesLine."Document No.");
        lrecSalesLog.SETRANGE("Line No.", p_recSalesLine."Line No.");
        //lrecSalesLog.SETFILTER("Order Qty",'<>0');
        IF lrecSalesLog.FINDSET(TRUE) THEN
            REPEAT
                IF lrecSalesLog."Planned Shipment date" <> p_datePlannShipmentDate THEN BEGIN
                    lrecSalesLog."Planned Shipment date" := p_datePlannShipmentDate;
                    lrecSalesLog.MODIFY;
                END;
                IF lrecSalesLog."Shipment Date" <> p_dateShipmentDate THEN BEGIN
                    lrecSalesLog."Shipment Date" := p_dateShipmentDate;
                    lrecSalesLog.MODIFY;
                END;
                IF lrecSalesLog."Promised Delivery Date" <> p_datePromisedDel THEN BEGIN
                    lrecSalesLog."Promised Delivery Date" := p_datePromisedDel;
                    lrecSalesLog.MODIFY;
                END;
                IF lrecSalesLog."Unit Price" <> p_UnitPrice THEN BEGIN
                    lrecSalesLog."Unit Price" := p_UnitPrice;
                    lrecSalesLog.MODIFY;
                END;
                // 09-May-2016 Gopal
                IF lrecSalesLog."Requested Delivery Date" <> p_dateRequestDeliveryDate THEN BEGIN
                    lrecSalesLog."Requested Delivery Date" := p_dateRequestDeliveryDate;
                    lrecSalesLog.MODIFY;
                END;
            // 09-May-2016 Gopal

            UNTIL lrecSalesLog.NEXT = 0;
        // Global Update for Plann shipment date HexGlobal GMP End
    end;

    procedure "<-- Product Cat related -->"()
    begin

    end;

    procedure gfncGenerateProductCategoryHierarchy()
    var

        lrecProductCatHierarchy: Record "Product Cat Hierarchy";
        lrecDimensionValue: Record "Dimension Value";
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        lintCurrentLevel: Integer;
        lcodParentCode: array[20] of Code[20];
    begin


        // Delete existing
        lrecProductCatHierarchy.DELETEALL(TRUE);
        lintCurrentLevel := 0;
        lrecGeneralLedgerSetup.GET();
        lrecDimensionValue.SETRANGE("Dimension Code", lrecGeneralLedgerSetup."Global Dimension 2 Code");
        IF lrecDimensionValue.FINDSET(FALSE, FALSE) THEN
            REPEAT
                lrecProductCatHierarchy.INIT;
                lrecProductCatHierarchy."Product Cat ID" := lrecDimensionValue.Code;
                lrecProductCatHierarchy.Name := lrecDimensionValue.Name;
                IF lintCurrentLevel > 0 THEN
                    lrecProductCatHierarchy."Parent Product Cat ID" := lcodParentCode[lintCurrentLevel];
                CASE lrecDimensionValue."Dimension Value Type" OF
                    lrecDimensionValue."Dimension Value Type"::Standard:
                        BEGIN
                            lrecProductCatHierarchy.Type := 0;
                            lrecProductCatHierarchy.INSERT(TRUE);
                        END;
                    lrecDimensionValue."Dimension Value Type"::"Begin-Total":
                        BEGIN
                            lintCurrentLevel += 1;
                            lcodParentCode[lintCurrentLevel] := lrecDimensionValue.Code;
                            lrecProductCatHierarchy.Type := 1;
                            lrecProductCatHierarchy.INSERT(TRUE);
                        END;
                    lrecDimensionValue."Dimension Value Type"::"End-Total":
                        BEGIN
                            lintCurrentLevel -= 1;
                        END;
                    ELSE
                END;
            UNTIL lrecDimensionValue.NEXT = 0;
    end;

    procedure "<-- Hyperion Account related -->"()
    begin

    end;

    procedure gfncGenerateAllHyperionAccountMembers()
    var
        lrecHyperionAccount: Record "Hyperion Account";
    begin


        lrecHyperionAccount.SETCURRENTKEY(Type);
        lrecHyperionAccount.SETRANGE(Type, lrecHyperionAccount.Type::Leaf);
        IF lrecHyperionAccount.FINDSET(FALSE, FALSE) THEN
            REPEAT
                gfncGenerateHyperionAccountMembers(lrecHyperionAccount);
            UNTIL lrecHyperionAccount.NEXT = 0;
    end;

    procedure gfncGenerateHyperionAccountMembers(p_recHyperionAccount: Record "Hyperion Account")
    var
        lrecGLAccount: Record "G/L Account";
        lrecDimensionValue: Record "Dimension Value";
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        lrecHyperionAccountMembers: Record "Hyperion Account Members";
    begin


        // Delete all existing records
        lrecHyperionAccountMembers.SETCURRENTKEY("Hyperion Account");
        lrecHyperionAccountMembers.SETRANGE("Hyperion Account", p_recHyperionAccount.Code);
        lrecHyperionAccountMembers.DELETEALL(TRUE);
        lrecHyperionAccountMembers.RESET;

        // Create new records
        IF p_recHyperionAccount."G/L Account Range" <> '' THEN BEGIN
            IF p_recHyperionAccount."Cost Centre Range" <> '' THEN BEGIN
                lrecGeneralLedgerSetup.GET();
                lrecGLAccount.SETFILTER("No.", p_recHyperionAccount."G/L Account Range");
                lrecGLAccount.SETRANGE("Account Type", lrecGLAccount."Account Type"::Posting);
                lrecDimensionValue.SETRANGE("Dimension Code", lrecGeneralLedgerSetup."Global Dimension 1 Code");
                lrecDimensionValue.SETFILTER(Code, p_recHyperionAccount."Cost Centre Range");
                lrecDimensionValue.SETRANGE("Dimension Value Type", lrecDimensionValue."Dimension Value Type"::Standard);
                IF lrecGLAccount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF lrecDimensionValue.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                lrecHyperionAccountMembers.INIT;
                                lrecHyperionAccountMembers."G/L Account" := lrecGLAccount."No.";
                                lrecHyperionAccountMembers."Cost Centre" := lrecDimensionValue.Code;
                                lrecHyperionAccountMembers."Hyperion Account" := p_recHyperionAccount.Code;
                                lrecHyperionAccountMembers.INSERT(TRUE);
                            UNTIL lrecDimensionValue.NEXT = 0;
                    UNTIL lrecGLAccount.NEXT = 0;
            END;
        END;
    end;

    var
        gblnUseOrderDate: boolean;
}