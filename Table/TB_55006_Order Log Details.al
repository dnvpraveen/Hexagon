table 55006 "Order Log Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Description = 'Entry No.';
        }
        field(2; "Order Type"; Code[2])
        {
            Description = 'Order Type';
        }
        field(3; "Order Action Code"; Integer)
        {
            Description = 'Order Action Code';
        }
        field(4; "Document Type"; Text[30])
        {
            Description = 'Document Type';
        }
        field(5; "NAV Order No."; Text[35])
        {
            Description = 'NAV Order No.';
        }
        field(6; "Smax Order No."; Text[30])
        {
            Description = 'Smax Order No.';
        }
        field(7; "External Doc No."; Text[35])
        {
            Description = 'External Doc No.';
        }
        field(8; "NAV Invoice No."; Text[30])
        {
            Description = 'NAV Invoice No.';
        }
        field(9; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';
        }
        field(10; "NAV Line No."; Integer)
        {
            Description = 'NAV Line No.';
        }
        field(11; "Target System"; Text[30])
        {
            Description = 'Target System';
        }
        field(12; Quantity; Decimal)
        {
            Description = 'Quantity';
        }
        field(13; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
        }
        field(14; "Integration Status"; Option)
        {
            OptionCaptionML = ENU = ' ,InProgress,Successful,Failure';
            OptionMembers = ,InProgress,Successful,Failure;
        }
        field(15; "Response Status"; Option)
        {
            OptionCaptionML = ENU = ' ,Created,Modified,Processed,UpdatedtoSmax';
            OptionMembers = ,Created,Modified,Processed,UpdatedtoSmax;
        }
        field(16; "Integration Completed"; Boolean)
        {
            Description = 'Integration Completed';
        }
        field(17; Message; Text[250])
        {
            Description = 'Message';
        }
        field(18; "Sell-to Customer No."; Code[20])
        {
            Description = 'Sell-to Customer No.';
        }
        field(19; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }
        field(20; "Line Action Code"; Integer)
        {
            Description = 'Line Action Code';
        }
        field(21; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(22; "Invoice Create"; Boolean)
        {
            Description = 'Invoice Create';
        }
        field(23; "Smax Work order"; Text[30])
        {
            Description = 'Smax Work order';
        }
        field(24; "Item No."; Code[20])
        {
            Description = 'Item No.';
        }
        field(25; IP; Boolean)
        {
            Description = 'IP';
        }
        field(26; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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