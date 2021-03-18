tableextension 57044 "Hex Warehouse Journal Line" extends "Warehouse Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Sell-to Customer No."; Code[20])
        {
            Description = 'Sell-to Customer No.';
        }
        field(55003; "Sell-to Customer Name"; Text[50])
        {
            Description = 'ell-to Customer Name';
        }
        field(55004; "Original Order No."; Text[35])
        {
            Description = 'Original Order No.';
        }
        field(55005; "Smax Order No."; Text[35])
        {
            Description = 'Smax Order No.';
        }
        field(55006; "Parts Order No."; Text[30])
        {
            Description = 'Parts Order No.';
        }
    }

    var
        myInt: Integer;
}