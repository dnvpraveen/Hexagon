report 50006 "Retiros Banco"
{
    ApplicationArea = All;
    Caption = 'Retiros';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Retiros.rdl';
    dataset
    {
        dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Bank Account No.", "Posting Date", "Document No.";
            column(Banco; BankAccountLedgerEntry."Bank Account No.")
            {
            }
            column(RFC; '')
            {
            }
            column(Amount; BankAccountLedgerEntry.Amount) { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLinkReference = BankAccountLedgerEntry;
                DataItemLink = "Document No." = FIELD("Document No.");
                column(DocumentNo; "Document No.")
                {
                }
                column(Divisa; Moneda)
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
                column(Vendor_Name; "Vendor Name")
                {
                }
                column(RFCProveedor; vendor."VAT Registration No.")
                {
                }

                dataitem(VendorLedger; "Vendor Ledger Entry")
                {
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                    column(FacturaProveedor; "External Document No.")
                    {

                    }
                    column(Posting_Date; "Posting Date")
                    {

                    }
                    column(RefCOntable; "Document No.")
                    {

                    }
                    column(VendorLedgerEntry; "Entry No.")
                    {

                    }
                    column(ImporteFactura; Amount)
                    {

                    }
                    column(Moneda; "Currency Code")
                    {

                    }
                    column(AkkOn_SAT_UUID_Stamp; "AkkOn-SAT UUID Stamp")
                    {

                    }
                    column(IVA; IVA)
                    {

                    }
                    column(RETISRDIV; RETISRDIV)
                    {

                    }
                    column(RETISRHON; RETISRHON)
                    {

                    }
                    column(RETISRRSC; RETISRRSC)
                    {

                    }
                    column(RETIVAARR; RETIVAARR)
                    {

                    }
                    column(RETIVACOM; RETIVACOM)
                    {

                    }
                    column(RETIVAFLE; RETIVAFLE)
                    {

                    }

                    column(RETIVAHON; RETIVAHON)
                    {

                    }
                    column(RETIVAOUT; RETIVAOUT)
                    {

                    }
                    column(RETIVASRV; RETIVASRV)
                    {

                    }
                    trigger OnAfterGetRecord()

                    begin
                        IVA := 0;
                        VATEntry.Reset();
                        VATEntry.SetRange("Document No.", "Document No.");
                        if VATEntry.FindSet() then
                            repeat
                                if VATEntry."VAT Prod. Posting Group" = 'IVA16' then
                                    IVA += VATEntry."Unrealized Amount";
                                if VATEntry."VAT Prod. Posting Group" = 'IVA8' then
                                    IVA8 += VATEntry."Unrealized Amount";

                                if VATEntry."VAT Prod. Posting Group" = 'RETISR-DIV' then
                                    RETISRDIV += VATEntry."Unrealized Amount";

                                if VATEntry."VAT Prod. Posting Group" = 'RETISR-HON' then
                                    RETISRHON += VATEntry."Unrealized Amount";

                                if VATEntry."VAT Prod. Posting Group" = 'RETISR-RSC' then
                                    RETISRRSC += VATEntry."Unrealized Amount";

                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-ARR' then
                                    RETIVAARR += VATEntry."Unrealized Amount";

                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-COM' then
                                    RETIVACOM += VATEntry."Unrealized Amount";
                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-FLE' then
                                    RETIVAFLE += VATEntry."Unrealized Amount";
                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-HON' then
                                    RETIVAHON += VATEntry."Unrealized Amount";
                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-OUT' then
                                    RETIVAOUT += VATEntry."Unrealized Amount";
                                if VATEntry."VAT Prod. Posting Group" = 'RETIVA-SRV' then
                                    RETIVASRV += VATEntry."Unrealized Amount";

                            until VATEntry.Next() = 0;



                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    if "Currency Code" = '' then
                        Moneda := 'Pesos Mexicanos' else
                        Moneda := 'Dolares';
                    if
                    vendor.get("Vendor No.") then;


                end;
            }

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
        Moneda: Text;
        Vendor: Record Vendor;
        IVA16: Decimal;
        IVA8: Decimal;
        RETISRDIV: Decimal;
        RETISRHON: Decimal;
        RETISRRSC: Decimal;
        RETIVAARR: Decimal;
        RETIVACOM: Decimal;
        RETIVAFLE: Decimal;
        RETIVAHON: Decimal;
        RETIVAOUT: Decimal;
        RETIVASRV: Decimal;
        VATEntry: Record "VAT Entry";
        IVA: Decimal;


}
