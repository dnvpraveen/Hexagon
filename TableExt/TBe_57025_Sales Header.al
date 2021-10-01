tableextension 57025 "Hex Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Exchange Rate Date"; Date)
        {
            Description = 'Exchange Rate Date';
        }
        field(50001; "Exch. Rate Table"; Code[20])
        {
            Description = 'Exch. Rate Table';
        }
        field(50002; "VAT Bank Account No."; Code[20])
        {
            Description = 'VAT Bank Account No.';
        }
        field(50003; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        field(50100; "Assigned Job No."; Code[20])
        {
        }
        field(55000; "Order Type"; Code[10])
        {
            Description = 'Order Type';
        }
        field(55001; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';
        }
        field(55002; "User Email"; Text[50])
        {
            Description = 'User Email';
        }
        field(55003; "Ship-to Freight"; Text[30])
        {
            Description = 'Ship-to Freight';
        }
        field(55004; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }
        field(55008; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(60000; "Cancel / Short Close"; Option)
        {
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = ,Cancelled,"Short Closed";
            Description = 'Cancel / Short Close';
            Editable = false;
        }
        field(60001; "User Created"; Boolean)
        {
            Description = 'User Created';
        }
        field(70000; Preview; Boolean)
        {
            Description = 'Preview';
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
            begin
                //gk Ship-to Code
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF Cust.Get("Sell-to Customer No.") then
                        VALIDATE("Ship-to Country/Region Code", Cust."Country/Region Code");
                END;
                //gk
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                i: Integer;
                GLSetupShortcutDimCode: ARRAY[20] OF Code[20];
                CountryRegion: Record "Country/Region";
            begin
                //gk
                //CreateDim(
                //DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                //DATABASE::Customer, "Bill-to Customer No.",
                //DATABASE::Campaign, "Campaign No.",
                //DATABASE::"Responsibility Center", "Responsibility Center",
                //  DATABASE::"Customer Template", "Bill-to Customer Template Code");
                //VALIDATE("Shortcut Dimension 1 Code", xRec."Shortcut Dimension 1 Code");
                //VALIDATE("Shortcut Dimension 2 Code", xRec."Shortcut Dimension 2 Code");
                //GLSetupShortcutDimCode[1] := xRec."Shortcut Dimension 1 Code";
                //GLSetupShortcutDimCode[2] := xRec."Shortcut Dimension 2 Code";
                //GLSetupShortcutDimCode[3] := xRec."Shortcut Dimension 3 Code";
                //GLSetupShortcutDimCode[4] := lrecGlSetup."Shortcut Dimension 4 Code";
                //GLSetupShortcutDimCode[5] := lrecGlSetup."Shortcut Dimension 5 Code";
                //IF CountryRegion.GET("Ship-to Country/Region Code") THEN
                //  GLSetupShortcutDimCode[6] := CountryRegion."ISO Code";
                //GLSetupShortcutDimCode[7] := lrecGlSetup."Shortcut Dimension 7 Code";
                //GLSetupShortcutDimCode[8] := lrecGlSetup."Shortcut Dimension 8 Code";
                //FOR i := 1 TO 8 DO BEGIN
                //  Rec.ValidateShortcutDimCode(i, GLSetupShortcutDimCode[i]);
                //END;
                VALIDATE("Ship-to Country/Region Code");
                //gk

            end;
        }
        modify("Ship-to Country/Region Code")
        {
            trigger OnAfterValidate()
            var
                GetGLsetup: Record "General Ledger Setup";
                CountryRegion: Record "Country/Region";
                DimensionValue: Record "Dimension Value";
                gmdlDimMgt: Codeunit "Hex Smax Stage Ext";
            begin
                GetGLsetup.GET;
                VALIDATE("Shortcut Dimension 1 Code", xRec."Shortcut Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code", xRec."Shortcut Dimension 2 Code");
                IF CountryRegion.GET("Ship-to Country/Region Code") THEN BEGIN
                    DimensionValue.INIT;
                    DimensionValue.SETRANGE("Dimension Code", GetGLsetup."Shortcut Dimension 6 Code");
                    DimensionValue.SETRANGE(Code, CountryRegion."ISO Code");
                    IF DimensionValue.FINDFIRST THEN
                        CreateCustom2Dim(gmdlDimMgt.gfcnGetShortcutDimNo(GetGLsetup."Shortcut Dimension 6 Code"), CountryRegion."ISO Code")
                    ELSE
                        MESSAGE('The Country Code CUSTOM2 Dimenstion %1 need to be added manually', CountryRegion."ISO Code");
                END ELSE
                    MESSAGE('The Country Code Is Blank So CUSTOM2 Dimenstion %1 need to be added manually', CountryRegion."ISO Code");
            end;
        }
        modify("Campaign No.")
        {
            trigger OnAfterValidate()
            begin
                //gk
                //{
                //CreateDim(
                //DATABASE::Campaign, "Campaign No.",
                //DATABASE::Customer, "Bill-to Customer No.",
                //DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                //DATABASE::"Responsibility Center", "Responsibility Center",
                //DATABASE::"Customer Template", "Bill-to Customer Template Code");
                //}

                //--- VALIDATE("Ship-to Country/Region Code");
                //gk
            end;
        }
    }


    var
        myInt: Integer;

    trigger OnModify()
    var
        HexInventorySmax: Codeunit HexInventorySmax;
        HexCustomer: Record Customer;
    begin
        IF HexCustomer.GET(Rec."Sell-to Customer No.") THEN
            HexInventorySmax.HexCustomerCreditCheck(HexCustomer);//HEXSmax1
    end;

    procedure CreateCustom2Dim(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
        DimensionSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        IF (OldDimSetID <> "Dimension Set ID") AND SalesLinesExist THEN BEGIN
            MODIFY;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    procedure RestoredefaultDim();
    var
        lrecGlSetup: Record 98;
        lrecJobSetup: Record 315;
        lrecSalesHeader: Record 36;
        Text50000: Label '%1 No. %2 created';
        lrecJobOrderLink: Record 50000;
        lrecDimValue: Record 349;
        lrecDimSetEntry: Record 480;
        lintLineNo: Integer;
        OldDimSetID: Integer;
        i: Integer;
        LrecSalesLine: Record 37;
        LrecJobTaskLine: Record 1001;
        LrecJobPlanningLine: Record 1003;
        JobTaskDimension: Record 1002;
        RecordLinkManagement: Codeunit 447;
    begin

        //Rec.VALIDATE("Shortcut Dimension 1 Code", xRec."Shortcut Dimension 1 Code");
        //Rec.VALIDATE("Shortcut Dimension 2 Code", xRec."Shortcut Dimension 2 Code");

        //lrecGlSetup.GET;
        //GLSetupShortcutDimCode[1] := lrecGlSetup."Shortcut Dimension 1 Code";
        //GLSetupShortcutDimCode[2] := lrecGlSetup."Shortcut Dimension 2 Code";
        //GLSetupShortcutDimCode[3] := lrecGlSetup."Shortcut Dimension 3 Code";
        //GLSetupShortcutDimCode[4] := lrecGlSetup."Shortcut Dimension 4 Code";
        //GLSetupShortcutDimCode[5] := lrecGlSetup."Shortcut Dimension 5 Code";
        //GLSetupShortcutDimCode[6] := lrecGlSetup."Shortcut Dimension 6 Code";
        //GLSetupShortcutDimCode[7] := lrecGlSetup."Shortcut Dimension 7 Code";
        //GLSetupShortcutDimCode[8] := lrecGlSetup."Shortcut Dimension 8 Code";

        //FOR i := 1 TO 8 DO BEGIN
        //JobTaskDimension.RESET;
        //JobTaskDimension.SETRANGE("Job No.", HexJob."No.");
        //JobTaskDimension.SETRANGE("Dimension Code", GLSetupShortcutDimCode[i]);
        //IF JobTaskDimension.FINDFIRST THEN
        //      lrecSalesHeader.ValidateShortcutDimCode(i, JobTaskDimension."Dimension Value Code");
        //END;
        //  lrecSalesHeader.MODIFY;

    end;

}