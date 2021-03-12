pageextension 57001 "Hex G/L Account Card" extends "G/L Account Card"
{

    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(General)
        {
            field("GMDD Name"; "GMDD Name")
            {
                Caption = 'GMDD Name';

            }
            field(HexSeqID; HexSeqID)
            {
                Caption = 'HexSeqID';
            }
        }


    }
}