tableextension 57027 "Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Original Quantity"; Decimal)
        {

            Description = 'Original Quantity';

            DecimalPlaces = 0 : 5;

            Editable = false;
        }
        field(50001; "Original Unit Cost (LCY)"; Decimal)
        {
            Description = 'Original Unit Cost (LCY)';

            Editable = false;
            AutoFormatType = 1;
        }
        field(50002; "Original Total Cost (LCY)"; Decimal)
        {
            Description = 'Original Total Cost (LCY)';

            Editable = false;
        }
        field(50003; "Original Unit Cost"; Decimal)
        {
            Description = 'Original Unit Cost';
        }
        field(50004; "Original Total Cost"; Decimal)
        {
            Description = 'Original Total Cost';
        }
        field(50005; "Original Purchase Unit Cost"; Decimal)
        {
            Description = 'Original Purchase Unit Cost';
        }
        field(50100; "IFRS15 Line Amount"; Decimal)
        {
            Description = 'IFRS15 Line Amount';
            AutoFormatType = 2;
            trigger OnValidate()
            var
                HexSmaxCur: Codeunit "Hex Smax Stage Ext";
            begin
                HexSmaxCur.UpdateTotalRevenueLCY(Rec);
            end;
        }
        field(50101; "IFRS15 Perf. Obligation Status"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Task"."IFRS15 Perf. Obligation Status" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No.")));
            Description = 'IFRS15 Perf. Obligation Status';
            OptionCaption = ' ,Calculated,Ready to Post,Posted';
            OptionMembers = ,Calculated,"Ready to Post",Posted;
            Editable = false;
        }
        field(50105; "IFRS15 Line Amount (LCY)"; Decimal)
        {
            Description = 'IFRS15 Line Amount (LCY)';

            AutoFormatType = 2;
        }
        field(50106; "Original IFRS15 Line Amount"; Decimal)
        {
            Description = 'Original IFRS15 Line Amount';

            Editable = false;
            AutoFormatType = 2;
        }
        field(50107; "Original IFRS15 Line Amt (LCY)"; Decimal)
        {
            Description = 'Original IFRS15 Line Amt (LCY)';

            Editable = false;
            AutoFormatType = 2;
        }
        field(54000; "Purchase Inv No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."Document No." WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Planning Line No." = FIELD("Line No.")));
            Description = 'Purchase Inv No.';
        }
        field(54001; "Purchase Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line".Amount WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Planning Line No." = FIELD("Line No.")));
            Description = 'Purchase Value';
        }
        field(54002; "Purch Posting Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."Posting Date" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Planning Line No." = FIELD("Line No.")));
            Description = 'Purch Posting Date';
        }
        field(54003; "Sale Inv No."; Code[20])
        {
            Description = 'Sale Inv No.';
        }
        field(54004; "Sale Amount"; Decimal)
        {
            Description = 'Sale Amount';
        }
        field(54005; "Sale Posting Date"; Date)
        {
            Description = 'Sale Posting Date';
        }
        field(55000; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
            Editable = true;
        }
        field(55002; "Opportunity No."; Code[10])
        {
            Description = 'Opportunity No.';
            Editable = true;
        }
        field(55003; "Activity Type"; Option)
        {
            OptionCaption = ' ,Purchase,Installation,Training,Programming,Warranty';
            OptionMembers = ,Purchase,Installation,Training,Programming,Warranty;
            Editable = true;
        }
        field(55004; IP; Boolean)
        {
            Description = 'IP';
        }
        field(55005; "Order Type"; Code[2])
        {
            Description = 'Order Type';
            Editable = true;
        }
        field(55006; "IP Serial No."; Code[20])
        {
            Description = 'IP Serial No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."Serial No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
        }
        field(55007; "Target System"; Code[10])
        {
            Description = 'Target System';
        }
        field(55008; "Smax Order No."; Text[35])
        {
            Description = 'Smax Order No.';
        }
        field(55009; "Smax Order for IP"; Text[35])
        {
            Description = 'Smax Order for IP';
        }
        field(55010; "Smax Line No"; Text[30])
        {
            Description = 'Smax Line No';
        }
        field(55011; "IP Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
            Description = 'IP Code';
        }
        field(55012; "BOM Component"; Boolean)
        {
            Description = 'BOM Component';
        }
        field(55013; "Warranty Start Date"; Date)
        {
            Description = 'Warranty Start Date';
        }
        field(55014; "Warranty End Date"; Date)
        {
            Description = 'Warranty End Date';
        }
        field(55050; "Completed %"; Decimal)
        {
            Description = 'Completed %';
        }
        field(55051; Modified; Boolean)
        {
            Description = 'Modified';
        }
        field(55052; Created; Boolean)
        {
            Description = 'Created';
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                job: Record Job;
                jobtask: Record "Job Task";
                cust: Record Customer;
            begin
                Job.GET("Job No.");
                //GetJob;
                "Customer Price Group" := Job."Customer Price Group";
                //gk Smax1.0
                if cust.get(job."Bill-to Customer No.") then
                    "Gen. Bus. Posting Group" := cust."Gen. Bus. Posting Group";

                "ERP Company No." := Job."ERP Company No.";
                "Opportunity No." := Job."Opportunity No.";
                JobTask.GET("Job No.", "Job Task No.");
                "Activity Type" := JobTask."Activity Type";
                "Order Type" := JobTask."Order Type";
                IF ((Type <> Type::Item) AND (JobTask."Activity Type" = JobTask."Activity Type"::Purchase)) THEN
                    ERROR('Type should be Item for Activity Type Purchase');
                IF ((Type = Type::Item) AND (JobTask."Activity Type" <> JobTask."Activity Type"::Purchase)) THEN
                    ERROR('Type should be Resource for Activity Type NOT Purchase');
                //gk Smax1.0
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                VALIDATE("Qty. to Transfer to Journal", 0); //gk
            end;
        }
        modify("Qty. Posted")
        {
            trigger OnAfterValidate()
            begin
                If "Qty. Posted" <> 0 then
                    "Completed %" := ("Qty. Posted" / "Quantity (Base)") * 100;
            end;
        }
    }

    trigger OnModify()
    begin
        //gk
        //TESTFIELD(Status,Status::Planning);
        Modified := TRUE;
        //gk
    end;

}