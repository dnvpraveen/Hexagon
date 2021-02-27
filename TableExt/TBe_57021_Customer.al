tableextension 57021 "Hex Customer" extends Customer
{
    fields
    {
        //Customer integration
        field(50001; "PO Box"; Text[50])
        {
            // Add changes to table fields here
            Description = 'PO Box';
        }
    }
    var
        myInt: Integer;

    trigger OnInsert()
    var
        HexInventorySmax: Codeunit HexInventorySmax;
    begin
        HexInventorySmax.HexCustomerCreditCheck(Rec);//HEXSmax1
    end;
}