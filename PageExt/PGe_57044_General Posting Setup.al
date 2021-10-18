pageextension 57044 "General Posting Setup" extends "General Posting Setup"
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