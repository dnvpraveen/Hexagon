pageextension 57029 "Hex Job Task Lines" extends "Job Task Lines"
{
    layout
    {
        // Add changes to page layout here dnv
        addlast(Content)
        {
            field("Performance Obligation"; "Performance Obligation")
            {
                Caption = 'Performance Obligation';
            }
            field("Activity Type"; "Activity Type")
            {
                Caption = 'Activity Type';
            }
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
                Caption = 'IFRS15 Line Amount';
            }
            field("IFRS15 Line Amount (LCY)"; "IFRS15 Line Amount (LCY)")
            {
                Caption = 'IFRS15 Line Amount (LCY)';
            }
            field("Deferral Template"; "Deferral Template")
            {
                Editable = IFRS15Editable;
                Caption = 'Deferral Template';
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        IFRS15Editable: Boolean;


    LOCAL PROCEDURE SetIFRS15FieldsEditable();
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        IFRS15Editable := FALSE;
        IF ("Job Task Type" = "Job Task Type"::Posting) AND ("IFRS15 Perf. Obligation Status" <> "IFRS15 Perf. Obligation Status"::Posted) THEN
            IFRS15Editable := TRUE;
        // TM TF IFRS15 02/07/18 End
    END;
}