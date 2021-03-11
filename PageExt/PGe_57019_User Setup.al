pageextension 57019 "Hex User Setup" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("EMail")
        {

            field("Allowed to Recognise Revenue"; "Allowed to Recognise Revenue")
            {
                Caption = 'Allowed to Recognise Revenue';
            }
            field("PO Posting Rights"; "PO Posting Rights")
            { }
            field("SO Posting Rights"; "SO Posting Rights")
            { }
            field("Change Job Status"; "Change Job Status")
            { }
        }

    }

    actions
    {
        // Add changes to page actions here
    }


}