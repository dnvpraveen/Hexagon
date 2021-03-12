pageextension 57002 "Hex G/L Account List" extends "G/L Account List"
{

    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(Control1)
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