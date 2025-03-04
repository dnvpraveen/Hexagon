pageextension 50093 SalesLineExt extends "Sales Lines"
{
    layout
    {
        addafter("Outstanding Quantity")
        {
            field("Order Date"; SalesHeader."Order Date") { }
            field("Posting Date"; SalesHeader."Posting Date") { }
            field("Invoice Registered"; SalesInvoiceLine."Document No.") { }
            field("Currency Code"; rec."Currency Code") { }
            field("Document Date"; SalesHeader."Document Date") { }
            field("Promised Delivery Date"; SalesHeader."Promised Delivery Date") { }
            field("PRODUCT CAT Name"; DimensionValue.Name) { }
            field("Unit Price"; rec."Outstanding Amount") { }
            field("External Document No."; SalesHeader."External Document No.") { }
            field("Customer Name"; SalesHeader."Sell-to Customer Name")
            {
                ApplicationArea = all;
                Caption = 'Customer Name';
            }
            field("VAT %"; rec."VAT %") { }
            field("Quantity Invoiced"; REC."Quantity Invoiced") { }
            field("Quantity to Invoice"; REC."Qty. to Invoice") { }
            field("Amount to Invoice"; AmountToInvoice) { }
            field("Amount Invoiced"; rec."Line Amount" - AmountToInvoice) { }
            field("Requested Delivery Date"; rec."Requested Delivery Date") { }
            field(AmountLCY; AmountLCY) { }
            field("MTK Sector Name"; DimensionEntry."Dimension Value Name") { }


        }
    }
    actions
    {
        addafter("Show Document")
        {
            action(UpdateReport)
            {
                Caption = 'Update Backlog Report';
                Image = UpdateShipment;
                trigger OnAction()
                var
                    Backlog: Record Backlog_HGN;
                    Ultimo: Integer;
                    SalesHeader: Record "Sales Header";
                begin

                    Backlog.Reset();
                    Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::"Sales Line");
                    if Backlog.FindSet() then
                        repeat
                            Backlog.Delete();
                        until Backlog.Next() = 0;
                    Backlog.Reset();
                    if Backlog.FindLast() then
                        Ultimo := Backlog."Entry No." + 1 else
                        Ultimo := 1;
                    rec.FindSet();
                    repeat
                        AmountToInvoice := 0;
                        AmountToInvoice := rec."Qty. to Invoice" * rec."Unit Price";
                        CLEAR(DimensionValue);
                        CLEAR(Customer);
                        if Customer.GET(rec."Sell-to Customer No.") then;
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(Code, rec."Shortcut Dimension 2 Code");
                        IF DimensionValue.FINDSET THEN;

                        IF rec."Document No." <> '' THEN BEGIN
                            CLEAR(SalesHeader);
                            CLEAR(SalesInvoiceHeader);
                            CLEAR(SalesInvoiceLine);
                            SalesHeader.RESET;
                            SalesHeader.SETRANGE("No.", rec."Document No.");
                            IF SalesHeader.FINDSET THEN;

                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("Order No.", rec."Document No.");
                            IF SalesInvoiceHeader.FINDSET THEN BEGIN
                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                                SalesInvoiceLine.SETFILTER(Quantity, '<>0');
                                SalesInvoiceLine.SETRANGE("No.", rec."No.");
                                IF SalesInvoiceLine.FINDSET THEN;
                            END;
                        END;

                        if rec."Currency Code" = 'USD' THEN begin
                            ExchangeRate.SetRange("Currency Code", 'USD');
                            ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
                            if ExchangeRate.FindLast() then
                                AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
                        end;
                        if rec."Currency Code" = 'EUR' THEN begin
                            ExchangeRate.SetRange("Currency Code", 'EUR');
                            ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
                            if ExchangeRate.FindLast() then
                                AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
                        end;

                        if AmountLCY = 0 then
                            AmountLCY := AmountToInvoice;
                        Backlog."Entry No." := Ultimo;
                        Backlog.Init();
                        Backlog."No." := rec."Document No.";
                        Backlog."Sell-to Customer No." := rec."Sell-to Customer No.";
                        Backlog."Sell-to Customer Name" := SalesHeader."Sell-to Customer Name";
                        Backlog."External Document No." := SalesHeader."External Document No.";
                        Backlog."Product CAT Name" := DimensionValue.Name;
                        Backlog."PRODUCT CAT Code" := DimensionValue.code;
                        Backlog."Item Description" := rec.Description;
                        Backlog."Item No." := rec."No.";
                        Backlog."Document Date" := SalesHeader."Document Date";
                        Backlog."Promised Delivery Date" := SalesHeader."Promised Delivery Date";
                        Backlog."Currency Code" := SalesHeader."Currency Code";
                        Backlog.Amount := AmountToInvoice;
                        Backlog."Amount LCY" := AmountLCY;
                        SalesHeader.Reset;
                        SalesHeader.SetRange("No.", rec."Document No.");
                        if SalesHeader.FindSet() then begin
                            DimensionEntry.Reset();
                            DimensionEntry.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                            DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                            if DimensionEntry.FindSet() then begin
                                DimensionEntry.CalcFields("Dimension Value Name");
                                Backlog."MTK Sector Name" := DimensionEntry."Dimension Value Name";
                                Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                            end;
                        end;
                        Backlog.Insert();
                        Ultimo := Ultimo + 1;
                    until rec.Next() = 0;

                    Message('Report has been updated!');


                end;
            }
        }
    }
    var
        SalesHeader: Record "Sales Header";
        DimensionValue: Record "Dimension Value";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        AmountToInvoice: Decimal;
        AmountLCY: Decimal;
        ExchangeRate: Record "Currency Exchange Rate";
        DimensionValue2: Record "Dimension Value";
        DimensionEntry: Record "Dimension Set Entry";

    trigger OnAfterGetRecord()
    var
    begin
        AmountToInvoice := 0;
        AmountToInvoice := rec."Qty. to Invoice" * rec."Unit Price";
        CLEAR(DimensionValue);
        CLEAR(Customer);
        if Customer.GET(rec."Sell-to Customer No.") then;
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, rec."Shortcut Dimension 2 Code");
        IF DimensionValue.FINDSET THEN;


        IF rec."Document No." <> '' THEN BEGIN
            CLEAR(SalesHeader);
            CLEAR(SalesInvoiceHeader);
            CLEAR(SalesInvoiceLine);
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", rec."Document No.");
            IF SalesHeader.FINDSET THEN;

            SalesInvoiceHeader.RESET;
            SalesInvoiceHeader.SETRANGE("Order No.", rec."Document No.");
            IF SalesInvoiceHeader.FINDSET THEN BEGIN
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SETFILTER(Quantity, '<>0');
                SalesInvoiceLine.SETRANGE("No.", rec."No.");
                IF SalesInvoiceLine.FINDSET THEN;
            END;
        END;

        if rec."Currency Code" = 'USD' THEN begin
            ExchangeRate.SetRange("Currency Code", 'USD');
            ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
            if ExchangeRate.FindLast() then
                AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
        end;
        if rec."Currency Code" = 'EUR' THEN begin
            ExchangeRate.SetRange("Currency Code", 'EUR');
            ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
            if ExchangeRate.FindLast() then
                AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
        end;

        if AmountLCY = 0 then
            AmountLCY := AmountToInvoice;
        if SalesHeader.FindSet() then begin
            DimensionEntry.Reset();
            DimensionEntry.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
            DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
            if DimensionEntry.FindSet() then begin
                DimensionEntry.CalcFields("Dimension Value Name");

            end;
        end;
    end;

    procedure UpdateBacklok()
    var
        Backlog: Record Backlog_HGN;
        Ultimo: Integer;
        SalesHeader: Record "Sales Header";
    begin

        Backlog.Reset();
        Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::"Sales Line");
        if Backlog.FindSet() then
            repeat
                Backlog.Delete();
            until Backlog.Next() = 0;
        Backlog.Reset();
        if Backlog.FindLast() then
            Ultimo := Backlog."Entry No." + 1 else
            Ultimo := 1;

        rec.SetRange("Document Type", rec."Document Type"::Order);
        rec.SetRange(Type, rec.Type::Item, rec.Type::Resource);
        rec.SetFilter("Outstanding Amount", '<>0');
        if rec.FindSet() then
            repeat
                AmountToInvoice := 0;
                AmountToInvoice := rec."Qty. to Invoice" * rec."Unit Price";
                CLEAR(DimensionValue);
                CLEAR(Customer);
                if Customer.GET(rec."Sell-to Customer No.") then;
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, rec."Shortcut Dimension 2 Code");
                IF DimensionValue.FINDSET THEN;

                IF rec."Document No." <> '' THEN BEGIN
                    CLEAR(SalesHeader);
                    CLEAR(SalesInvoiceHeader);
                    CLEAR(SalesInvoiceLine);
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", rec."Document No.");
                    IF SalesHeader.FINDSET THEN;

                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("Order No.", rec."Document No.");
                    IF SalesInvoiceHeader.FINDSET THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        SalesInvoiceLine.SETFILTER(Quantity, '<>0');
                        SalesInvoiceLine.SETRANGE("No.", rec."No.");
                        IF SalesInvoiceLine.FINDSET THEN;
                    END;
                END;

                if rec."Currency Code" = 'USD' THEN begin
                    ExchangeRate.SetRange("Currency Code", 'USD');
                    ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
                    if ExchangeRate.FindLast() then
                        AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
                end;
                if rec."Currency Code" = 'EUR' THEN begin
                    ExchangeRate.SetRange("Currency Code", 'EUR');
                    ExchangeRate.SetRange("Starting Date", 20000101D, SalesHeader."Document Date");
                    if ExchangeRate.FindLast() then
                        AmountLCY := AmountToInvoice * ExchangeRate."Relational Exch. Rate Amount";
                end;

                if AmountLCY = 0 then
                    AmountLCY := AmountToInvoice;
                Backlog."Entry No." := Ultimo;
                Backlog.Init();
                Backlog."No." := rec."Document No.";
                Backlog."Sell-to Customer No." := rec."Sell-to Customer No.";
                Backlog."Sell-to Customer Name" := SalesHeader."Sell-to Customer Name";
                Backlog."External Document No." := SalesHeader."External Document No.";
                Backlog."Product CAT Name" := DimensionValue.Name;
                Backlog."PRODUCT CAT Code" := DimensionValue.code;
                Backlog."Item Description" := rec.Description;
                Backlog."Item No." := rec."No.";
                Backlog."Document Date" := SalesHeader."Document Date";
                Backlog."Promised Delivery Date" := SalesHeader."Promised Delivery Date";
                Backlog."Currency Code" := SalesHeader."Currency Code";
                Backlog.Amount := AmountToInvoice;
                Backlog."Amount LCY" := AmountLCY;
                SalesHeader.Reset;
                SalesHeader.SetRange("No.", rec."Document No.");
                if SalesHeader.FindSet() then begin
                    DimensionEntry.Reset();
                    DimensionEntry.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                    DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                    if DimensionEntry.FindSet() then begin
                        DimensionEntry.CalcFields("Dimension Value Name");
                        Backlog."MTK Sector Name" := DimensionEntry."Dimension Value Name";
                        Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                    end;
                end;
                Backlog.Insert();
                Ultimo := Ultimo + 1;
            until rec.Next() = 0;
    end;

}
