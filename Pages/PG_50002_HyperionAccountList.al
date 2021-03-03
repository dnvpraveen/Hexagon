page 50002 "Hyperion Account List"
{
    CardPageID = "Hyperion Account";
    Editable = false;
    PageType = List;
    SourceTable = "Hyperion Account";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                        IF CONFIRM('Do you want re-create details for all Hyperion Accounts?') THEN
                            lmodHexagonCubeManagement.gfncGenerateAllHyperionAccountMembers();
                    end;
                }
            }
        }
    }
}

