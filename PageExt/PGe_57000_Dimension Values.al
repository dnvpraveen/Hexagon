pageextension 57000 "Hex Dimension Values" extends "Dimension Values"
{

    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(Control1)
        {
            field("Hyperion Product Code"; rec."Hyperion Product Code")
            {
                Caption = 'Hyperion Product Code';
            }
            field("Parent Dimension Code"; rec."Parent Dimension Code")
            {
                Caption = 'Parent Dimension Code';
            }
            field("Parent Code"; rec."Parent Code")
            {
                Caption = 'Parent Code';
            }
            field("Do not show"; rec."Do not show")
            {
                Caption = 'Do not show';
            }
            field("Hex seq ID"; rec."Hex seq ID")
            {
                Caption = 'Hex seq ID';
            }
            field("GMDD Seq ID"; rec."GMDD Seq ID")
            {
                Caption = 'GMDD Seq ID';
            }
        }
    }


}