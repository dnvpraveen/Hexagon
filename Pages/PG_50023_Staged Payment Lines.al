page 50023 "Staged Payment Lines"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staged Payment Line";

    layout
    {
        area(Content)
        {
            // repeater(GroupName)
            // {
            //     field(Name; NameSource)
            //     {
            //         ApplicationArea = All;

            //     }
            // }
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