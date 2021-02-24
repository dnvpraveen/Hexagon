tableextension 57014 "Hex Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        //Description=IFRS15
        field(54000; "Job Planning Line No."; Integer)
        {
            Description = 'Job Planning Line No.';

        }

    }

    //   PROCEDURE InitFromPurchLine@12(PurchRcptHeader@1001 : Record 120;PurchLine@1002 : Record 39);
    //     VAR
    //       Factor@1000 : Decimal;
    //     BEGIN
    //       INIT;
    //       TRANSFERFIELDS(PurchLine);
    //       IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
    //         Type := Type::" ";
    //       "Posting Date" := PurchRcptHeader."Posting Date";
    //       "Document No." := PurchRcptHeader."No.";
    //       Quantity := PurchLine."Qty. to Receive";
    //       "Quantity (Base)" := PurchLine."Qty. to Receive (Base)";
    //       IF ABS(PurchLine."Qty. to Invoice") > ABS(PurchLine."Qty. to Receive") THEN BEGIN
    //         "Quantity Invoiced" := PurchLine."Qty. to Receive";
    //         "Qty. Invoiced (Base)" := PurchLine."Qty. to Receive (Base)";
    //       END ELSE BEGIN
    //         "Quantity Invoiced" := PurchLine."Qty. to Invoice";
    //         "Qty. Invoiced (Base)" := PurchLine."Qty. to Invoice (Base)";
    //       END;
    //       "Qty. Rcd. Not Invoiced" := Quantity - "Quantity Invoiced";
    //       IF PurchLine."Document Type" = PurchLine."Document Type"::Order THEN BEGIN
    //         "Order No." := PurchLine."Document No.";
    //         "Order Line No." := PurchLine."Line No.";
    //       END;
    //       //gk
    //       "Job Planning Line No." := PurchLine."Job Planning Line No.";
    //       //gk
    //       IF (PurchLine.Quantity <> 0) AND ("Job No." <> '') THEN BEGIN
    //         Factor := PurchLine."Qty. to Receive" / PurchLine.Quantity;
    //         IF Factor <> 1 THEN
    //           UpdateJobPrices(Factor);
    //       END;
    //     END;


}