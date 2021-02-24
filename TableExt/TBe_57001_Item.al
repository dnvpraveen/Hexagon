tableextension 57001 "Hex Item" extends Item
{
    fields
    {
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