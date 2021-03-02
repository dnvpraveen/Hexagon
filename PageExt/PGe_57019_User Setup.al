pageextension 57019 "Hex User Setup" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Content)
        {
            field("E-Mail"; "E-Mail")
            {
                Caption = 'E-Mail';
            }
            field("Allowed to Recognise Revenue"; "Allowed to Recognise Revenue")
            {
                Caption = 'Allowed to Recognise Revenue';
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