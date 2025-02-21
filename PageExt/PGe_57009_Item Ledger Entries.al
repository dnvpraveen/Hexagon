pageextension 57009 "Hex Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Location Code")
        {
            field("Bin Code"; WarehouseEnty."Bin Code")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        Clear(WarehouseEnty);
        WarehouseEnty.SetRange("Source No.", rec."Document No.");
        WarehouseEnty.SetRange("Item No.", rec."Item No.");
        if WarehouseEnty.FindLast() then;
    end;

    var
        WarehouseEnty: Record "Warehouse Entry";
}