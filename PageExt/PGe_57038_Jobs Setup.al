pageextension 57038 "Hex Jobs Setup" extends "Jobs Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Logo Position on Documents")
        {
            field("Dimension for Sales Link"; "Dimension for Sales Link")
            { }
            field("Auto Consume"; "Auto Consume")
            { }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}