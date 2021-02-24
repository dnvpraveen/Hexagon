tableextension 57003 ItemCategory extends "Item Category"
{
    fields
    {
        field(50000; "Hex Status"; Boolean)
        {
            //DataClassification = ToBeClassified;
            Description = 'Hex Status';

        }
        field(50001; "HyperionCode"; Code[10])
        {
            //DataClassification = ToBeClassified;
            Description = 'Hyperion Code';

        }
        field(50002; "HyperionCodeDesc"; Text[50])
        {
            //DataClassification = ToBeClassified;
            Description = 'HyperionCode Desc';

        }
        field(50003; "Status"; code[10])
        {
            //DataClassification = ToBeClassified;
            Description = 'Status';

        }

    }


}