tableextension 57017 "Hex Resource" extends Resource
{
    fields
    {
        //Description=IFRS15
        field(55000; "SVMX Work Type"; Option)
        {
            OptionMembers = ,Labour,Expenses;
            OptionCaptionML = ENU = ' ,Labour,Expenses';
            Description = 'SVMX Work Type';

        }

        field(50010; "Item Category Code"; Code[10])
        {
            TableRelation = "Item Category";
            Description = 'Item Category Code';
            trigger OnValidate()
            VAR
                GetDimenstion: Record 349;
                GetGLsetup: Record 98;
                ItemCategory: Record 5722;
            BEGIN
                //Start HEXGBIC.01
                GetGLsetup.INIT;
                GetDimenstion.INIT;

                IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
                    IF ItemCategory.GET("Item Category Code") THEN BEGIN
                        IF GetGLsetup.FINDFIRST THEN
                            GetDimenstion.SETRANGE("Dimension Code", GetGLsetup."Global Dimension 2 Code");
                        GetDimenstion.SETRANGE(Code, ItemCategory.HyperionCode);
                        IF GetDimenstion.FINDFIRST THEN
                            "Global Dimension 2 Code" := GetDimenstion.Code;
                    END;
                END;
                VALIDATE("Global Dimension 2 Code", GetDimenstion.Code);
                //END HEXGBIC.01
            END;

        }
        field(50106; HexCPQ; Option)
        {
            OptionCaption = ' ,L1,S1';
            OptionMembers = ,L1,S1;
        }
        field(50107; ERPCompanyNumber; Code[10])
        {
            Description = 'ERPCompanyNumber';
        }


    }
    trigger OnInsert()
    var
        CompanyInformation: Record "Company Information";
    begin
        //Resource Master Integration
        CompanyInformation.GET;
        ERPCompanyNumber := CompanyInformation."ERP Company No.";
    end;

    trigger OnModify()
    var
        CompanyInformation: Record "Company Information";
    begin
        //Resource Master Integration
        CompanyInformation.GET;
        IF ERPCompanyNumber = '' THEN
            ERPCompanyNumber := CompanyInformation."ERP Company No.";
    end;


}


