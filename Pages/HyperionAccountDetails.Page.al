page 50004 "Hyperion Account Details"
{
    PageType = List;
    SourceTable = "Hyperion Account Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hyperion Account"; "Hyperion Account")
                {
                    Visible = false;
                }
                field("G/L Account"; "G/L Account")
                {
                }
                field("Cost Centre"; "Cost Centre")
                {
                }
            }
        }
    }

    actions
    {
    }
}

