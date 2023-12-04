report 50002 "Cartera Por Edades Proveedores"
{
    ApplicationArea = All;
    Caption = 'Cartera Edades Proveedores';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Cartera Por Edades Proveedores.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Vendor Ledger Entry")

        {
            DataItemTableView = where("Remaining Amount" = filter(<> 0), "Document Type" = const(Invoice));
            RequestFilterFields = "Vendor No.", "Date Filter", "Document No.";
            column(Identificacion; "Cust. Ledger Entry"."Vendor No.")
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
            column(CuentaContable; CuentaCont)
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
                CLEAR(Contabilidad2);
                CLEAR(Cliente);
                CLEAR(CuentaCont);

                CuentaCont := '';

                Cliente.RESET;
                Cliente.SETRANGE("No.", "Cust. Ledger Entry"."Vendor No.");
                Cliente.FINDSET;
                CustomerPosting.RESET;
                CustomerPosting.SETRANGE(Code, Cliente."Vendor Posting Group");
                IF CustomerPosting.FINDSET THEN BEGIN
                END;

                Contabilidad2.RESET;
                Contabilidad2.SETRANGE("Document No.", "Document No.");
                Contabilidad2.SETFILTER("G/L Account No.", '2355*|1330*|2205*');
                Contabilidad2.SETRANGE("Source No.", "Cust. Ledger Entry"."Vendor No.");
                IF Contabilidad2.FINDSET THEN BEGIN
                    CuentaCont := Contabilidad."G/L Account No.";

                END ELSE BEGIN
                    CuentaCont := CustomerPosting."Payables Account";
                END;


                IF CuentaCont = '' THEN
                    CuentaCont := '22050501';

                IF "Cust. Ledger Entry"."Vendor No." = '53106792' THEN
                    CuentaCont := '23550501';

                IF "Cust. Ledger Entry"."Vendor No." = '79836435' THEN
                    CuentaCont := '23550501';

                IF "Cust. Ledger Entry"."Vendor No." = '1126805275' THEN
                    CuentaCont := '23550501';



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



                DiasVencido := TODAY - "Cust. Ledger Entry"."Due Date";
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

                IF trm = 1 THEN
                    "Cust. Ledger Entry"."Remaining Amount" := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NombreCliente: Text[200];
        Cliente: Record 23;
        CustomerPosting: Record 93;
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
        Contabilidad2: Record 17;
        ValorUsd: Decimal;
        t: Integer;
        trm: Decimal;
        Contabilidad: Record 17;
        CuentaCont: Code[10];
}

