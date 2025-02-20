codeunit 50004 SendMailHexagon
{
    procedure EnviarEstadoCuenta(ClienteH: Code[50])
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
        CustomerH: Record Customer;

    begin
        CustomerH.GET(ClienteH);
        if CustomerH."E-Mail" = '' then
            CustomerH."E-Mail" := SMTP."User ID";
        SMTP.get;
        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", CustomerH."E-Mail", 'Estado de Cuenta - Hexagon Metrology', '', TRUE);
        SMAIL.AppendBody('<h3>Estimado/a ' + CustomerH.Name + '</h3>');
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
        CustLedgar.SETRANGE("Customer No.", CustomerH."No.");
        CustLedgar.SETRANGE("Document Type", CustLedgar."Document Type"::Invoice);
        CustLedgar.SETRANGE(Open, TRUE);
        IF CustLedgar.FINDSET THEN
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
        SMAIL.AppendBody('  <tr>');
        SMAIL.AppendBody('    <td><b>Total Pendiente</b></td>');
        SMAIL.AppendBody('    <td><b>$' + FORMAT(TotalPayment) + ' ' + CustLedgar."Currency Code" + '</b></td>');
        SMAIL.AppendBody('  </tr>');
        SMAIL.AppendBody('</table>');
        SMAIL.AppendBody('</body>');
        SMAIL.AppendBody('</html>');
        Mensaje := 'Por favor, realizar el pago antes de la fecha de vencimiento mencionada anteriormente. Puedes utilizar los siguientes detalles bancarios para realizar la transferencia:';
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
    end;


    procedure EnvioComplementoPago(CustomerLedgerNo: Integer)
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
        CustomerH: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.get(CustomerLedgerNo);
        CustomerH.GET(CustLedgerEntry."Customer No.");
        SMTP.get;
        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", CustomerH."E-Mail", 'Envío de Complemento de Pago', '', TRUE);
        SMAIL.AppendBody('<h3>Estimado/a ' + CustomerH.Name + '</h3>');
        Mensaje := 'Agradecemos su reciente pago y su continuo compromiso con mantener su cuenta al corriente.';
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
        SMAIL.AppendBody('    <th>Factura Pagada</th>');
        SMAIL.AppendBody('    <th>Fecha de Pago</th>');
        SMAIL.AppendBody('    <th>Monto</th>');
        SMAIL.AppendBody('    <th>Moneda</th>');
        SMAIL.AppendBody('  </tr>');
        CustLedgerEntry.CalcFields(Amount);
        CustLedgerEntry."Signed Document XML".CreateInStream(InvoicePdf);
        CustLedgerEntry."AkkOn-XML Invoice".CreateInStream(InvoiceXML);
        CustLedgar.Reset();
        CustLedgar.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
        if CustLedgar.FindSet() then
            repeat
                CustLedgar.CALCFIELDS("Amount");
                if CustLedgar."Currency Code" = '' then
                    CustLedgar."Currency Code" := 'MXP';
                SMAIL.AppendBody('  <tr>');
                SMAIL.AppendBody('    <td>' + CustLedgar."Document No." + '</td>');
                SMAIL.AppendBody('    <td>' + format(CustLedgerEntry."Posting Date") + '</td>');
                SMAIL.AppendBody('    <td>$' + FORMAT(CustLedgar.Amount) + '</td>');
                SMAIL.AppendBody('    <td>' + FORMAT(CustLedgar."Currency Code") + '</td>');
                SMAIL.AppendBody('  </tr>');
            until CustLedgar.Next() = 0;
        SMAIL.AppendBody('  <tr>');
        SMAIL.AppendBody('    <td><b>Total Pagado</b></td>');
        SMAIL.AppendBody('    <td><b>$' + FORMAT(CustLedgerEntry.Amount * -1) + ' ' + CustLedgar."Currency Code" + '</b></td>');
        SMAIL.AppendBody('  </tr>');
        SMAIL.AppendBody('</table>');
        SMAIL.AppendBody('</body>');
        SMAIL.AppendBody('</html>');
        Mensaje := 'Por favor, confirme la recepción de este complemento de pago. Si es necesario ingresar la información en algún portal, le agradeceríamos su confirmación.';
        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
        Mensaje := 'Quedamos atentos/as a cualquier otra consulta.';
        SMAIL.AppendBody('<p>' + Mensaje + '</p>');
        SMAIL.AppendBody('<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/1tkfTs3N/firma-Hexagon.jpg" border="0" alt="firma-Hexagon"/></a>');
        SMAIL.AddAttachmentStream(InvoicePdf, CustLedgerEntry."Document No." + '.pdf');
        SMAIL.AddAttachmentStream(InvoiceXML, CustLedgerEntry."Document No." + '.xml');
        SMAIL.Send();
    end;

}
