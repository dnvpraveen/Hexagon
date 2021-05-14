pageextension 57008 "Hex Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Our Account No."; "Our Account No.")
            {
                Caption = 'SFDC ID';
                Editable = false;
            }
            field("SFDC Active"; "SFDC Active")
            {
                Caption = 'SFDC Active';
                Editable = false;
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