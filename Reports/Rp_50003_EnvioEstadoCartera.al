report 50003 EnvioEstadoCartera
{
    ApplicationArea = All;
    Caption = 'EnvioEstadoCartera';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Balance (LCY)" = filter(> 0));
            trigger OnAfterGetRecord()
            var
                enviocorreo: Codeunit SendMailHexagon;
            begin
                enviocorreo.EnviarEstadoCuenta(Customer."No.");
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
