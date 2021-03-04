page 50003 "Hyperion Account"
{
    PageType = Card;
    SourceTable = "Hyperion Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Code)
                {
                }
                field(Type; Type)
                {
                }
                field("Parent Code"; "Parent Code")
                {
                }
                field(Name; Name)
                {
                }
                field("G/L Account Range"; "G/L Account Range")
                {
                }
                field("Cost Centre Range"; "Cost Centre Range")
                {
                }
            }
            // part(test; 50004)
            // {
            //     ShowFilter = false;
            //     SubPageLink = "Hyperion Account" = FIELD(Code);
            //     SubPageView = SORTING("Hyperion Account");
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Generate Details")
                {
                    Caption = 'Generate Details';
                    Image = IndentChartOfAccounts;

                    trigger OnAction()
                    var
                        lmodHexagonCubeManagement: Codeunit 50000;
                    begin
                        IF CONFIRM('Do you want re-create Hyperion Account Details?') THEN
                            lmodHexagonCubeManagement.gfncGenerateHyperionAccountMembers(Rec);
                    end;
                }
            }
        }
    }
}

