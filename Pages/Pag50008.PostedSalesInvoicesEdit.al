page 50086 PostedSalesInvoicesEdit
{
    ApplicationArea = All;
    Caption = 'Posted Sales Invoice Edit';
    PageType = List;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;
    Editable = true;
    Permissions = tabledata "Sales Invoice Header" = rm;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                }
                field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to E-Mail field.';
                }
                field("Fiscal Invoice Number PAC"; Rec."Fiscal Invoice Number PAC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fiscal Invoice Number PAC field.';
                    Editable = true;
                }
            }
        }
    }
}
