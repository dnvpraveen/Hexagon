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
            begin
                //gk
                //CreateDim(
                //DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                //DATABASE::Customer, "Bill-to Customer No.",
                //DATABASE::Campaign, "Campaign No.",
                //DATABASE::"Responsibility Center", "Responsibility Center",
                //  DATABASE::"Customer Template", "Bill-to Customer Template Code");
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
                gmdlDimMgt: Codeunit DimensionManagement;
            begin
                GetGLsetup.GET;
                IF CountryRegion.GET("Ship-to Country/Region Code") THEN BEGIN
                    DimensionValue.INIT;
                    DimensionValue.SETRANGE("Dimension Code", GetGLsetup."Shortcut Dimension 10 Code");
                    DimensionValue.SETRANGE(Code, CountryRegion."HEX Country Code");
                    IF DimensionValue.FINDFIRST THEN
                        //  CreateCustom2Dim(gmdlDimMgt.gfcnGetShortcutDimNo(GetGLsetup."Shortcut Dimension 10 Code"), CountryRegion."HEX Country Code")
                        //ELSE
                        MESSAGE('The Country Code Dimenstion %1 need to be added manually', "Ship-to Country/Region Code");
                END ELSE
                    MESSAGE('The Country Code Dimenstion %1 need to be added manually', "Ship-to Country/Region Code");
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

}