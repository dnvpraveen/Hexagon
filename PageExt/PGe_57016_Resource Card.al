pageextension 57016 "Hex Resource Card" extends "Resource Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Time Sheet Approver User ID")
        {
            field("Item Category Code"; "Item Category Code")
            { }
            field(HexCPQ; HexCPQ)
            { }
            field(ERPCompanyNumber; ERPCompanyNumber)
            {
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