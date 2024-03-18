pageextension 57013 "Hex Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
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
            field("Doc. Qty_HGN"; rec."Doc. Qty_HGN")
            {
                ToolTip = 'Specifies the value of Doc. Qty';
                Caption = 'Doc. Qty_HGN';
                ApplicationArea = All;
            }
            field("Doc. VAT %_HGN"; rec."Doc. VAT %_HGN")
            {
                ToolTip = 'Specifies the value of Doc. VAT %';
                Caption = 'Doc. VAT %_HGN';
                ApplicationArea = All;
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