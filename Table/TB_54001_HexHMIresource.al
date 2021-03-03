table 54001 HexHMIresource
{

    fields
    {
        field(50001; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(50002; HexItemNo; Code[20])
        {
        }
        field(50003; HexDescription; Text[50])
        {
            Caption = 'HexDescription';
        }
        field(50004; HexReplenishmentSystem; Code[10])
        {
        }
        field(50005; HexItemCategoryCode; Code[10])
        {
        }
        field(50006; HexServicePart; Code[10])
        {
        }
        field(50007; HexBaseUnitofMeasure; Code[10])
        {
        }
        field(50008; HexProductLifecycle; Code[10])
        {
        }
        field(50009; HexFacility; Code[10])
        {
        }
        field(50010; HexECCN; Code[10])
        {
        }
        field(50011; HexImpExpF; Code[10])
        {
        }
        field(50012; HexImpExpS; Code[10])
        {
        }
        field(50013; HexRevision; Code[10])
        {
        }
        field(50014; HexNetWeight; Code[10])
        {
        }
        field(50015; HexCPQ; Text[10])
        {
        }
        field(50017; ERPCompanyNo; Code[10])
        {
        }
        field(50018; TargetSystem; Text[5])
        {
        }
        field(50019; Status; Option)
        {
            OptionMembers = New,Pending,Failure,Success;
        }
        field(50020; ErrorMsg; Text[250])
        {
        }
        field(50021; "Action"; Text[10])
        {
        }
        field(50022; ModifyDate; DateTime)
        {
            Caption = 'ModifyDate';
        }
        field(50023; HexLotControlled; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.", ERPCompanyNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ModifyDate := CURRENTDATETIME;
    end;

    trigger OnModify()
    begin
        ModifyDate := CURRENTDATETIME;
    end;
}

