page 50097 "Invoice Detail"
{
    ApplicationArea = All;
    Caption = 'Invoice Detail';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;

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

                field("Fecha de Registro"; Rec."Fecha de Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field(Pendiente; rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }


                field("Valor Pendiente"; custledger."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field("No. Orden de Compra"; rec."No. Orden de Compra")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field("Orden de Venta"; rec."Orden de Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }


                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Customer Name"; customer.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name';
                }
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;

                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }



                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }


                field("External Document No."; SalesHeader."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name';
                }


            }
        }
    }
    var
        customer: Record 18;
        custledger: Record "Cust. Ledger Entry";

    var
        SalesHeader: Record 112;

    trigger OnAfterGetRecord()
    begin
        Clear(custledger);
        custledger.Reset();
        ;
        custledger.SetRange("Document No.", rec."Document No.");
        if custledger.FindSet() then
            custledger.CalcFields("Remaining Amount");

        rec.CalcFields("Fecha de Registro");
        rec.CalcFields(Pendiente);
        rec.CalcFields("No. Orden de Compra");
        rec.CalcFields("Orden de Venta");

        IF customer.GET(Rec."Bill-to Customer No.") THEN;
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."Document No.");
        IF SalesHeader.FindSet() THEN;
    end;

}
