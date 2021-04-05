pageextension 57039 "Hex CountryRegion" extends "Countries/Regions"
{
    layout
    {
        // Add changes to page layout here
        addafter("Contact Address Format")
        {
            field("HEX Country Code"; "HEX Country Code")
            {
                Caption = 'HEX Country Code';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}