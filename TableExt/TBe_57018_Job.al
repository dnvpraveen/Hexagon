tableextension 57018 "Hex Job" extends Job
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            Description = 'Salesperson Code';
        }

        field(50001; "Hex Recog. Sales Amount"; Decimal)
        {
            Description = 'Hex Recog. Sales Amount';
        }
        field(50002; "Hex Recog. Sales G/L Amount"; Decimal)
        {
            Description = 'Hex Recog. Sales G/L Amount';
        }
        field(50003; "Hex WIP Total Sale Amount"; Decimal)
        {
            Description = 'Hex WIP Total Sale Amount';
        }
        field(50004; "Hex WIP Total Sales G/L Amount"; Decimal)
        {

            Description = 'Hex WIP Total Sales G/L Amount';
        }
        field(50005; "Hex Project Status"; Option)
        {
            OptionCaption = 'WIP,Closed,Archived';
            OptionMembers = WIP,Closed,Archived;
            Description = 'Hex Project Status';
        }

        field(50100; "Is IFRS15 Job"; Boolean)
        {
            Description = 'Is IFRS15 Job';
        }
        field(50101; "Total Revenue to Recognize"; Decimal)
        {
            Description = 'Total Revenue to Recognize';
            AutoFormatType = 1;
        }
        field(50102; "Total Rev to Recognize (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."IFRS15 Line Amount (LCY)" WHERE("Job No." = FIELD("No.")));
            Description = 'Total Rev to Recognize (LCY)';
            Editable = False;
            AutoFormatType = 1;
        }
        field(50103; "Currency Factor"; Decimal)
        {
            Description = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
        }
        field(55000; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }
        field(55001; "Product Serial No."; Code[20])
        {
            Description = 'Product Serial No.';
        }
        field(55002; "Opportunity No."; Code[20])
        {
            Description = 'Opportunity No.';
            trigger OnValidate()
            var
                GJobPlanningLine: Record "Job Planning Line";
            BEGIN
                GJobPlanningLine.RESET;
                GJobPlanningLine.SETRANGE("Job No.", "No.");
                IF GJobPlanningLine.FINDSET THEN BEGIN
                    REPEAT
                        GJobPlanningLine."Opportunity No." := "Opportunity No.";
                        GJobPlanningLine.MODIFY;
                    UNTIL GJobPlanningLine.NEXT = 0;
                END;
            END;

        }

        field(55003; "External Doc No."; Text[35])
        {
            Description = 'External Doc No.';
        }
        field(55004; "Order Type"; Option)
        {
            OptionCaption = ' ,System,Retrofit,Upgrade';
            OptionMembers = ,System,Retrofit,Upgrade;
            Description = 'Order Type';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TESTFIELD("Opportunity No.");
            end;
        }
        field(55005; "CPQ Item"; Code[10])
        {
            Description = 'CPQ Item';
        }
        field(55006; "Order Date"; Date)
        {
            Description = 'Order Date';
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            var
                DimValue: Record "Dimension Value";
                JobsSetup: Record "Jobs Setup";
            begin
                //<<HEXGBJOB.01
                //ADD Dimension Discription
                JobsSetup.GET;
                DimValue.INIT;
                IF DimValue.GET(JobsSetup."Dimension for Sales Link", "No.") THEN BEGIN
                    DimValue.VALIDATE(Name, Description);
                    DimValue.MODIFY;
                END
                //HEXGBJOB.01 >>
            end;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var

                lrecJobSetup: Record "Jobs Setup";
                gmdlDimMgt: Codeunit "Hex Smax Stage Ext";
            begin
                //HEXGBJOB.01
                lrecJobSetup.GET;
                lrecJobSetup.TESTFIELD("Dimension for Sales Link");
                ValidateShortcutDimCode(gmdlDimMgt.gfcnGetShortcutDimNo(lrecJobSetup."Dimension for Sales Link"), "No.");
                //HEXGBJOB.01>>
            end;
        }
    }
    trigger OnAfterInsert()
    var
        CompanyInformation: Record "Company Information";
        DimValue: Record "Dimension Value";
        JobsSetup: Record "Jobs Setup";
    begin
        //gk
        CompanyInformation.GET;
        JobsSetup.Get;
        "ERP Company No." := CompanyInformation."ERP Company No.";
        //gk
        //<<HEXGBJOB.01
        //Create Dimension Value for the Job
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code", JobsSetup."Dimension for Sales Link");
        DimValue.VALIDATE(Code, "No.");
        DimValue.VALIDATE(Name, "No.");
        DimValue.INSERT(TRUE);
        //HEXGBJOB.01 >>
    end;

    trigger OnDelete()
    var
        DimValue: Record "Dimension Value";
        JobsSetup: Record "Jobs Setup";
    begin
        //HEXGBJOB.01 >>
        JobsSetup.GET;
        DimValue.SETRANGE("Dimension Code", JobsSetup."Dimension for Sales Link");
        DimValue.SETRANGE(Code, "No.");
        IF DimValue.FINDFIRST THEN
            DimValue.DELETE(TRUE);
        //HEXGBJOB.01 <<
    end;

    PROCEDURE CurrencyCheck();
    var
        DifferentCurrenciesErr: TextConst ENU = 'You cannot plan and invoice a job in different currencies.';
    BEGIN
        IF ("Invoice Currency Code" <> "Currency Code") AND ("Invoice Currency Code" <> '') AND ("Currency Code" <> '') THEN
            ERROR(DifferentCurrenciesErr);
    END;

}