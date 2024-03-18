/// <summary>
/// PageExtension Item Card_HGN (ID 50001) extends Record Item Card.
/// </summary>
pageextension 50019 "Sales Receivables Setup_HGN" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Quote Validity Calculation")
        {
            field("SDC Enable_HGN"; rec."SDC Enable_HGN")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of SDC Enable';
            }
        }
    }
}