page 50100 "IFRS15 Setup"
{
    // TM TF IFRS15 28/06/18 'IFRS15 Services'
    //   Object created

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "IFRS15 Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("IFRS15 Active"; "IFRS15 Active")
                {
                }
                field("Revenue Recognition Account"; "Revenue Recognition Account")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Recognise Revenue Confirm. Msg"; "Recognise Revenue Confirm. Msg")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;
}

