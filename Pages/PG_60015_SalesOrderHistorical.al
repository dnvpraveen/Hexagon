page 60015 "Sales Order Historical"
{
    ApplicationArea = All;
    Caption = 'Sales Order Historical';
    PageType = List;
    SourceTable = SalesOrderHistorical;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(week; Rec.week)
                {
                    Caption = 'Week';
                }
                field(Month; Rec.Month)
                {
                    Caption = 'Month';
                }
                field(Account; Rec.Account)
                {
                    Caption = 'Account';
                }
                field(CustomerPO; Rec.CustomerPO)
                {
                    Caption = 'Customer PO';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                }
                field("Order Amount"; Rec."Order Amount")
                {
                    Caption = 'Order Amount';
                }
                field("Amount USD"; Rec."Amount USD")
                {
                    Caption = 'Amount USD';
                }
                field("Amount MXN"; Rec."Amount MXN")
                {
                    Caption = 'Amount MXN';
                }
                field("Produc CAT"; Rec."Produc CAT")
                {
                    Caption = 'Product Category';
                }
                field("Produc CAT Name"; Rec."Produc CAT Name")
                {
                    Caption = 'Product CAT Name';
                }

                field("MKT Sector Code"; Rec."MKT Sector Code")
                {

                }
                field("MKT Sector Name"; Rec."MKT Sector Name")
                {

                }
                field("SAT type"; Rec."SAT type")
                {
                    Caption = 'SAT Type';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActualizarTodo)
            {
                Caption = 'Actualizar Todo';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    Archive: Record "Sales Header Archive";
                    Facturas: Record "Sales Invoice Header";
                    Order: code[50];
                    ExchangeRate: Record "Currency Exchange Rate";
                    DimensionSet: Record "Dimension Set Entry";
                    Facturas2: Record "Sales Invoice Header";
                    sw: Boolean;
                begin
                    rec.DeleteAll();
                    Commit();
                    Order := '';
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", 'HM22WO*');
                    IF SalesHeader.FindLast() then begin
                        Order := 'HM22WO00001';
                        repeat
                            rec.Init();
                            rec."No." := Order;
                            Order := IncStr(Order);
                            rec.Insert();
                        until rec."No." = SalesHeader."No.";
                    end;
                    Order := '';
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", 'HM22CO*');
                    IF SalesHeader.FindLast() then begin
                        Order := 'HM22CO00001';
                        repeat
                            rec.Init();
                            rec."No." := Order;
                            Order := IncStr(Order);
                            rec.Insert();
                        until rec."No." = SalesHeader."No.";
                    end;

                    Order := '';
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", 'SO22*');
                    IF SalesHeader.FindLast() then begin
                        Order := 'SO22000001';
                        repeat
                            rec.Init();
                            rec."No." := Order;
                            Order := IncStr(Order);
                            rec.Insert();
                        until rec."No." = SalesHeader."No.";
                    end;

                    Order := '';
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", 'HM22SO*');
                    IF SalesHeader.FindLast() then begin
                        Order := 'HM22SO00001';
                        repeat
                            rec.Init();
                            rec."No." := Order;
                            Order := IncStr(Order);
                            rec.Insert();
                        until rec."No." = SalesHeader."No.";
                    end;

                    rec.Reset();
                    rec.FindSet();
                    repeat

                        sw := false;
                        SalesHeader.Reset();
                        SalesHeader.SetRange("No.", rec."No.");
                        IF SalesHeader.FindSet() THEN begin
                            sw := true;
                            rec.Date := SalesHeader."Posting Date";
                            rec.week := Date2DWY(rec.Date, 2);
                            rec.Month := Format(rec.Date, 0, '<Month Text>');
                            rec.Account := SalesHeader."Sell-to Customer Name";
                            rec.CustomerPO := SalesHeader."External Document No.";
                            rec.Currency := SalesHeader."Currency Code";
                            SalesHeader.CalcFields(Amount);
                            rec."Order Amount" := SalesHeader.Amount;
                            ExchangeRate.Reset();
                            ExchangeRate.SetRange("Currency Code", 'USD');
                            ExchangeRate.SetRange("Starting Date", 20000101D, rec.date);
                            if ExchangeRate.FindLast() then begin
                                if rec.Currency <> '' then begin
                                    rec."Amount MXN" := rec."Order Amount" * ExchangeRate."Relational Adjmt Exch Rate Amt";
                                    rec."Amount USD" := rec."Order Amount";
                                end else begin
                                    rec."Amount MXN" := rec."Order Amount";
                                    rec."Amount USD" := rec."Order Amount" / ExchangeRate."Relational Adjmt Exch Rate Amt";

                                end;

                            end;

                            DimensionSet.Reset();
                            DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                            DimensionSet.SetRange("Dimension Code", 'PRODUCT CAT');
                            if DimensionSet.FindSet() then begin
                                rec."Produc CAT" := DimensionSet."Dimension Value Code";
                                DimensionSet.CalcFields("Dimension Value Name");
                                rec."Produc CAT Name" := DimensionSet."Dimension Value Name";
                            end;
                            DimensionSet.Reset();
                            DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                            DimensionSet.SetRange("Dimension Code", 'MKT SECTOR');
                            if DimensionSet.FindSet() then begin
                                rec."MKT Sector Code" := DimensionSet."Dimension Value Code";
                                DimensionSet.CalcFields("Dimension Value Name");
                                rec."MKT Sector Name" := DimensionSet."Dimension Value Name";
                            end;
                            rec.Grupo := '';
                            rec."SAT type" := SalesHeader."AkkOn-SAT Relationship type";
                            rec.Modify()

                        end else begin
                            sw := false;
                            Facturas.Reset();
                            Facturas.SetRange("Order No.", rec."No.");
                            if Facturas.FindSet() then begin
                                sw := true;
                                rec.Date := Facturas."Posting Date";
                                rec.week := Date2DWY(rec.Date, 2);
                                rec.Month := Format(rec.Date, 0, '<Month Text>');
                                rec.Account := Facturas."Sell-to Customer Name";
                                rec.CustomerPO := Facturas."External Document No.";
                                rec.Currency := Facturas."Currency Code";
                                //MODIFICACION 25/03/2025
                                Facturas2.Reset();
                                Facturas2.SetRange("Order No.", Facturas."Order No.");
                                if Facturas2.FindSet() then
                                    repeat
                                        Facturas2.CalcFields(Amount);
                                        rec."Order Amount" += Facturas2.Amount;
                                        ExchangeRate.Reset();
                                        ExchangeRate.SetRange("Currency Code", 'USD');
                                        ExchangeRate.SetRange("Starting Date", 20000101D, rec.date);
                                        if ExchangeRate.FindLast() then begin
                                            if rec.Currency <> '' then begin
                                                rec."Amount MXN" += Facturas2.Amount * ExchangeRate."Relational Adjmt Exch Rate Amt";
                                                rec."Amount USD" += Facturas2.Amount;
                                            end else begin
                                                rec."Amount MXN" := Facturas2.Amount;
                                                rec."Amount USD" := Facturas2.Amount / ExchangeRate."Relational Adjmt Exch Rate Amt";
                                            end;
                                        end;
                                    until Facturas2.Next() = 0;
                                DimensionSet.Reset();
                                DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                                DimensionSet.SetRange("Dimension Code", 'PRODUCT CAT');
                                if DimensionSet.FindSet() then begin
                                    rec."Produc CAT" := DimensionSet."Dimension Value Code";
                                    DimensionSet.CalcFields("Dimension Value Name");
                                    rec."Produc CAT Name" := DimensionSet."Dimension Value Name";
                                end;
                                DimensionSet.Reset();
                                DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                                DimensionSet.SetRange("Dimension Code", 'MKT SECTOR');
                                if DimensionSet.FindSet() then begin
                                    rec."MKT Sector Code" := DimensionSet."Dimension Value Code";
                                    DimensionSet.CalcFields("Dimension Value Name");
                                    rec."MKT Sector Name" := DimensionSet."Dimension Value Name";
                                end;
                                rec.Grupo := '';
                                rec."SAT type" := facturas."AkkOn-SAT Relationship type";
                                rec.Modify();

                                if sw = false then begin
                                    Archive.Reset();
                                    Archive.SetRange("No.", rec."No.");
                                    if Archive.FindSet() then begin
                                        rec.Date := Archive."Posting Date";
                                        rec.week := Date2DWY(rec.Date, 2);
                                        rec.Month := Format(rec.Date, 0, '<Month Text>');
                                        rec.Account := Archive."Sell-to Customer Name";
                                        rec.CustomerPO := Archive."External Document No.";
                                        rec.Currency := Archive."Currency Code";
                                        Archive.CalcFields(Amount);
                                        rec."Order Amount" := Archive.Amount;
                                        ExchangeRate.Reset();
                                        ExchangeRate.SetRange("Currency Code", 'USD');
                                        ExchangeRate.SetRange("Starting Date", 20000101D, rec.date);
                                        if ExchangeRate.FindLast() then begin
                                            if rec.Currency <> '' then begin
                                                rec."Amount MXN" := rec."Order Amount" * ExchangeRate."Relational Adjmt Exch Rate Amt";
                                                rec."Amount USD" := rec."Order Amount";
                                            end else begin
                                                rec."Amount MXN" := rec."Order Amount";
                                                rec."Amount USD" := rec."Order Amount" / ExchangeRate."Relational Adjmt Exch Rate Amt";

                                            end;
                                        end;
                                        DimensionSet.Reset();
                                        DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                                        DimensionSet.SetRange("Dimension Code", 'PRODUCT CAT');
                                        if DimensionSet.FindSet() then begin
                                            rec."Produc CAT" := DimensionSet."Dimension Value Code";
                                            DimensionSet.CalcFields("Dimension Value Name");
                                            rec."Produc CAT Name" := DimensionSet."Dimension Value Name";
                                        end;
                                        DimensionSet.Reset();
                                        DimensionSet.SetRange("Dimension Set ID", SalesHeader."Dimension Set ID");
                                        DimensionSet.SetRange("Dimension Code", 'MKT SECTOR');
                                        if DimensionSet.FindSet() then begin
                                            rec."MKT Sector Code" := DimensionSet."Dimension Value Code";
                                            DimensionSet.CalcFields("Dimension Value Name");
                                            rec."MKT Sector Name" := DimensionSet."Dimension Value Name";
                                        end;
                                        rec.Grupo := '';
                                        rec."SAT type" := '';
                                        rec.Modify()
                                    end;
                                end;
                            end;

                        end;

                    until rec.Next() = 0;

                    Message('Actualizado');
                end;
            }
        }
    }
    trigger OnOpenPage()

    begin


    end;
}
