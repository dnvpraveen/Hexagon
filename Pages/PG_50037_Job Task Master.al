page 50037 "Job Task Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Task Master_New";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Task Code"; "Job Task Code")
                {
                }
                field("Performance Obligation"; "Performance Obligation")
                {
                }
                field("Order Type"; "Order Type")
                {
                }
                field("Activity Type"; "Activity Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

