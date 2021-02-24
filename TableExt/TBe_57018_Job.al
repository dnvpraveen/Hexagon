tableextension 57018 "Hex Job" extends Job
{
    fields
    {
        // Add changes to table fields here
        field(55000; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }

    }



    trigger OnInsert()
    var
        CompanyInformation: Record "Company Information";
    begin
        //gk
        CompanyInformation.GET;
        "ERP Company No." := CompanyInformation."ERP Company No.";
        //gk
        //<<HEXGBJOB.01
        //Create Dimension Value for the Job
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", JobsSetup."Dimension for Sales Link");
        DimValue.VALIDATE(Code, "No.");
        DimValue.VALIDATE(Name, "No.");
        DimValue.INSERT(TRUE);
        //HEXGBJOB.01 >>
    end;

    var

        DimValue: Record "Dimension Value";


}