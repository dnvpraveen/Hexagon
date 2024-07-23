page 50088 "Sales and Cost CM"
{
    ApplicationArea = All;
    Caption = 'Sales and Cost Credit Memos';
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";
    UsageCategory = Lists;
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Quantity = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Factura"; Rec."Document No.")
                {
                    Caption = 'No. Factura';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("No. Cliente"; Rec."Sell-to Customer No.")
                {
                    Caption = 'No. Cliente';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Nombre Cliente"; Cliente.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Type"; Rec."Type")
                {
                    Caption = 'Tipo';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Descripcion';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Orden de Venta"; Rec."Orden de Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

                field("No. Orden de Compra"; rec."No. Orden de Compra")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

                field("Fecha de Registro"; rec."Fecha de Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Cuenta que Afecta"; GLEntry."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Product CAT';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Product CAT Name"; DimValue.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Valor Venta"; Rec.Amount * -1)
                {

                    Caption = 'Valor Venta';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(AA; AA * REC.Quantity * -1)
                {

                    Caption = 'HONORARIOS AA';
                    ApplicationArea = All;
                    ToolTip = 'HONORARIOS AA';
                }

                field(DTA; DTA * REC.Quantity * -1)
                {

                    Caption = 'DERECHO DE TRAMITACION ADUANAL';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field(FLETES; FLETES * REC.Quantity * -1)
                {

                    Caption = 'FLETES';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field(IGI; IGI * REC.Quantity * -1)
                {

                    Caption = 'IMPUESTO GRAL IMPORTACION';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Valor Compra"; COMPRA * rec.Quantity)
                {

                    Caption = 'Valor Compra';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }


                field(OTROS; OTROS * REC.Quantity * -1)
                {

                    Caption = 'OTROS GASTOS';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field(PRV; PRV * REC.Quantity * -1)

                {
                    Caption = 'PREVALIDACION';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(TotalCosto; (COMPRA + AA + DTA + FLETES + IGI + OTROS + PRV) * rec.Quantity * -1)

                {
                    Caption = 'Total Costo';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
    var
        Cliente: Record Customer;
        DimValue: Record "Dimension Value";
        GLEntry: Record "G/L Entry";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        SalesInvoiceHeader: Record "Sales Cr.Memo Header";
        ValorCosto: Decimal;
        ItemLedger: Record "Item Ledger Entry";
        Pedimento: Code[21];
        AA: Decimal;
        DTA: Decimal;
        FLETES: Decimal;
        IGI: Decimal;
        OTROS: Decimal;
        PRV: Decimal;
        COMPRA: Decimal;



    trigger OnAfterGetRecord()

    begin
        Clear(Cliente);
        Clear(GLEntry);
        Clear(DimValue);
        AA := 0;
        DTA := 0;
        FLETES := 0;
        IGI := 0;
        OTROS := 0;
        PRV := 0;
        COMPRA := 0;
        Clear(SalesInvoiceHeader);
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", rec."Document No.");
        SalesInvoiceHeader.FindSet();
        if SalesInvoiceHeader."Currency Factor" <> 0 THEN
            REC.Amount := Rec.Amount / SalesInvoiceHeader."Currency Factor";
        DimValue.Reset();
        DimValue.SetRange(code, rec."Shortcut Dimension 2 Code");
        if DimValue.findset then;
        Cliente.get(rec."Sell-to Customer No.");
        GLEntry.Reset();
        GLEntry.SetRange("Document No.", rec."Document No.");
        GLEntry.SetRange("Gen. Posting Type", GLEntry."Gen. Posting Type"::Sale);
        if GLEntry.FindSet() then;

        ValorCosto := 0;

        ValueEntry.Reset();
        ValueEntry.SetRange("Document No.", REC."Document No.");
        ValueEntry.SetRange("Item No.", REC."No.");
        IF ValueEntry.FindSet() THEN begin
            ;
            Pedimento := '';
            ItemLedger.Reset();
            ItemLedger.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
            if ItemLedger.FindSet() then
                Pedimento := ItemLedger."AkkOn-Entry/Exit No.";
            Clear(ItemLedger);
            ItemLedger.Reset();
            ItemLedger.SetRange("AkkOn-Entry/Exit No.", Pedimento);
            ItemLedger.SetRange("Item No.", ValueEntry."Item No.");
            ItemLedger.SetRange("Entry Type", ItemLedger."Entry Type"::Purchase);
            if ItemLedger.FindLast() then
                ValueEntry2.Reset();
            ValueEntry2.SetRange("Item Ledger Entry No.", ItemLedger."Entry No.");
            if ValueEntry2.FindSet() then begin
                repeat
                    IF ValueEntry2."Item Charge No." = 'AA' THEN
                        AA := AA + ValueEntry2."Cost per Unit";
                    IF ValueEntry2."Item Charge No." = 'DTA' THEN
                        DTA := DTA + ValueEntry2."Cost per Unit";
                    IF ValueEntry2."Item Charge No." = 'FLETES' THEN
                        FLETES := FLETES + ValueEntry2."Cost per Unit";
                    IF ValueEntry2."Item Charge No." = 'IGI' THEN
                        IGI := IGI + ValueEntry2."Cost per Unit";
                    IF ValueEntry2."Item Charge No." = 'OTROS' THEN
                        OTROS := OTROS + ValueEntry2."Cost per Unit";
                    IF ValueEntry2."Item Charge No." = 'PRV' THEN
                        PRV := PRV + ValueEntry2."Cost per Unit";
                until ValueEntry2.Next() = 0;

                ValueEntry2.Reset();
                ValueEntry2.SetRange("Item Ledger Entry No.", ItemLedger."Entry No.");
                ValueEntry2.SetRange("Item Charge No.", '');
                if ValueEntry2.FindSet() then
                    COMPRA := ValueEntry2."Cost per Unit";

                IF ValueEntry."Invoiced Quantity" <> 0 THEN
                    ValorCosto := ValorCosto / (ValueEntry."Invoiced Quantity" * -1);
            end;
        END;
        //ValorCosto := AA + DTA + FLETES + IGI + OTROS + PRV;
        if rec.Type = rec.Type::"G/L Account" then
            GLEntry."G/L Account No." := rec."No.";
    end;



}

