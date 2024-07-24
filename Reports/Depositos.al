report 50008 Depositos
{
    ApplicationArea = All;
    Caption = 'Depositos';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Depositos.rdl';
    dataset
    {
        dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
        {
            DataItemTableView = where(Amount = filter(> 0));
            RequestFilterFields = "Bank Account No.", "Posting Date", "Document No.";
            column(Banco; bank.Name)
            {

            }
            column(Rfc; bank."Transit No.")
            {
            }
            column(Divisa; moneda)
            {
            }
            column(Beneficiario; 'HEXAGON METROLOGY')
            {
            }
            column(RfcBeneficiario; 'HME020219V23')
            {
            }
            column(Concepto; Description)
            {
            }
            column(FechaDeposito; "Posting Date")
            {
            }

            column(Deposito; Amount)
            {
            }
            column(Cliente; cliente.Name)
            {
            }
            column(RfcCliente; cliente."VAT Registration No.")
            {
            }
            column(OrdenDeCompra; SalesInvHeader."External Document No.")
            {
            }
            column(PostingDate; SalesInvHeader."Posting Date")
            {
            }
            column(RefContable; "Document No.")
            {
            }
            column(CustLedgerEntry; CustLedger."Entry No.")
            {
            }
            column(Factura; CustLedger."Document No.")
            {
            }
            column(UUID; SalesInvHeader."Fiscal Invoice Number PAC")
            {
            }
            column(ImporteFactura; SalesInvHeader.Amount)
            {
            }
            column(ImporteIVA; SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount)
            {
            }
            column(ImporteTotal; SalesInvHeader."Amount Including VAT")
            {
            }
            column(Comision; 0)
            {
            }
            column(Moneda; CodMoneda)
            {
            }
            column(TC; TC)
            {
            }
            column(ImporteValorizado; SalesInvHeader.Amount * TC)
            {
            }
            column(ImporteIVAValorizado; (SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount) * TC)
            {
            }

            column(ImporteTotalValorizado; (SalesInvHeader."Amount Including VAT") * TC)
            {
            }



            trigger OnAfterGetRecord()

            begin
                Clear(bank);
                Clear(moneda);
                Clear(CodMoneda);
                bank.get("Bank Account No.");
                if "Currency Code" = 'USD' THEN begin
                    moneda := 'Dolares Americanos';
                    CodMoneda := 'USD';
                end else begin
                    CodMoneda := 'MXP';
                    moneda := 'Pesos Mexicanos'
                end;

                IF CodMoneda = 'USD' THEN begin
                    TC := "Amount (LCY)" / Amount;
                end else
                    TC := 1;
                DetailCust.Reset();
                DetailCust.SetRange("Document No.", BankAccountLedgerEntry."Document No.");
                if DetailCust.FindSet() then begin
                    repeat
                        Clear(CustLedger2);
                        CustLedger2.Reset();
                        CustLedger2.SetRange("Entry No.", DetailCust."Cust. Ledger Entry No.");
                        CustLedger2.FindSet();
                        Clear(SalesInvHeader);
                        SalesInvHeader.Reset();
                        SalesInvHeader.SetRange("No.", CustLedger2."Document No.");
                        if SalesInvHeader.FindSet() then begin
                            SalesInvHeader.CalcFields(Amount);
                            SalesInvHeader.CalcFields("Amount Including VAT");
                            Clear(cliente);
                            if cliente.get(SalesInvHeader."Sell-to Customer No.") then;
                        end;
                    until DetailCust.Next() = 0;
                end else
                    CurrReport.Skip();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

    }
    var
        bank: Record "Bank Account";
        moneda: Text;
        cliente: Record Customer;
        SalesInvHeader: Record "Sales Invoice Header";
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger2: Record "Cust. Ledger Entry";
        CodMoneda: Code[50];
        TC: Decimal;
        DetailCust: Record "Detailed Cust. Ledg. Entry";
}
