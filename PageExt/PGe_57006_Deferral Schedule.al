pageextension 57006 HexDeferral extends "Deferral Schedule"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(CalculateSchedule)
        {
            trigger OnBeforeAction()
            var
                DeferralUtilities: Codeunit "Hex Deferral Utilities";
                SelectionMsg: Label 'You must specify a deferral code for this line before you can view the deferral schedule.';
                DeferralDescription: Text[50];
            begin
                IF "Deferral Code" = '' THEN BEGIN
                    MESSAGE(SelectionMsg);
                    // EXIT(FALSE);
                END;
                DeferralDescription := "Schedule Description";

                //tvt01b
                CASE "Deferral Doc. Type" OF
                    "Deferral Doc. Type"::Sales:
                        DeferralUtilities.CalculateDeferralSchedule(Rec);
                    "Deferral Doc. Type"::Purchase:
                        DeferralUtilities.CreateDeferralSchedulePurchase("Deferral Code", "Deferral Doc. Type", "Gen. Jnl. Template Name",
                        "Gen. Jnl. Batch Name", "Document Type", "Document No.", "Line No.", "Amount to Defer",
                        "Calc. Method", "Start Date", "No. of Periods", FALSE, DeferralDescription, FALSE, "Currency Code");
                END;
                //tvt01e

                Error('');
                ///  EXIT(TRUE);
            end;
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}