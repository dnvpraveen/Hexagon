table 56053 HexCustomerCreditCheck
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "Entry No."; Integer)
        {
            AutoIncrement = false;
            Description = 'Entry No.';
        }
        field(50002; "ERPCompanyNo"; Code[10])
        {
            Description = 'ERPCompanyNo';
        }
        field(50003; "No."; Code[20])
        {
            Description = 'No.';
        }
        field(50004; "Our Account No."; Text[20])
        {
            Description = 'Our Account No.';
        }
        field(50005; "Credit Limit (LCY)"; Decimal)
        {
            Description = 'Credit Limit (LCY)';

            AutoFormatType = 1;
        }
        field(50008; Blocked; Option)
        {
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = ,Ship,Invoice,All;
        }
        field(50009; Status; Option)
        {
            OptionMembers = New,Pending,Failure,Success;
            OptionCaption = 'New,Pending,Failure,Success';
        }
        field(50011; Created; Code[10])
        {
            Description = 'Created';
        }
        field(50012; "User ID"; Code[50])
        {
            TableRelation = User."User Name";

            Description = 'User ID';
        }
        field(50013; Message; Text[250])
        {
            Description = 'Message';
        }
        field(50018; ModifyDate; DateTime)
        {
            Description = 'ModifyDate';
        }
        field(50019; Name; Text[50])
        {
            Description = 'Name';
        }
        field(50020; "Name 2"; Text[50])
        {
            Description = 'Name 2';
        }
        field(50021; "Currency Code"; Code[10])
        {
            Description = 'Currency Code';
        }
        field(50022; CustomerOverDue; Boolean)
        {
            Description = 'CustomerOverDue';
        }
        field(50023; BypassCreditCheck; Boolean)
        {
            Description = 'BypassCreditCheck';
        }
        field(50024; TargetSystem; Code[10])
        {
            Description = 'TargetSystem';
        }
        field(50025; CustomerAvailableCredit; Decimal)
        {
            Description = 'CustomerAvailableCredit';
        }
    }

    keys
    {
        key(PK; "Entry No.", ERPCompanyNo)
        {
            Clustered = true;
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