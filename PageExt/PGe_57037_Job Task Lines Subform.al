pageextension 57037 "Hex Job Task Lines Subform" extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Global Dimension 2 Code")
        {
            field("IFRS15 Perf. Obligation Status"; "IFRS15 Perf. Obligation Status")
            {
                // Editable = IFRS15;

                // trigger OnValidate()
                // begin
                //     CurrPage.UPDATE;
                //     SetIFRS15FieldsEditable;
                // end;
            }
            field("IFRS15 Line Amount"; "IFRS15 Line Amount")
            {
            }
            field("IFRS15 Line Amount (LCY)"; "IFRS15 Line Amount (LCY)")
            {
            }
            field("Deferral Template"; "Deferral Template")
            {
                //Editable = IFRS15Editable;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}