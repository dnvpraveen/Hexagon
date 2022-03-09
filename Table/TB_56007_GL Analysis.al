table 56007 "GL Analysis"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Entry No';
        }
        field(2; "G/L Account No."; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'G/L Account No.';

        }
        field(3; "Document Type"; Option)
        {
            //DataClassification = ToBeClassified;
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaptionML = ENU = '" ",Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund';
            Description = '"Document Type';

        }
        field(4; "Document No."; code[20])
        {
            description = 'Document No.';
        }
        field(5; "Posting date"; date)
        {
            description = 'Posting Date';
        }
        field(6; "Amount"; decimal)
        {
            description = 'Amount';
        }

        field(7; "Description"; Text[100])
        {
            description = 'Description';
        }
        field(8; "Dimension 1"; Code[20])
        {
            description = 'Dimension 1';
        }
        field(9; "Dimension 1 Name"; Text[50])
        {
            description = 'Dimension 1 Name';
        }
        field(10; "Dimension 2"; Code[20])
        {
            description = 'Dimension 2';
        }
        field(11; "Dimension 2 Name"; Text[50])
        {
            description = 'Dimension 2 Name';
        }
        field(12; "Dimension 3"; Code[20])
        {
            description = 'Dimension 3';
        }
        field(13; "Dimension 3 Name"; Text[50])
        {
            description = 'Dimension 3 Name';
        }
        field(14; "Dimension 4"; Code[20])
        {
            description = 'Dimension 4';
        }
        field(15; "Dimension 4 Name"; Text[50])
        {
            description = 'Dimension 4 Name';
        }
        field(16; "Dimension 5"; Code[20])
        {
            description = 'Dimension 5';
        }
        field(17; "Dimension 5 Name"; Text[50])
        {
            description = 'Dimension 5 Name';
        }
        field(18; "Dimension 6"; Code[20])
        {
            description = 'Dimension 6';
        }
        field(19; "Dimension 6 Name"; Text[50])
        {
            description = 'Dimension 6 Name';
        }
        field(20; "Dimension 7"; Code[20])
        {
            description = 'Dimension 7';
        }
        field(21; "Dimension 7 Name"; Text[50])
        {
            description = 'Dimension 7 Name';
        }
        field(22; "Dimension 8"; Code[20])
        {
            description = 'Dimension 8';
        }
        field(23; "Dimension 8 Name"; Text[50])
        {
            description = 'Dimension 8 Name';
        }
        field(24; "External Document No."; Code[35])
        {
            description = 'External Document No.';
        }
        field(25; "Source Code"; Code[10])
        {
            description = 'Source Code';
        }
        field(26; "Source No."; Code[20])
        {
            description = 'Source No.';
        }
        field(27; "G/L Account Name"; Text[50])
        {
            description = 'G/L Account Name';
        }
        field(28; "User ID"; Code[50])
        {
            description = 'User ID';
        }
        field(29; "Gen. Posting Type"; Option)
        {

            OptionMembers = " ",Purchase,Sale,Settlement;
            OptionCaptionML = ENU = '" ",Purchase,Sale,Settlement';
            description = 'Gen. Posting Type';
        }
        field(30; "Gen. Bus. Posting Group"; Code[10])
        {
            description = 'Gen. Bus. Posting Group';
        }
        field(31; "Gen. Prod. Posting Group"; Code[10])
        {
            description = 'Gen. Prod. Posting Group';
        }
        field(32; "VAT Bus. Posting Group"; Code[10])
        {
            description = 'VAT Bus. Posting Group';
        }
        field(33; "VAT Prod. Posting Group"; Code[10])
        {
            description = 'VAT Prod. Posting Group';
        }

    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    var

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
