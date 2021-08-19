tableextension 57033 "Hex Transfer Line" extends "Transfer Line"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';
        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55002; "Line Status"; Option)
        {
            Description = 'Line Status';
            OptionMembers = " ",Open,Shipped,"Partially shipped",Completed;
            OptionCaption = '" ",Open,Shipped,"Partially shipped",Completed';
        }
        field(55004; "Order Inserted"; Boolean)
        {

            Description = 'Order Inserted';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }

    }


    trigger OnInsert()
    var
        TransLine2: Record "Transfer Line";
        TransHeader: Record "transfer header";
    begin
        TransLine2.RESET;
        TransLine2.SETFILTER("Document No.", "Document No.");
        IF TransLine2.FINDLAST THEN
            "Line No." := TransLine2."Line No." + 1
        else
            "Line No." := 1;
    end;
}