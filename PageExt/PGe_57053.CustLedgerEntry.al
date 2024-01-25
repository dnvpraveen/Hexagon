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
                    OutStream: OutStream;

                begin
                    IF CONFIRM('Desea enviar la factura a este Cliente?') THEN BEGIN

                        REC.CALCFIELDS(REC."Remaining Amount");
                        REC.CALCFIELDS(REC."Original Amount");
                        Cliente.GET(REC."Customer No.");
                        REC."Customer Name" := Cliente.Name;
                        SalesInvoice.RESET;
                        SalesInvoice.SETRANGE("No.", rec."Document No.");
                        SalesInvoice.FINDSET;
                        SalesInvoice.CalcFields("AkkOn-PDF Invoice");
                        SalesInvoice.CalcFields("AkkOn-XML Invoice");
                        SalesInvoice."AkkOn-PDF Invoice".Export('C:\NAV\' + SalesInvoice."No." + '.pdf');
                        SalesInvoice."AkkOn-XML Invoice".Export('C:\NAV\' + SalesInvoice."No." + '.xml');
                        IF rec."Currency Code" = '' THEN
                            Moneda := 'MXP' ELSE
                            Moneda := rec."Currency Code";

                        EmailTable.DeleteAll();
                        EmailTable.Init();
                        EmailTable."Send to" := Cliente."E-Mail";
                        EmailTable.Subject := 'Factura No. ' + REC."Document No." + ' PO ' + REC."External Document No." + ' Hexagon Metrology';


                        SMAIL.CreateMessage('Notificaciones ERP NAV', 'felectronicadiscarbon@byjsoluciones.com', 'jcamargo@byjsoluciones.com;angela.reyes@hexagon.com', 'Factura No. ' + REC."Document No." + ' PO ' + REC."External Document No." + ' Hexagon Metrology', '', TRUE);
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
                        SMAIL.Send();


                    END;
                end;
            }
        }
    }
}
