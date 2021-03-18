tableextension 57043 "Hex Sales Price" extends "Sales Price"
{
    fields
    {
        // Add changes to table fields here
    }
    trigger OnAfterInsert()
    var
        HexInventorySmax2: Codeunit HexInventorySmax;
    begin
        HexInventorySmax2.HexPriceBook(Rec); //HEXSmax1
    end;

    trigger OnAfterModify()
    var
        HexInventorySmax2: Codeunit HexInventorySmax;
    begin
        HexInventorySmax2.HexPriceBook(Rec); //HEXSmax1
    end;

}