report 50005 EnvioFacturasNav
{
    ApplicationArea = All;
    Caption = 'EnvioFacturasNav';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; integer)
        {

            DataItemTableView = where(Number = const(1));

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
    trigger OnPreReport()

    var
        ventana: Dialog;
        Cliente: Record Customer;
        SalesInvoice: Record "Sales Invoice Header";
        SMAIL: Codeunit "SMTP Mail";
        Moneda: Text;
        EmailTable: Record "Email Item";
        EmailPage: Page "Email Dialog";
        Mensaje: Text;
        RecRef: RecordRef;
        OutStream: OutStream;
        InvoicePdf: InStream;
        InvoiceXML: InStream;
        adjunto: InStream;
        DocumentServices: Codeunit "Document Service Management";
        SMTP: Record "SMTP Mail Setup";
        RecDocAttached: Record "Document Attachment";
        TenantMedia: Record "Tenant Media";
        Mail: Text;
        SalesInvoiceHeader: Record "Sales Invoice Header";

    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("Posting Date", Today);
        SalesInvoiceHeader.SetRange("Akkon-Action", 'FIRMA-DONE');
        if SalesInvoiceHeader.FindSet() then
            repeat

                SMTP.Get();
                SalesInvoiceHeader.CALCFIELDS(SalesInvoiceHeader."Amount Including VAT");
                Cliente.GET(SalesInvoiceHeader."Sell-to Customer No.");

                SalesInvoice.RESET;
                SalesInvoice.SETRANGE("No.", SalesInvoiceHeader."No.");
                SalesInvoice.FINDSET;
                SalesInvoice.CalcFields("AkkOn-PDF Invoice");
                SalesInvoice.CalcFields("AkkOn-XML Invoice");
                SalesInvoice."AkkOn-PDF Invoice".CreateInStream(InvoicePdf);
                SalesInvoice."AkkOn-XML Invoice".CreateInStream(InvoiceXML);
                Mail := '';
                //Mail := 'jose.floresgarza@hexagon.com;jcamargo@byjsoluciones.com';
                if Mail = '' then
                    Mail := Cliente."E-Mail";
                IF SalesInvoiceHeader."Currency Code" = '' THEN
                    Moneda := 'MXP' ELSE
                    Moneda := SalesInvoiceHeader."Currency Code";
                SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", Mail, 'Factura No. ' + SalesInvoiceHeader."No." + ' PO ' + SalesInvoiceHeader."External Document No." + ' Hexagon Metrology', '', TRUE);
                SMAIL.AppendBody('<h3>Estimado ' + SalesInvoiceHeader."Sell-to Customer Name" + '<h3>');
                Mensaje := 'Es un placer saludarte. Adjunto encontrarás la factura correspondiente a los bienesservicios proporcionados por Hexagon Metrology. Agradecemos sinceramente tu preferencia y confianza en nuestros productosservicios.';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := '';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Detalle Factura:';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := '';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Numero Factura: ' + SalesInvoiceHeader."No.";
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Fecha Emision: ' + FORMAT(SalesInvoiceHeader."Document Date");
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Fecha Vencimiento: ' + FORMAT(SalesInvoiceHeader."Due Date");
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Monto Total ' + FORMAT(SalesInvoiceHeader."Amount Including VAT") + ' ' + Moneda;
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Por favor, realiza el pago antes de la fecha de vencimiento mencionada anteriormente. Puedes utilizar los siguientes detalles bancarios para realizar la transferencia:';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Moneda: USD';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Nombre del Banco: CitiBanamex';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Número de Cuenta: 44779000610';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Beneficiario: Hexagon Metrology, S. de R.L. de C.V';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Código SWIFTBIC: BNMXMXMM';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                Mensaje := 'Gracias por elegir a Hexagon Metrology. Esperamos poder servirte nuevamente en el futuro.';
                SMAIL.AppendBody('<p>' + Mensaje + '<p>');
                SMAIL.AppendBody('<a href="https:postimages.org" target="_blank"><img src="https:i.postimg.cc1tkfTs3Nfirma-Hexagon.jpg" border="0" alt="firma-Hexagon"><a>');
                SMAIL.AddAttachmentStream(InvoicePdf, SalesInvoice."No." + '.pdf');
                SMAIL.AddAttachmentStream(InvoiceXML, SalesInvoice."No." + '.xml');
                RecDocAttached.Reset();
                RecDocAttached.SetRange("No.", SalesInvoice."No.");
                if RecDocAttached.FindSet() then
                    repeat begin
                        if TenantMedia.get(RecDocAttached."Document Reference ID".MediaId) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue then begin
                                Clear(adjunto);
                                TenantMedia.Content.CreateInStream(adjunto);
                                SMAIL.AddAttachmentStream(adjunto, RecDocAttached."File Name" + '.' + RecDocAttached."File Extension");
                            end;
                        end;
                    end until RecDocAttached.Next() = 0;
                SMAIL.Send();
            until SalesInvoiceHeader.Next() = 0;
    end;
}
