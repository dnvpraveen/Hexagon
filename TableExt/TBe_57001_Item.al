tableextension 57001 "Hex Item" extends Item
{
    fields
    {

        field(50100; HexServicePart; Code[2])
        {
            Description = 'HexServicePart';
        }
        field(50101; HexFacility; Code[10])
        {
            Description = 'HexFacility';
        }
        field(50102; HexECCN; Code[10])
        {
            Description = 'HexECCN';
        }
        field(50103; HexINTRASTAT; Code[10])
        {
            Description = 'HexINTRASTAT';
        }
        field(50104; HexINTRASTAT2; Code[10])
        {
            Description = 'HexINTRASTAT2';
        }
        field(50105; HexRevision; Code[10])
        {
            Description = 'HexRevision';
        }
        field(50106; HexCPQ; Code[5])
        {
            Description = 'HexCPQ';
        }
        field(50107; ERPCompanyNumber; Code[10])
        {
            Description = 'ERPCompanyNumber';
        }
        field(50108; HexSourceSystem; Code[5])
        {
            Description = 'HexSourceSystem';
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var
                ItemCategory: Record "Item Category";
                getGLsetup: Record "General Ledger Setup";
                GetDimenstion: Record "Dimension Value";
            begin
                //Start HEXGBIC.01
                IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
                    IF ItemCategory.GET("Item Category Code") THEN BEGIN
                        GetGLsetup.INIT;
                        GetDimenstion.INIT;
                        IF GetGLsetup.FINDFIRST THEN
                            GetDimenstion.SETRANGE("Dimension Code", GetGLsetup."Global Dimension 2 Code");
                        GetDimenstion.SETRANGE("Hyperion Product Code", ItemCategory.HyperionCode);
                        IF GetDimenstion.FINDFIRST THEN
                            "Global Dimension 2 Code" := GetDimenstion.Code;
                    END;

                    VALIDATE("Global Dimension 2 Code", GetDimenstion.Code);
                END;
                //End HEXGBIC.01
                //Message('welcome your are in new BC');
            end;
        }
    }
}