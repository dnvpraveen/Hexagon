table 50000 "Job Order Link"
{
    DataClassification = ToBeClassified;
    //LookupPageID=Page50000;
    //DrillDownPageID=Page50000;
    fields
    {
        field(1; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        field(2; "Line No."; Integer)
        {
            Description = 'Line No.';
        }
        field(3; "Sales Doc. Type"; Option)
        {

            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(4; "Order No."; Code[20])
        {
            Description = 'Order No.';
        }
        field(5; "Invoice Doc. Type"; Option)
        {

            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(6; "Invoice No."; Code[20])
        {
            Description = 'Invoice No.';
        }
        field(7; "Purch Doc. Type"; Option)
        {

            OptionCaption = 'Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8; "Purch Order No."; Code[20])
        {
            Description = 'Purch Order No.';
        }
        field(9; "Purch Invoice Doc. Type"; Option)
        {

            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(10; "Purch Invoice No."; Code[20])
        {
            Description = 'Purch Invoice No.';
        }
    }

    keys
    {
        key(PK; "Job No.", "Line No.")
        {
            Clustered = true;
        }
        key("Sales Doc. Type"; "Order No.")
        {

        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}