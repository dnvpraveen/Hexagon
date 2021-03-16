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
        modify(Status)
        {
            trigger OnBeforeValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
                lrecUserSetup: Record "User Setup";
                JItem: Record Item;
                // JitemEntry	Record	Item Ledger Entry	
                UpdateJobRecords: Codeunit "Update Job Records";

                JobTask: Record "Job Task";
                TotalIFRSLineAmount: Decimal;
                TotalIFRSLineAmountLCY: Decimal;
                //CompanyInformation  Record Company Information
                //GJobPlanningLine    Record  Job Planning Line
                StatusChangeQst: label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
                Text50000: label 'Status has to be Order before Completed';
                Text50001: label 'You are not allowed to change the status.  Please check %1 on %2 to allow this status change';
                AmountMismatchErr: label 'Total Revenue to Recognise %1 must be equal to IFRS Line Amount Total %2.';
                AmountLCYMismatchErr: Label 'Total Revenue to Recognise(LCY) %1 must be equal to IFRS Line Amount (LCY) Total %2.';
            begin
                //GK
                IF xRec.Status <> Status THEN
                    IF Status = Status::Open THEN BEGIN
                        TESTFIELD("Global Dimension 2 Code");
                        TotalIFRSLineAmount := 0;
                        TotalIFRSLineAmountLCY := 0;
                        JobTask.RESET;
                        JobTask.SETRANGE("Job No.", "No.");
                        IF JobTask.FINDSET THEN BEGIN
                            REPEAT
                                JobTask.CALCFIELDS("IFRS15 Line Amount", "IFRS15 Line Amount (LCY)");
                                TotalIFRSLineAmount += JobTask."IFRS15 Line Amount";
                                TotalIFRSLineAmountLCY += JobTask."IFRS15 Line Amount (LCY)";
                            UNTIL JobTask.NEXT = 0;
                        END;
                        CALCFIELDS("Total Rev to Recognize (LCY)");
                        IF TotalIFRSLineAmount <> "Total Revenue to Recognize" THEN
                            ERROR(AmountMismatchErr, "Total Revenue to Recognize", TotalIFRSLineAmount);
                        IF TotalIFRSLineAmountLCY <> "Total Rev to Recognize (LCY)" THEN
                            ERROR(AmountLCYMismatchErr, "Total Rev to Recognize (LCY)", TotalIFRSLineAmountLCY);
                    END;
                //GK
                IF xRec.Status <> Status THEN BEGIN

                    //HEXGBJOB.01->
                    //changing status from Order back to Planning or Quote
                    //IF (xRec.Status <> xRec.Status::Order) AND (Status <> Status::Completed) THEN BEGIN //MAN
                    IF (xRec.Status = xRec.Status::Open) OR (xRec.Status = Status::Completed) THEN BEGIN //MAN
                        IF (Status = Status::Planning) OR (Status = Status::Quote) THEN BEGIN //MAN
                            IF NOT lrecUserSetup.GET(USERID) THEN
                                lrecUserSetup.INIT;
                            IF NOT lrecUserSetup."Change Job Status" THEN
                                ERROR(Text50001, lrecUserSetup.FIELDCAPTION("Change Job Status"), lrecUserSetup.TABLENAME);
                        END; //MAN
                    END;

                    IF Status = Status::Completed THEN
                        IF xRec.Status <> xRec.Status::Open THEN
                            ERROR(Text50000)
                        ELSE BEGIN
                            //VALIDATE(Complete,TRUE);
                            GET("No.");
                            Status := Status::Completed;
                            Complete := TRUE;
                            MODIFY;
                        END;
                    //<-HEXGBJOB.01

                    IF xRec.Status = xRec.Status::Completed THEN BEGIN
                        IF DIALOG.CONFIRM(StatusChangeQst) THEN
                            VALIDATE(Complete, FALSE)
                        ELSE
                            Status := xRec.Status;
                    END;

                    //gk
                    IF (xRec.Status <> xRec.Status::Open) AND (Status = Status::Open) THEN
                        UpdateJobRecords.UpdateRecords(Rec);
                    //gk


                    //<<MAN HEXGBJOB.01 - Set Original Value to preserve the budget (Moved from Status on Validate on table 1003
                    JobPlanningLine.SETCURRENTKEY("Job No.");
                    JobPlanningLine.SETRANGE("Job No.", "No.");
                    //IF (xRec.Status <> xRec.Status::Order) AND (Status = Status::Order) THEN BEGIN
                    IF (xRec.Status <> xRec.Status::Open) AND (Status = Status::Open) THEN BEGIN//HEXb2b
                        IF JobPlanningLine.FINDFIRST THEN
                            REPEAT
                                JobPlanningLine."Original Quantity" := JobPlanningLine.Quantity;
                                JobPlanningLine."Original Unit Cost (LCY)" := JobPlanningLine."Unit Cost (LCY)";
                                JobPlanningLine."Original Total Cost (LCY)" := JobPlanningLine."Total Cost (LCY)";
                                // HEXGBJOB.01 >>
                                JobPlanningLine."Original Unit Cost" := JobPlanningLine."Original Unit Cost";
                                JobPlanningLine."Original Total Cost" := JobPlanningLine."Original Total Cost";
                                // HEXGBJOB.013 <<
                                //gk
                                JobPlanningLine."Original IFRS15 Line Amount" := JobPlanningLine."IFRS15 Line Amount";
                                JobPlanningLine."Original IFRS15 Line Amt (LCY)" := JobPlanningLine."IFRS15 Line Amount (LCY)";
                                //gk
                                //gk

                                //HEXGB1022 Start and HEXGBJOB.01
                                IF (JobPlanningLine.Type = JobPlanningLine.Type::Item) AND JItem.GET(JobPlanningLine."No.") THEN
                                    JobPlanningLine."Original Purchase Unit Cost" := JItem."Last Direct Cost"
                                ELSE
                                    JobPlanningLine."Original Purchase Unit Cost" := JobPlanningLine."Unit Cost (LCY)";
                                //HEXGB1022 END and HEXGBJOB.01
                                JobPlanningLine.MODIFY;
                            UNTIL JobPlanningLine.NEXT = 0
                    END;
                    //MAN HEXGBJOB.01>>

                    //KB HEXGBJOB.01->
                    JobPlanningLine.RESET; //MAN
                    JobPlanningLine.SETCURRENTKEY("Job No.");
                    JobPlanningLine.SETRANGE("Job No.", "No.");
                    JobPlanningLine.MODIFYALL(Status, Status);  //MAN - Put back in original code
                                                                //JobPlanningLine.MODIFYALL(Status,Status,TRUE); //MAN - remove modification
                                                                //<-KB HEXGBJOB.01
                    MODIFY;
                end;
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
        Status := Status::Planning;
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