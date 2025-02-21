report 50004 BackLog
{
    Caption = 'Update Backlog';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
            }
        }
    }
    trigger OnPreReport()
    var
        SalesLine: Page "Sales Lines";
        JobTask: Page "Job Task Lines";
        Deferral: Page Deferral;
        SMAIL: Codeunit "SMTP Mail";
        SMTP: Record "SMTP Mail Setup";
        Mensaje: Text;
        Mail: text;
        Temblob: Record TempBlob;
        OutStream: OutStream;
        inStream: InStream;
        SalesSetup: Record "Sales & Receivables Setup";

    begin
        Temblob.Blob.CreateOutStream(OutStream);
        SMTP.Get();
        SalesSetup.get;
        Mail := SalesSetup."Email Backlog";

        SalesLine.UpdateBacklok();
        JobTask.UpdateBacklog();
        Deferral.UpdateBacklog();
        SMAIL.CreateMessage('Notificaciones ERP NAV', SMTP."User ID", Mail, 'Reporte Backlog generado el ' + DelChr(format(CurrentDateTime), '=', '.'), '', TRUE);
        report.SaveAs(50007, '', ReportFormat::Excel, OutStream);
        Temblob.Blob.CreateInStream(inStream);
        SMAIL.AddAttachmentStream(inStream, 'Backlog.xlsx');
        SMAIL.Send();
    end;
}
