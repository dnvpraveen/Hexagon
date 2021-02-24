pageextension 57000 "Hex Dimension" extends "Dimension Values"
{

    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(Control1)
        {
            field("Hyperion Product Code"; "Hyperion Product Code")
            {
                Caption = 'Hyperion Product Code';
            }
            field("Parent Dimension Code"; "Parent Dimension Code")
            {
                Caption = 'Parent Dimension Code';
            }
            field("Parent Code"; "Parent Code")
            {
                Caption = 'Parent Code';
            }
            field("Do not show"; "Do not show")
            {
                Caption = 'Do not show';
            }
            field("Hex seq ID"; "Hex seq ID")
            {
                Caption = 'Hex seq ID';
            }
            field("GMDD Seq ID"; "GMDD Seq ID")
            {
                Caption = 'GMDD Seq ID';
            }
        }
    }


}