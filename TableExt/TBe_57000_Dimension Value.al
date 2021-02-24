tableextension 57000 "Hex Dimension" extends "Dimension Value"
{
    fields
    {
        field(50000; "Hyperion Product Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'Hyperion Product Code';

        }
        field(50001; "Parent Dimension Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'Parent Dimension Code';

        }
        field(50002; "Parent Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'Parent Code';

        }
        field(50003; "Do not show"; Boolean)
        {
            //DataClassification = ToBeClassified;
            Description = 'Do not show';

        }
        field(50004; "Hex seq ID"; Code[10])
        {
            //DataClassification = ToBeClassified;
            Description = 'Hex seq ID';

        }
        field(50005; "GMDD Seq ID"; Integer)
        {
            //DataClassification = ToBeClassified;
            Description = 'GMDD Seq ID';

        }
    }


}
