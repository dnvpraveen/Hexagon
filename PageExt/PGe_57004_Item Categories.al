
pageextension 57004 "Hex Item Categories" extends "Item Categories"
{

    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(Control1)
        {
            field("Hex Status"; "Hex Status")
            {
                Caption = 'Hex Status';
            }
            field(HyperionCode; HyperionCode)
            {
                Caption = 'HyperionCode';
            }
            field(HyperionCodeDesc; HyperionCodeDesc)
            {
                Caption = 'HyperionCodeDesc';
            }
            field(Status; Status)
            {
                Caption = 'Status';
            }

        }
    }


}