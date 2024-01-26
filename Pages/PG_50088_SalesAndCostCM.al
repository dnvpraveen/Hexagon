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
                field("Valor Venta"; Rec.Amount)
                {

                    Caption = 'Valor Venta';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Valor Costo"; ValorCosto)
                {

                    Caption = 'Valor Costo';
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
        SalesInvoiceHeader: Record "Sales Cr.Memo Header";
        ValorCosto: Decimal;
        ItemLedger: Record "Item Ledger Entry";
        Pedimento: Code[21];


    trigger OnAfterGetRecord()

    begin

        Clear(Cliente);
        Clear(GLEntry);
        Clear(DimValue);
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
        Pedimento := '';
        ValorCosto := 0;
        ValueEntry.Reset();
        ValueEntry.SetRange("Document No.", REC."Document No.");
        ValueEntry.SetRange("Item No.", REC."No.");
        IF ValueEntry.FindSet() THEN
            repeat
                ValorCosto += ValueEntry."Cost Amount (Actual)";
            until ValueEntry.Next() = 0;
        if rec.Type = rec.Type::"G/L Account" then
            GLEntry."G/L Account No." := rec."No.";
        rec.Amount := rec.Amount * -1;
    end;



}


