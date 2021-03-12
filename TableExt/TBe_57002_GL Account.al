tableextension 57002 "Hex GL GMDD" extends "G/L Account"
{
    fields
    {
        field(50001; "GMDD Name"; Text[50])
        {
            //DataClassification = ToBeClassified;
            Description = 'GMDD Name';

        }
        field(50002; "HexSeqID"; Integer)
        {
            //DataClassification = ToBeClassified;
            Description = 'HexSeqID';

        }
    }


}