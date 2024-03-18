pageextension 57022 "Hex Posted Sales Shpt. Subform" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        //         // Add changes to page layout here
        addafter("Quantity")
        {
            field("Doc. Line Discount %_HGN"; Rec."Doc. Line Discount %_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Line Discount %';
                Caption = 'Doc. Line Discount %';
                ApplicationArea = All;
            }
            field("Doc. Line Amount_HGN"; Rec."Doc. Line Amount_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Line Amount';
                Caption = 'Doc. Line Amount';
                ApplicationArea = All;
            }
            field("Doc. Unit Price_HGN"; rec."Doc. Unit Price_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Unit Price';
                Caption = 'Doc. Unit Price';
                ApplicationArea = All;
            }
        }
    }

    //     actions
    //     {
    //         // Add changes to page actions here
    //     }

    //     var
    //         myInt: Integer;
}