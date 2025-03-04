report 50009 "Depreciacion Fiscal"
{
    ApplicationArea = All;
    Caption = 'Depreciacion Fiscal';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Depreciacion.rdl';
    dataset
    {
        dataitem(FixedAsset; "FA Depreciation Book")
        {
            column(No; FixedAsset."FA No.")
            {
            }
            column(Description; activos.Description)
            {
            }
            column(AcquisitionCostAccount; FAPostingGroup."Acquisition Cost Account")
            {
            }
            column(AccumDepreciationAccount; FAPostingGroup."Accum. Depreciation Account")
            {
            }
            column("FASubClass"; activos."FA Subclass Code")
            {
            }
            column("MOI"; "Acquisition Cost")
            {
            }
            column("AcquisitionDate"; "Acquisition Date")
            {
            }
            column("MesesDepreciacion"; "No. of Depreciation Years" * 12)
            {
            }
            column("DepreciacionAcomuladas"; (Depreciation * -1))
            {
            }
            column("ValorEnLibros"; (Depreciation * -1) - "Acquisition Cost")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Activos);
                if Activos.get(FixedAsset."FA No.") then;
                FixedAsset.CalcFields(Depreciation, "Acquisition Cost");
                if FAPostingGroup.get(FixedAsset."FA Posting Group") then;
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
        FABOOK: Record "FA Depreciation Book";
        Activos: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";


}
