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
    }


}