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
        field(52001; "SFDC Active"; Option)
        {
            OptionCaption = 'In Draft,InActive,Active';
            OptionMembers = "In Draft",InActive,Active;
            Description = 'SFDC Active';
        }

    }
    var
        myInt: Integer;

    trigger OnModify()
    var
        HexInventorySmax: Codeunit HexInventorySmax;
    begin
        HexInventorySmax.HexCustomerCreditCheck(Rec);//HEXSmax1
    end;
}