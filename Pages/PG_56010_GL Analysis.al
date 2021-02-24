

page 56010 "GL Analysis"
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

                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = All;
                }
                field("Amount"; "Amount")
                {
                    ApplicationArea = All;
                }

                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1"; "Dimension 1")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1 Name"; "Dimension 1 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2"; "Dimension 2")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Name"; "Dimension 2 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 3"; "Dimension 3")
                {
                    ApplicationArea = All;
                }
                field("Dimension 3 Name"; "Dimension 3 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 4"; "Dimension 4")
                {
                    ApplicationArea = All;
                }
                field("Dimension 4 Name"; "Dimension 4 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 5"; "Dimension 5")
                {
                    ApplicationArea = All;
                }
                field("Dimension 5 Name"; "Dimension 5 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 6"; "Dimension 6")
                {
                    ApplicationArea = All;
                }
                field("Dimension 6 Name"; "Dimension 6 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 7"; "Dimension 7")
                {
                    ApplicationArea = All;
                }
                field("Dimension 7 Name"; "Dimension 7 Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension 8"; "Dimension 8")
                {
                    ApplicationArea = All;
                }
                field("Dimension 8 Name"; "Dimension 8 Name")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
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

