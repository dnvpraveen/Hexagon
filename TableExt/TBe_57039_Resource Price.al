tableextension 57039 "Hex Resource Price" extends "Resource Price"
{
    fields
    {
        // Add changes to table fields here
    }
    trigger OnAfterInsert()
    var
        HexInventorySmax2: Codeunit HexInventorySmax;
    begin
        HexInventorySmax2.HexRsPriceBook(Rec); //HEXSmax1
    end;

    trigger OnAfterModify()
    var
        HexInventorySmax2: Codeunit HexInventorySmax;
    begin
        HexInventorySmax2.HexRsPriceBook(Rec); //HEXSmax1
    end;
}