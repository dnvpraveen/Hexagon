pageextension 50089 CustLedgerEntryExt extends "Customer Ledger Entries"
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
                        REC.CALCFIELDS(REC."Remaining Amount");
                        REC.CALCFIELDS(REC."Original Amount");
                        Cliente.GET(REC."Customer No.");
                        REC."Customer Name" := Cliente.Name;
                        SalesInvoice.RESET;
                        SalesInvoice.SETRANGE("No.", rec."Document No.");
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
                        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", Mail, 'Factura No. ' + REC."Document No." + ' PO ' + REC."External Document No." + ' Hexagon Metrology', '', TRUE);
                        //SMAIL.AppendBody('<h3>Estimado/a ' + rec."Customer Name" + '</h3>');
                        Mensaje := 'Es un placer saludarte. Adjunto encontrarás la factura correspondiente a los bienes/servicios proporcionados por Hexagon Metrology. Agradecemos sinceramente tu preferencia y confianza en nuestros productos/servicios.';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := '';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Detalle Factura:';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := '';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Numero Factura: ' + rec."Document No.";
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Fecha Emision: ' + FORMAT(rec."Document Date");
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Fecha Vencimiento: ' + FORMAT(rec."Due Date");
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                        Mensaje := 'Monto Total ' + FORMAT(rec."Original Amount") + ' ' + Moneda;
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

            action("Enviar Recordatorio de Pago")
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
                    CustLedgar: Record "Cust. Ledger Entry";
                    DocumentServices: Codeunit "Document Service Management";
                    SMTP: Record "SMTP Mail Setup";
                    TotalPayment: Decimal;
                    contador: Integer;

                begin
                    IF CONFIRM('Desea enviar recordatorio de facturas vencidas a este Cliente?') THEN BEGIN
                        Ventana.OPEN('Enviando Correo');
                        rec.CALCFIELDS(rec."Remaining Amount");
                        rec.CALCFIELDS(rec."Original Amount");
                        SMTP.get;
                        //CLEAR(FacturaPDF);
                        Cliente.GET(rec."Customer No.");
                        rec."Customer Name" := Cliente.Name;
                        IF rec."Currency Code" = '' THEN
                            Moneda := 'MXP' ELSE
                            Moneda := rec."Currency Code";
                        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", Cliente."E-Mail", 'Recordatorio de Pago de Facturas - Hexagon Metrology', '', TRUE);
                        SMAIL.AppendBody('<h3>Estimado/a ' + rec."Customer Name" + '</h3>');
                        Mensaje := 'Es un placer saludarte. Adjunto encontrarás las factura vencidas correspondiente a los bienes/servicios proporcionados por Hexagon Metrology. Agradecemos sinceramente tu preferencia y confianza en nuestros productos/servicios.';
                        SMAIL.AppendBody('<p>' + Mensaje + '</p>');

                        SMAIL.AppendBody('<!DOCTYPE html>');
                        SMAIL.AppendBody('<html>');
                        SMAIL.AppendBody('<style>');
                        SMAIL.AppendBody('table, th, td {');
                        SMAIL.AppendBody('  border:1px solid black;');
                        SMAIL.AppendBody('}');
                        SMAIL.AppendBody('</style>');
                        SMAIL.AppendBody('<body>');
                        SMAIL.AppendBody('<table style="width:50%">');
                        SMAIL.AppendBody('  <tr>');
                        SMAIL.AppendBody('    <th>No. Factura</th>');
                        SMAIL.AppendBody('    <th>No. PO</th>');
                        SMAIL.AppendBody('    <th>Valor</th>');
                        SMAIL.AppendBody('    <th>Fecha Vencimiento</th>');
                        SMAIL.AppendBody('  </tr>');
                        CustLedgar.RESET;
                        CustLedgar.SETRANGE("Customer No.", rec."Customer No.");
                        CustLedgar.SETRANGE("Document Type", CustLedgar."Document Type"::Invoice);
                        CustLedgar.SETRANGE(Open, TRUE);
                        IF CustLedgar.FINDSET THEN BEGIN
                            REPEAT
                                CustLedgar.CALCFIELDS("Remaining Amount");
                                TotalPayment := TotalPayment + (CustLedgar."Remaining Amount");
                                SMAIL.AppendBody('  <tr>');
                                SMAIL.AppendBody('    <td>' + CustLedgar."Document No." + '</td>');
                                SMAIL.AppendBody('    <td>' + CustLedgar."External Document No." + '</td>');
                                SMAIL.AppendBody('    <td>$' + FORMAT(CustLedgar."Remaining Amount") + ' ' + CustLedgar."Currency Code" + '</td>');
                                SMAIL.AppendBody('    <td>' + FORMAT(CustLedgar."Due Date") + '</td>');
                                SMAIL.AppendBody('  </tr>');
                                Contador := Contador + 1;
                            UNTIL CustLedgar.NEXT = 0;
                        END ELSE
                            ERROR('Este cliente no tiene facturas vencidas o abiertas');
                        SMAIL.AppendBody('  <tr>');
                        SMAIL.AppendBody('    <td><b>Total Pendiente</b></td>');
                        SMAIL.AppendBody('    <td><b>$' + FORMAT(TotalPayment) + ' ' + CustLedgar."Currency Code" + '</b></td>');
                        SMAIL.AppendBody('  </tr>');



                        SMAIL.AppendBody('</table>');
                        SMAIL.AppendBody('</body>');
                        SMAIL.AppendBody('</html>');



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
                        SMAIL.Send();
                        Ventana.CLOSE;

                    END;
                end;


            }
        }

    }
}
