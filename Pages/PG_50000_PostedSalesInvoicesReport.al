page 50096 "Posted Sales Invoices Report"
{
    ApplicationArea = All;
    Caption = 'Posted Sales Invoices Report';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Quantity = filter(<> 0), type = const(item));

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Fecha de Registro"; Rec."Fecha de Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Orden de Venta"; Rec."Orden de Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("External Document No."; SalesHeader."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Shipment No."; Shipment."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Package Tracking No."; Shipment."Package Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Inventory Document"; ItemLed."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Order Date"; SalesHeader."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }

    }
    var
        SalesHeader: record "Sales Invoice Header";
        ItemLed: record "Item Ledger Entry";
        Shipment: Record "Sales Shipment Header";

    trigger OnAfterGetRecord()

    begin
        CLEAR(SalesHeader);
        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", Rec."Document No.");
        SalesHeader.FINDSET;

        CLEAR(ItemLed);

        ItemLed.RESET;
        ItemLed.SETRANGE("Entry No.", rec."Appl.-to Item Entry");
        IF ItemLed.FINDSET THEN;

        CLEAR(Shipment);
        Shipment.RESET;
        Shipment.SETRANGE("Order No.", SalesHeader."Order No.");
        //Shipment.SETRANGE("Order Line No.","Order Line No.");
        IF Shipment.FINDSET THEN;
    end;
}
