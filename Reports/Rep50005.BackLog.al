report 50007 BackLogPrint
{
    Caption = 'BackLogReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Backlog.rdl';

    dataset
    {
        dataitem(BackLog; Backlog_HGN)
        {
            column(No; "No.")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemDescription; "Item Description")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(PRODUCTCATCode; "PRODUCT CAT Code")
            {
            }
            column(ProductCATName; "Product CAT Name")
            {
            }
            column(MTKSectorCode; "MTK Sector Code")
            {
            }
            column(MTKSectorName; "MTK Sector Name")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(PromisedDeliveryDate; "Promised Delivery Date")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountLCY; "Amount LCY")
            {
            }
            column(Q1; Q1)
            {
            }
            column(Q2; Q2)
            {
            }
            column(Q3; Q3)
            {
            }
            column(Q4; Q4)
            {
            }
            column(NextYear; NextYear)
            {
            }
            column(TipoReporte; "Tipo Reporte")
            {
            }
            trigger OnAfterGetRecord()
            var
                CurrentYear: Integer;
                Q1Start: Date;
                Q1End: Date;
                Q2Start: Date;
                Q2End: Date;
                Q3Start: Date;
                Q3End: Date;
                Q4Start: Date;
                Q4End: Date;
                NextYearStart: Date;
            begin
                BackLog.Q1 := 0;
                BackLog.Q2 := 0;
                BackLog.Q3 := 0;
                BackLog.Q4 := 0;
                BackLog.NextYear := 0;
                CurrentYear := DATE2DMY(WorkDate(), 3);

                // Definir los rangos de fechas dinámicamente
                Q1Start := DMY2DATE(1, 1, CurrentYear);
                Q1End := DMY2DATE(31, 3, CurrentYear);
                Q2Start := DMY2DATE(1, 4, CurrentYear);
                Q2End := DMY2DATE(30, 6, CurrentYear);
                Q3Start := DMY2DATE(1, 7, CurrentYear);
                Q3End := DMY2DATE(30, 9, CurrentYear);
                Q4Start := DMY2DATE(1, 10, CurrentYear);
                Q4End := DMY2DATE(31, 12, CurrentYear);
                NextYearStart := DMY2DATE(1, 1, CurrentYear + 1);

                if BackLog."Promised Delivery Date" <> 0D THEN BEGIN
                    if (BackLog."Promised Delivery Date" >= Q1Start) and (BackLog."Promised Delivery Date" <= Q1End) THEN
                        BackLog.Q1 := BackLog."Amount LCY";
                    if (BackLog."Promised Delivery Date" >= Q2Start) and (BackLog."Promised Delivery Date" <= Q2End) THEN
                        BackLog.Q2 := BackLog."Amount LCY";
                    if (BackLog."Promised Delivery Date" >= Q3Start) and (BackLog."Promised Delivery Date" <= Q3End) THEN
                        BackLog.Q3 := BackLog."Amount LCY";
                    if (BackLog."Promised Delivery Date" >= Q4Start) and (BackLog."Promised Delivery Date" <= Q4End) THEN
                        BackLog.Q4 := BackLog."Amount LCY";
                END;

                if (BackLog."Promised Delivery Date" = 0D) or (BackLog."Promised Delivery Date" < WorkDate()) THEN BEGIN
                    if (WorkDate() >= Q1Start) and (WorkDate() <= Q1End) THEN
                        BackLog.Q1 := BackLog."Amount LCY";
                    if (WorkDate() >= Q2Start) and (WorkDate() <= Q2End) THEN
                        BackLog.Q2 := BackLog."Amount LCY";
                    if (WorkDate() >= Q3Start) and (WorkDate() <= Q3End) THEN
                        BackLog.Q3 := BackLog."Amount LCY";
                    if (WorkDate() >= Q4Start) and (WorkDate() <= Q4End) THEN
                        BackLog.Q4 := BackLog."Amount LCY";
                END;

                if (BackLog."Promised Delivery Date" >= NextYearStart) THEN BEGIN
                    BackLog.NextYear := BackLog."Amount LCY";
                END;
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
}
