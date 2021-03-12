pageextension 57037 "Hex Job Task Lines Subform" extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Global Dimension 2 Code")
        {
            field("IFRS15 Perf. Obligation Status"; "IFRS15 Perf. Obligation Status")
            {
                Editable = IFRS15Editable;

                trigger OnValidate()
                begin
                    CurrPage.UPDATE;
                    SetIFRS15FieldsEditable;
                end;
            }
            field("IFRS15 Line Amount"; "IFRS15 Line Amount")
            {
            }
            field("IFRS15 Line Amount (LCY)"; "IFRS15 Line Amount (LCY)")
            {
            }
            field("Deferral Template"; "Deferral Template")
            {
                Editable = IFRS15Editable;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Change &Dates")
        {

            action(ApportionRevenue)
            {


                trigger OnAction();
                VAR
                    IFRS15Mgt: Codeunit "IFRS15 Mgt";
                begin
                    // TM TF IFRS15 02/07/18 Start
                    IFRS15Mgt.ApportionRevenue(Rec);
                    // TM TF IFRS15 02/07/18 End
                end;
            }
            action(PreviewTask)
            {
                trigger OnAction();
                VAR
                    IFRS15MgtRev: Codeunit 50013;
                BEGIN
                    IF ("IFRS15 Perf. Obligation Status" = "IFRS15 Perf. Obligation Status"::"Ready to Post") THEN
                        IFRS15MgtRev.CreateGeneralJnlLineJobTask(Rec);
                END;
            }

        }


    }
    VAR
        JobTaskLines: Page "Job Task Lines";
        DescriptionIndent: Integer;// INDATASET;
        StyleIsStrong: Boolean;// INDATASET;
        IFRS15Editable: Boolean;// INDATASET;

    LOCAL PROCEDURE SetIFRS15FieldsEditable();
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        IFRS15Editable := FALSE;
        IF ("Job Task Type" = "Job Task Type"::Posting) AND ("IFRS15 Perf. Obligation Status" <> "IFRS15 Perf. Obligation Status"::Posted) THEN
            IFRS15Editable := TRUE;
        // TM TF IFRS15 02/07/18 End
    END;


    trigger OnOpenPage()
    BEGIN
        SetIFRS15FieldsEditable; // TM TF IFRS15 02/07/18
    END;

    trigger OnAfterGetRecord()
    BEGIN
        DescriptionIndent := Indentation;
        StyleIsStrong := "Job Task Type" <> "Job Task Type"::Posting;
        SetIFRS15FieldsEditable; // TM TF IFRS15 02/07/18
    END;

}