tableextension 57016 "Hex Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        //Description=IFRS15
        field(54000; "Job Planning Line No."; Integer)
        {
            Description = 'Job Planning Line No.';

        }
    }

    PROCEDURE InitFromPurchLine@12(PurchInvHeader@1001 : Record 122; PurchLine@1002 : Record 39);
    BEGIN
        INIT;
        TRANSFERFIELDS(PurchLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account" .. Type::"Charge (Item)"]) THEN
            Type := Type::" ";
        "Posting Date" := PurchInvHeader."Posting Date";
        "Document No." := PurchInvHeader."No.";
        Quantity := PurchLine."Qty. to Invoice";
        "Quantity (Base)" := PurchLine."Qty. to Invoice (Base)";
        //gk
        "Job Planning Line No." := PurchLine."Job Planning Line No.";
        //gk
    END;

}