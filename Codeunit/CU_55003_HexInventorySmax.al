codeunit 55003 HexInventorySmax
{
    trigger OnRun()
    begin
        HexInventoryBalanceUpdate;
    end;

    PROCEDURE HexInventoryBalance(VAR ItemLedgerEntry: Record 32);
    VAR
        HexInventoryBalance: Record HexInventoryBalance;
        WarehouseEntry: Record 7312;
        CompanyInformation: Record 79;
    BEGIN
        HexInventoryBalance.INIT;
        WarehouseEntry.INIT;
        CompanyInformation.GET;
        IF HexInventoryBalance.FINDLAST THEN BEGIN
            //HexInventoryBalance."Entry No." := HexInventoryBalance."Entry No." + 1;
            HexInventoryBalance."Entry No." := ItemLedgerEntry."Entry No.";
            IF CompanyInformation.GET THEN
                HexInventoryBalance.ERPCompanyNo := CompanyInformation."ERP Company No.";
            HexInventoryBalance."Item No." := ItemLedgerEntry."Item No.";
            HexInventoryBalance."Posting Date" := ItemLedgerEntry."Posting Date";
            HexInventoryBalance."Entry Type" := ItemLedgerEntry."Entry Type";
            HexInventoryBalance."Document No." := ItemLedgerEntry."Document No.";
            HexInventoryBalance.Description := ItemLedgerEntry.Description;
            HexInventoryBalance."Location Code" := ItemLedgerEntry."Location Code";
            HexInventoryBalance.Quantity := ItemLedgerEntry.Quantity;
            HexInventoryBalance."External Document No." := ItemLedgerEntry."External Document No.";
            HexInventoryBalance."Serial No." := ItemLedgerEntry."Serial No.";
            HexInventoryBalance."Lot No." := ItemLedgerEntry."Lot No.";
            WarehouseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
            WarehouseEntry.SETRANGE("Reference No.", ItemLedgerEntry."Document No.");
            WarehouseEntry.SETRANGE("Registering Date", ItemLedgerEntry."Posting Date");
            WarehouseEntry.SETRANGE("Item No.", ItemLedgerEntry."Item No.");
            IF WarehouseEntry.FINDFIRST THEN
                HexInventoryBalance."Bin Code" := WarehouseEntry."Bin Code"
            ELSE
                HexInventoryBalance."Bin Code" := 'KMASCIAROTTE';
            //HexInventoryBalance.Status := HexInventoryBalance.Status::New;
            HexInventoryBalance.TargetSystem := 'SMAX';
            HexInventoryBalance.INSERT;
        END
    end;

    PROCEDURE HexCustomerCreditCheck(VAR Customer: Record 18);
    VAR
        HexCustomerCreditCheck: Record 55010;
        CompanyInformation: Record 79;
    BEGIN
        HexCustomerCreditCheck.INIT;
        CompanyInformation.GET;
        IF HexCustomerCreditCheck.FINDLAST THEN BEGIN
            HexCustomerCreditCheck."Entry No." := HexCustomerCreditCheck."Entry No." + 1;
            HexCustomerCreditCheck.ERPCompanyNo := CompanyInformation."ERP Company No.";
            HexCustomerCreditCheck."No." := Customer."No.";
            HexCustomerCreditCheck."Our Account No." := Customer."Our Account No.";
            HexCustomerCreditCheck.Blocked := Customer.Blocked;
            HexCustomerCreditCheck.Name := Customer.Name;
            HexCustomerCreditCheck."Name 2" := Customer."Name 2";
            HexCustomerCreditCheck."Currency Code" := Customer."Currency Code";
            IF Customer."Balance Due (LCY)" > 0 THEN
                HexCustomerCreditCheck.CustomerOverDue := TRUE
            ELSE
                HexCustomerCreditCheck.CustomerOverDue := FALSE;
            HexCustomerCreditCheck.BypassCreditCheck := TRUE;
            IF Customer."Credit Limit (LCY)" <> 0 THEN BEGIN
                HexCustomerCreditCheck.CustomerAvailableCredit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)";
                HexCustomerCreditCheck."Credit Limit (LCY)" := Customer."Credit Limit (LCY)";
            END;
            HexCustomerCreditCheck.TargetSystem := 'SMAX';
            HexCustomerCreditCheck.INSERT;
        END
    END;

    PROCEDURE HexPriceBook(VAR SalesPrice: Record 7002);
    VAR
        HexPriceBook: Record 55011;
        CompanyInformation: Record 79;
        GeneralLedgerSetup: Record 98;
    BEGIN
        HexPriceBook.INIT;
        CompanyInformation.GET;
        GeneralLedgerSetup.GET;
        IF HexPriceBook.FINDLAST THEN BEGIN
            HexPriceBook."Entry No." := HexPriceBook."Entry No." + 1;
            HexPriceBook.ERPCompanyNo := CompanyInformation."ERP Company No.";
            HexPriceBook."Item No." := SalesPrice."Item No.";
            IF SalesPrice."Currency Code" = '' THEN
                HexPriceBook."Currency Code" := GeneralLedgerSetup."LCY Code"
            ELSE
                HexPriceBook."Currency Code" := SalesPrice."Currency Code";
            HexPriceBook."Starting Date" := SalesPrice."Starting Date";
            HexPriceBook."Unit Price" := SalesPrice."Unit Price";
            HexPriceBook."Minimum Quantity" := SalesPrice."Minimum Quantity";
            HexPriceBook."Ending Date" := SalesPrice."Ending Date";
            HexPriceBook.TargetSystem := 'SMAX';
            HexPriceBook.INSERT;
        END
    END;

    PROCEDURE HexRsPriceBook(VAR ResourcePrice: Record 201);
    VAR
        HexPriceBook: Record 55011;
        CompanyInformation: Record 79;
        GeneralLedgerSetup: Record 98;
    BEGIN
        HexPriceBook.INIT;
        CompanyInformation.GET;
        GeneralLedgerSetup.GET;
        IF HexPriceBook.FINDLAST THEN BEGIN
            HexPriceBook."Entry No." := HexPriceBook."Entry No." + 1;
            HexPriceBook.ERPCompanyNo := CompanyInformation."ERP Company No.";
            HexPriceBook."Item No." := ResourcePrice.Code;
            IF ResourcePrice."Currency Code" = '' THEN
                HexPriceBook."Currency Code" := GeneralLedgerSetup."LCY Code"
            ELSE
                HexPriceBook."Currency Code" := ResourcePrice."Currency Code";
            //HexPriceBook."Starting Date" := ;
            HexPriceBook."Unit Price" := ResourcePrice."Unit Price";
            //HexPriceBook."Minimum Quantity" := SalesPrice."Minimum Quantity";
            //HexPriceBook."Ending Date" := SalesPrice."Ending Date";
            HexPriceBook.TargetSystem := 'SMAX';
            HexPriceBook.INSERT;
        END
    END;

    PROCEDURE HexInventoryBalanceUpdate();
    VAR
        HexInventoryBalance: Record 55009;
        WarehouseEntry: Record 7312;
        CompanyInformation: Record 79;
        ItemLedgerEntry: Record 32;
        LCnt: Integer;
    BEGIN
        HexInventoryBalance.INIT;
        WarehouseEntry.INIT;
        CompanyInformation.GET;
        ItemLedgerEntry.INIT;

        LCnt := HexInventoryBalance.COUNT;

        IF LCnt = 0 THEN
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry No.", '>%1', LCnt)
        ELSE BEGIN
            HexInventoryBalance.FINDLAST;
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry No.", '>%1', HexInventoryBalance."Entry No.");
            //ItemLedgerEntry.SETFILTER("Remaining Quantity",'>%1',0);
        END;

        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                //HexInventoryBalance."Entry No." := HexInventoryBalance."Entry No." + 1;
                HexInventoryBalance."Entry No." := ItemLedgerEntry."Entry No.";
                IF CompanyInformation.GET THEN
                    HexInventoryBalance.ERPCompanyNo := CompanyInformation."ERP Company No.";
                HexInventoryBalance."Item No." := ItemLedgerEntry."Item No.";
                HexInventoryBalance."Posting Date" := ItemLedgerEntry."Posting Date";
                HexInventoryBalance."Entry Type" := ItemLedgerEntry."Entry Type";
                HexInventoryBalance."Document No." := ItemLedgerEntry."Document No.";
                HexInventoryBalance.Description := ItemLedgerEntry.Description;
                HexInventoryBalance."Location Code" := ItemLedgerEntry."Location Code";
                HexInventoryBalance.Quantity := 0;
                HexInventoryBalance."External Document No." := ItemLedgerEntry."External Document No.";
                HexInventoryBalance."Serial No." := ItemLedgerEntry."Serial No.";
                HexInventoryBalance."Lot No." := ItemLedgerEntry."Lot No.";
                WarehouseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
                WarehouseEntry.SETRANGE("Reference No.", ItemLedgerEntry."Document No.");
                WarehouseEntry.SETRANGE("Registering Date", ItemLedgerEntry."Posting Date");
                WarehouseEntry.SETRANGE("Item No.", ItemLedgerEntry."Item No.");
                IF WarehouseEntry.FINDFIRST THEN BEGIN
                    HexInventoryBalance."Bin Code" := WarehouseEntry."Bin Code";
                    HexInventoryBalance.Quantity := HEXWhseEntry(ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code", WarehouseEntry."Bin Code");
                END ELSE BEGIN
                    HexInventoryBalance.Quantity := HEXItemLedger(ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code");
                    HexInventoryBalance."Bin Code" := 'DEFAULT';
                END;
                //HexInventoryBalance.Status := HexInventoryBalance.Status::New;
                HexInventoryBalance.TargetSystem := 'SMAX';
                HexInventoryBalance.INSERT;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END
    END;

    PROCEDURE DummyTest();
    VAR
        Item: Record 27;
        Tcount: Integer;
        Scount: Integer;
    BEGIN
        Item.INIT;
        //Item.SETFILTER("No.",'>%1','#115034');
        IF Item.FINDFIRST THEN BEGIN
            REPEAT
                Item."Serial Nos." := '';
                Item."Lot Nos." := '';
                Item."Item Tracking Code" := '';
                IF Item.MODIFY(TRUE) THEN
                    Tcount += 1
                ELSE
                    Scount += 1;
            UNTIL Item.NEXT = 0;
            MESSAGE('%1 LOT and Total %2', FORMAT(Tcount), FORMAT(Scount));
        END;

    END;

    LOCAL PROCEDURE HEXWhseEntry(ItemNo: Code[20]; LocationCode2: Code[10]; BinCode2: Code[20]): Decimal;
    VAR
        WhseEntry: Record 7312;
    BEGIN
        WhseEntry.SETCURRENTKEY("Item No.", "Bin Code", "Location Code", "Variant Code");
        WhseEntry.SETRANGE("Item No.", ItemNo);
        WhseEntry.SETRANGE("Location Code", LocationCode2);
        //WhseEntry.SETRANGE("Variant Code","Variant Code");
        WhseEntry.SETRANGE("Bin Code", BinCode2);
        IF WhseEntry.FIND('-') THEN
            WhseEntry.CALCSUMS("Qty. (Base)");
        EXIT(WhseEntry."Qty. (Base)");
    END;

    LOCAL PROCEDURE HEXItemLedger(ItemNo: Code[20]; LocationCode2: Code[10]): Decimal;
    VAR
        ItemLedgerEntry2: Record 32;
    BEGIN
        ItemLedgerEntry2.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry2.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry2.SETRANGE("Location Code", LocationCode2);
        IF ItemLedgerEntry2.FIND('-') THEN
            ItemLedgerEntry2.CALCSUMS("Remaining Quantity");
        EXIT(ItemLedgerEntry2."Remaining Quantity");
    END;



}
