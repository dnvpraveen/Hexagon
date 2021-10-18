pageextension 57045 "General Posting Setup Card" extends "General Posting Setup Card"
{
    layout
    {
        // Add changes to page layout here
        // Add changes to page layout here
        addafter("Sales Account")
        {
            field("IFRS15 Sales Account"; "IFRS15 Sales Account")
            {
                Editable = true;
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