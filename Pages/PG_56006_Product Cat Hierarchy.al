
page 56006 "Product Cat Hierarchy"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Product Cat Hierarchy";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Product Cat ID"; "Product Cat ID")
                {
                    ApplicationArea = All;

                }
                field("Parent Product Cat ID"; "Parent Product Cat ID")
                {
                    ApplicationArea = All;
                }
                field(name; name)
                {
                    ApplicationArea = All;
                }
                field("Type"; "Type")
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