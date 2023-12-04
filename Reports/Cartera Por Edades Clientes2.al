report 50064 "Cartera Por Edades Clientes2"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Cartera Por Edades Clientes2.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView =
                                WHERE("Remaining Amount" = FILTER(<> 0));
            RequestFilterFields = "Customer No.", "Document No.";
            column(Identificacion; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(NombreCliente; NombreCliente)
            {
            }
            column(FechaRegistro; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(Decripcion; "Cust. Ledger Entry".Description)
            {
            }
            column(CuentaContable; Contabilidad."G/L Account No.")
            {
            }
            column(NoFacturaProveedor; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(NoDocRegistro; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Costo; Base)
            {
            }
            column(IVA; Iva)
            {
            }
            column(ReteFuente; ReteFuente)
            {
            }
            column(ReteIca; ReteIca)
            {
            }
            column(Descuento; Descuento)
            {
            }
            column(TotalFactura; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(ValorPendiente; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(FechaPago; FechaPago)
            {
            }
            column(Estado; Estado)
            {
            }
            column(DiasVencida; DiasVencido)
            {
            }
            column(FechaImpresion; TODAY)
            {
            }
            column(Usuario; USERID)
            {
            }
            column(FechaVenci; "Cust. Ledger Entry"."Due Date")
            {
            }
            column(Treinta; Treinta * trm)
            {
            }
            column(Sesenta; Sesenta * trm)
            {
            }
            column(Noventa; Noventa * trm)
            {
            }
            column(CientoOchenta; cientoochenta * trm)
            {
            }
            column(MasCientoOchenta; MasCientoOchenta * trm)
            {
            }
            column(ValorUSD; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(Moneda; "Cust. Ledger Entry"."Currency Code")
            {
            }
            column(trm; trm)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Contabilidad.RESET;
                Contabilidad.SETRANGE("Document No.", "Document No.");
                Contabilidad.SETFILTER("G/L Account No.", '28*|1305*|1310*');
                Contabilidad.SETRANGE("Source No.", "Cust. Ledger Entry"."Customer No.");
                IF Contabilidad.FINDSET THEN
                    Cliente.RESET;
                Cliente.SETRANGE("No.", "Cust. Ledger Entry"."Customer No.");
                Cliente.FINDSET;
                CustomerPosting.RESET;
                CustomerPosting.SETRANGE(Code, Cliente."Customer Posting Group");
                IF CustomerPosting.FINDSET THEN BEGIN
                END;
                NombreCliente := '';
                NombreCliente := Cliente.Name + ' ' + Cliente."Name 2";

                Base := 0;
                ReteFuente := 0;
                Iva := 0;
                ReteIva := 0;
                Treinta := 0;
                Sesenta := 0;
                Noventa := 0;
                cientoochenta := 0;
                MasCientoOchenta := 0;
                trm := 1;
                /*
                                Impuestos.RESET;
                                Impuestos.SETRANGE("Document No.","Document No.");
                                IF Impuestos.FINDSET THEN
                                  REPEAT
                                    IF (Impuestos."Tax Identifier" = 'RETENCION') OR (Impuestos."Tax Identifier" = 'RETEFUENTE') THEN
                                      ReteFuente := ReteFuente + Impuestos.Amount;

                                     IF (Impuestos."Tax Identifier" = 'IVA') THEN BEGIN
                                      Iva := Iva + Impuestos.Amount;
                                      Base := Impuestos.Base;
                                       END;

                                   IF (Impuestos."Tax Identifier" = 'RETEIVA')  THEN
                                      ReteIva := ReteIva + Impuestos.Amount;

                                   IF (Impuestos."Tax Identifier" = 'RETEICA') THEN
                                      ReteIca := ReteIca + Impuestos.Amount;

                                    UNTIL Impuestos.NEXT = 0;
                                    */
                DiasVencido := 0;
                DiasVencido := FechaFinal - "Cust. Ledger Entry"."Due Date";
                IF DiasVencido <= 0 THEN BEGIN
                    DiasVencido := 0
                END ELSE BEGIN

                    "Cust. Ledger Entry".CALCFIELDS("Remaining Amount");
                    IF DiasVencido <= 30 THEN
                        Treinta := "Cust. Ledger Entry"."Remaining Amount";
                    IF (DiasVencido > 30) AND (DiasVencido <= 60) THEN
                        Sesenta := "Cust. Ledger Entry"."Remaining Amount";
                    IF (DiasVencido > 60) AND (DiasVencido <= 90) THEN
                        Noventa := "Cust. Ledger Entry"."Remaining Amount";
                    IF (DiasVencido > 90) AND (DiasVencido <= 180) THEN
                        cientoochenta := "Cust. Ledger Entry"."Remaining Amount";
                    IF (DiasVencido > 180) THEN
                        MasCientoOchenta := "Cust. Ledger Entry"."Remaining Amount";
                END;
                ValorUsd := 0;
                "Cust. Ledger Entry".CALCFIELDS("Remaining Amount");
                IF "Cust. Ledger Entry"."Currency Code" = 'USD' THEN
                    ValorUsd := "Cust. Ledger Entry"."Remaining Amount";

                IF "Cust. Ledger Entry"."Currency Code" = 'USD' THEN BEGIN
                    CALCFIELDS("Original Amount", "Original Amt. (LCY)");
                    IF "Cust. Ledger Entry"."Original Amount" <> 0 THEN
                        trm := ABS("Original Amt. (LCY)" / "Original Amount");
                END;

                IF trm <= 0 THEN
                    trm := 1;
            end;

            trigger OnPreDataItem();
            begin
                "Cust. Ledger Entry".SETRANGE("Date Filter", FechaInicial, FechaFinal);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fecha Inicial"; FechaInicial)
                {
                }
                field("Fecha Final"; FechaFinal)
                {

                    trigger OnValidate();
                    begin
                        IF FechaInicial > FechaFinal THEN
                            ERROR('La fecha inicial no puede ser mayor a la final');
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        IF FechaFinal = 0D THEN
            ERROR('Debe indicar la fecha final');
        IF FechaInicial = 0D THEN
            ERROR('Debe indicar la fecha inicial');
    end;

    var
        NombreCliente: Text[200];
        Cliente: Record 18;
        CustomerPosting: Record 92;
        Impuestos: Record 254;
        ReteFuente: Decimal;
        Base: Decimal;
        ReteIva: Decimal;
        Iva: Decimal;
        ReteIca: Decimal;
        Descuento: Decimal;
        FechaPago: Date;
        Estado: Text;
        DiasVencido: Integer;
        Treinta: Decimal;
        Sesenta: Decimal;
        Noventa: Decimal;
        cientoochenta: Decimal;
        MasCientoOchenta: Decimal;
        Contabilidad: Record 17;
        ValorUsd: Decimal;
        t: Integer;
        trm: Decimal;
        FechaInicial: Date;
        FechaFinal: Date;
}

