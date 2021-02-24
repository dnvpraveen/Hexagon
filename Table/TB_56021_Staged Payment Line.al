table 56021 "Staged Payment Line"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Staged Payment Lines";
    DrillDownPageID = "Staged Payment Lines";
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Description = 'Document No.';
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ', Purch. Order, Purch. Invoice, Sales Order, Sales Invoice';
            OptionMembers = ,"Purch. Order","Purch. Invoice","Sales Order","Sales Invoice";
        }
        field(5; "Staged Payment Line No."; Integer)
        {
            Description = 'Staged Payment Line No.';
        }
        field(10; "Due Date"; Date)
        {
            Description = 'Due Date';
        }
        field(15; "Value (Inc. VAT)"; Decimal)
        {
            Description = 'Value (Inc. VAT)';
        }
        field(100; "Total Value (Inc. VAT)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Staged Payment Line"."Value (Inc. VAT)" WHERE("Document No." = FIELD("Document No."), "Document Type" = FIELD("Document Type")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Document Type", "Staged Payment Line No.")
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