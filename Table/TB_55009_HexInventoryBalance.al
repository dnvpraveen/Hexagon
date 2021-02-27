table 55009 HexInventoryBalance
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Entry No."; Integer)
        {
            AutoIncrement = false;
            Description = 'Entry No.';
        }
        field(50001; ERPCompanyNo; Code[10]) { }
        field(50002; "Item No."; Code[20]) { Description = 'Item No.'; }
        field(50003; "Posting Date"; Date) { Description = 'Posting Date'; }
        field(50004; "Entry Type"; Option)
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output,,"Assembly Consumption","Assembly Output";
        }
        field(50005; "Source No."; Code[20])
        {
            Description = 'Source No.';
        }
        field(50006; "Document No."; Code[20])
        {
            Description = 'Document No.';
        }
        field(50007; Description; Text[50])
        {
            Description = 'Description';
        }
        field(50008; "Location Code"; Code[10])
        {
            Description = 'Location Code';
        }
        field(50009; Quantity; Decimal)
        {
            Description = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(50010; "External Document No."; Code[35])
        {
            Description = 'External Document No.';
        }
        field(50011; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }
        field(50012; "Lot No."; Code[20])
        {
            Description = 'Lot No.';
        }
        field(50013; "Bin Code"; Code[20])
        {
            Description = 'Bin Code';
            NotBlank = true;
        }
        field(50014; Status; Option)
        {
            OptionMembers = New,Pending,Failure,Success;
            OptionCaption = 'New,Pending,Failure,Success';
        }
        field(50015; Message; Text[250])
        {
            Description = 'Message';
        }
        field(50016; ModifyDate; DateTime)
        {
            Description = 'ModifyDate';
        }
        field(50017; TargetSystem; Code[10])
        {
            Description = 'TargetSystem';
        }
    }

    keys
    {
        key(PK; "Entry No.", ERPCompanyNo)
        {
            Clustered = true;
        }
    }

    var
        IsNotOnInventoryErr: TextConst ENU = 'You have insufficient quantity of Item %1 on inventory.;';

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
