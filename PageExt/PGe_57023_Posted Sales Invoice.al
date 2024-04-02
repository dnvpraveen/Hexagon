pageextension 57023 PostedSalesInvExt extends "Posted Sales Invoice"
{
    actions
    {
        addafter("&Electronic Document")
        {

            action("Send Invoice Email")
            {
                ApplicationArea = All;
                Image = SendAsPDF;

                trigger OnAction()
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

                begin
                    IF CONFIRM('Desea enviar la factura a este Cliente?') THEN BEGIN
                        SMTP.Get();
                        REC.CALCFIELDS(REC."Amount Including VAT");
                        Cliente.GET(REC."Sell-to Customer No.");
                        SalesInvoice.RESET;
                        SalesInvoice.SETRANGE("No.", rec."No.");
                        SalesInvoice.FINDSET;
                        SalesInvoice.CalcFields("AkkOn-PDF Invoice");
                        SalesInvoice.CalcFields("AkkOn-XML Invoice");
                        SalesInvoice."AkkOn-PDF Invoice".CreateInStream(InvoicePdf);
                        SalesInvoice."AkkOn-XML Invoice".CreateInStream(InvoiceXML);
                        Mail := '';
                        Mail := SalesInvoice."Sell-to E-Mail";
                        if Mail = '' then
                            Mail := Cliente."E-Mail";
                        IF rec."Currency Code" = '' THEN
                            Moneda := 'MXP' ELSE
                            Moneda := rec."Currency Code";
                        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", Mail, 'Factura No. ' + REC."No." + ' PO ' + REC."External Document No." + ' Hexagon Metrology', '', TRUE);
                        //SMAIL.AppendBody('<h3>Estimado/a ' + rec."Customer Name" + '</h3>');
                        Mensaje := 'Es un placer saludarte. Adjunto encontrarás la factura correspondiente a los bienes/servicios proporcionados por Hexagon Metrology. Agradecemos sinceramente tu preferencia y confianza en nuestros productos/servicios.';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := '';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Detalle Factura:';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := '';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Numero Factura: ' + rec."No.";
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Fecha Emision: ' + FORMAT(rec."Document Date");
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Fecha Vencimiento: ' + FORMAT(rec."Due Date");
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Monto Total ' + FORMAT(rec."Amount Including VAT") + ' ' + Moneda;
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Por favor, realiza el pago antes de la fecha de vencimiento mencionada anteriormente. Puedes utilizar los siguientes detalles bancarios para realizar la transferencia:';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Moneda: USD';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Nombre del Banco: CitiBanamex';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Número de Cuenta: 44779000610';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Beneficiario: Hexagon Metrology, S. de R.L. de C.V';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Código SWIFT/BIC: BNMXMXMM';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Gracias por elegir a Hexagon Metrology. Esperamos poder servirte nuevamente en el futuro.';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        SMAIL.AppendBody('<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/1tkfTs3N/firma-Hexagon.jpg" border="0" alt="firma-Hexagon"/></a>');
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
                        Message('Invoice has been sent');
                    END;
                end;

            }
        }
    }
}
