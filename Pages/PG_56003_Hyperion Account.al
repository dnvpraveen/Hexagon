page 56003 "Hyperion Account"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hyperion Account";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;

                }
                field("Type"; "Type")
                {
                    ApplicationArea = All;
                }
                field("Parent Code"; "Parent Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("G/L Account Range"; "G/L Account Range")
                {
                    ApplicationArea = All;
                }
                field("Cost Centre Range"; "Cost Centre Range")
                {
                    ApplicationArea = All;
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