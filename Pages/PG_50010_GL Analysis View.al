page 50010 "Page 50010 GL Analysis View"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GL Analysis";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; "Entry No")
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