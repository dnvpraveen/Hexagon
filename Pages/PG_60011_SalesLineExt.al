page 60011 SalesLineExt
{
    ApplicationArea = All;
    Caption = 'Reporte Ordenes de Venta Con Inventario y PO';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Sell to Customer Name"; Customer.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }

                field("External Document No."; Header."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Type"; Rec."Type")
                {
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                }
                field("Current Inventory"; item.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Falta en Almacen"; item.Inventory - rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }

                field("PURCHASE ORDER QTY"; PurchaseLine.Quantity)
                {
                    ApplicationArea = All;
                }

                field("PURCHASE ORDER"; PurchaseHeader."No.")
                {
                    ApplicationArea = All;
                }

                field("QUANTITY IN ALL PO"; "CantidadOrdernes")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        PurchaseLines: page "Purchase Lines";
                        PurchaseLine: Record "Purchase Line";
                    begin
                        PurchaseLine.reset;
                        PurchaseLine.SetRange("No.", rec."No.");
                        PurchaseLine.SetFilter("Qty. to Receive", '<>0');
                        if PurchaseLine.FindSet() then
                            PurchaseLines.SetTableView(PurchaseLine);
                        PurchaseLines.Run();

                    end;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(Customer);
        if Customer.get(rec."Sell-to Customer No.") then;
        Clear(Header);
        Header.SetRange("No.", rec."Document No.");
        if Header.FindSet() then;
        Clear(Item);
        Item.Reset();
        item.SetFilter("Location Filter", 'FGM22|FGT22');
        if Item.get(rec."No.") then begin
            Item.CalcFields(Inventory);
            item.CalcFields("Qty. on Purch. Order");
        end;
        CantidadOrdernes := 0;

        PurchaseLine.reset;
        PurchaseLine.SetRange("No.", rec."No.");
        PurchaseLine.SetFilter("Qty. to Receive", '<>0');
        if PurchaseLine.FindSet() then begin
            PurchaseLine.CalcSums("Qty. to Receive");
            CantidadOrdernes := PurchaseLine."Qty. to Receive";

        end;
        Clear(PurchaseLine);
        Clear(PurchaseHeader);
        PurchaseLine.reset;
        PurchaseLine.SetRange("Sales Order", rec."Document No.");
        PurchaseLine.SetRange("No.", rec."No.");
        if PurchaseLine.FindSet() then
            if PurchaseHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then;
    end;

    var
        Customer: Record Customer;
        Header: Record "Sales Header";
        Item: Record Item;
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        CantidadOrdernes: Decimal;

}
