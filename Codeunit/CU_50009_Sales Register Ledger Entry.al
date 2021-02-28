codeunit 50009 "Sales Register Ledger Entry"
{
    trigger OnRun()
    begin

    end;

    PROCEDURE CreateInvSalesLedgerEntry(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; DocumentNo: Code[20]);
    VAR
        GLSetup: Record "General Ledger Setup";
        JapanSalesLog: Record "Sales Register";
        JapanSalesLog2: Record "Sales Register";
        LCnt: Integer;
        window: Dialog;
        LText001: TextConst ENU = 'Processing Records......';
        DimensionEntry: Record "Dimension Set Entry";
    BEGIN
        GLSetup.GET;


        IF NOT JapanSalesLog.FINDLAST THEN
            LCnt := 1
        ELSE
            LCnt := JapanSalesLog."Entry No." + 1;

        window.OPEN('#1#################################\\' + LText001 + FORMAT(SalesLine."Document No."));

        window.UPDATE(1, FORMAT(SalesLine."Document No."));

        JapanSalesLog2.RESET;
        JapanSalesLog2.SETRANGE("Document No.", SalesLine."Document No.");
        JapanSalesLog2.SETRANGE("Sales Order Line No.", SalesLine."Line No.");
        IF NOT JapanSalesLog2.FINDFIRST THEN BEGIN
            JapanSalesLog2.INIT;
            JapanSalesLog2."Entry No." := LCnt;
            JapanSalesLog2."Document Type" := SalesLine."Document Type";
            JapanSalesLog2."Document Line No." := SalesLine."Line No.";
            JapanSalesLog2."Sales Order Line No." := SalesLine."Line No.";
            JapanSalesLog2."Item No." := SalesLine."No.";
            JapanSalesLog2."Item Description" := SalesLine.Description;
            JapanSalesLog2."Dimension Set ID" := SalesLine."Dimension Set ID";
            JapanSalesLog2."VAT %" := SalesLine."VAT %";
            JapanSalesLog2."Location Code" := SalesLine."Location Code";
            JapanSalesLog2."Customer No." := SalesLine."Sell-to Customer No.";
            JapanSalesLog2."Amount Excl Tax" := SalesLine."VAT Base Amount";
            JapanSalesLog2."Amount Incl Tax" := SalesLine."Amount Including VAT";
            JapanSalesLog2."Tax Amount" := SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount";
            JapanSalesLog2."Document No." := DocumentNo;
            JapanSalesLog2."Posting Date" := SalesHeader."Posting Date";
            JapanSalesLog2."Currency Code" := SalesHeader."Currency Code";
            JapanSalesLog2."Currency Factor" := SalesHeader."Currency Factor";
            JapanSalesLog2."Sell-to Country/Region Code" := SalesHeader."Ship-to Country/Region Code";
            JapanSalesLog2."Ship-to Name" := SalesHeader."Ship-to Name";
            JapanSalesLog2."Sales Order No." := SalesHeader."No.";
            JapanSalesLog2."Sales Order Date" := SalesHeader."Order Date";
            JapanSalesLog2."Customer Name" := SalesHeader."Sell-to Customer Name";
            //JapanSalesLog2."Job No." := SalesHeader."Job No.";
            JapanSalesLog2."Request Delivery Date" := SalesHeader."Requested Delivery Date";
            DimensionEntry.RESET;
            DimensionEntry.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
            IF DimensionEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                        JapanSalesLog2."Cost Centre" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                        JapanSalesLog2."Product Cat" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
                        JapanSalesLog2."Inter Company" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
                        JapanSalesLog2."HM Location" := DimensionEntry."Dimension Value Code";
                UNTIL DimensionEntry.NEXT = 0;
            END;
            JapanSalesLog2.INSERT;
            LCnt += 1;
        END;

        window.CLOSE;
    END;

    PROCEDURE CreateCreditMemoSalesLedgerEntry(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; DocumentNo: Code[20]);
    VAR
        GLSetup: Record "General Ledger Setup";
        JapanSalesLog: Record "Sales Register";
        JapanSalesLog2: Record "Sales Register";
        LCnt: Integer;
        window: Dialog;
        LText001: TextConst ENU = 'Processing Records......';
        DimensionEntry: Record "Dimension Set Entry";
    BEGIN
        GLSetup.GET;

        IF NOT JapanSalesLog.FINDLAST THEN
            LCnt := 1
        ELSE
            LCnt := JapanSalesLog."Entry No." + 1;

        window.OPEN('#1#################################\\' + LText001 + FORMAT(SalesLine."Document No."));

        window.UPDATE(1, FORMAT(SalesLine."Document No."));

        JapanSalesLog2.RESET;
        JapanSalesLog2.SETRANGE("Document No.", SalesLine."Document No.");
        JapanSalesLog2.SETRANGE("Sales Order Line No.", SalesLine."Line No.");
        IF NOT JapanSalesLog2.FINDFIRST THEN BEGIN
            JapanSalesLog2.INIT;
            JapanSalesLog2."Entry No." := LCnt;
            JapanSalesLog2."Document Type" := JapanSalesLog2."Document Type"::CreditMemo;
            JapanSalesLog2."Document Line No." := SalesLine."Line No.";
            JapanSalesLog2."Sales Order Line No." := SalesLine."Line No.";
            JapanSalesLog2."Item No." := SalesLine."No.";
            JapanSalesLog2."Item Description" := SalesLine.Description;
            JapanSalesLog2."Dimension Set ID" := SalesLine."Dimension Set ID";
            JapanSalesLog2."VAT %" := SalesLine."VAT %";
            JapanSalesLog2."Location Code" := SalesLine."Location Code";
            JapanSalesLog2."Customer No." := SalesLine."Sell-to Customer No.";
            JapanSalesLog2."Amount Excl Tax" := -SalesLine."VAT Base Amount";
            JapanSalesLog2."Amount Incl Tax" := -SalesLine."Amount Including VAT";
            JapanSalesLog2."Tax Amount" := JapanSalesLog2."Amount Incl Tax" - JapanSalesLog2."Amount Excl Tax";
            JapanSalesLog2."Document No." := DocumentNo;
            JapanSalesLog2."Posting Date" := SalesHeader."Posting Date";
            JapanSalesLog2."Currency Code" := SalesHeader."Currency Code";
            JapanSalesLog2."Currency Factor" := SalesHeader."Currency Factor";
            JapanSalesLog2."Sell-to Country/Region Code" := SalesHeader."Ship-to Country/Region Code";
            JapanSalesLog2."Ship-to Name" := SalesHeader."Ship-to Name";
            JapanSalesLog2."Sales Order No." := SalesHeader."No.";
            JapanSalesLog2."Sales Order Date" := SalesHeader."Order Date";
            JapanSalesLog2."Customer Name" := SalesHeader."Sell-to Customer Name";
            //JapanSalesLog2."Job No." := SalesHeader."Job No.";
            JapanSalesLog2."Request Delivery Date" := SalesHeader."Requested Delivery Date";
            DimensionEntry.RESET;
            DimensionEntry.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
            IF DimensionEntry.FINDFIRST THEN BEGIN
                REPEAT
                    IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                        JapanSalesLog2."Cost Centre" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                        JapanSalesLog2."Product Cat" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
                        JapanSalesLog2."Inter Company" := DimensionEntry."Dimension Value Code";
                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
                        JapanSalesLog2."HM Location" := DimensionEntry."Dimension Value Code";
                UNTIL DimensionEntry.NEXT = 0;
            END;
            JapanSalesLog2.INSERT;
            LCnt += 1;
        END;

        window.CLOSE;
    END;


}
