page 56004 "Hyperion Account Members"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hyperion Account Members";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = All;

                }
                field("Cost Centre"; "Cost Centre")
                {
                    ApplicationArea = All;
                }
                field("Hyperion Account"; "Hyperion Account")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}