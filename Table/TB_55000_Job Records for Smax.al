table 55000 "Job Records for Smax"
{
    DataClassification = ToBeClassified;

    fields
    {
        Field(1; "Job No."; Code[20])
        {
            Description = 'Job No.';
        }
        Field(2; "Job Task No."; Code[20])
        {
            Description = 'Job Task No.';
        }
        Field(3; "Line No."; Integer)
        {
            Description = 'Line No.';
        }

        Field(4; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }
        Field(5; "Opportunity No."; Code[10])
        {
            Description = 'Opportunity No.';
        }
        Field(6; "Customer No."; Code[20])
        {
            Description = 'Customer No.';
        }
        Field(7; Name; Text[50])
        {
            Description = 'Name';
        }
        Field(8; Address; Text[50])
        {
            Description = 'Address';
        }
        Field(9; "Address 2"; Text[50])
        {
            Description = 'Address 2';
        }
        Field(10; "Post Code"; Code[10])
        {
            Description = 'Post Code';
        }
        Field(11; "Country /Region Code"; Code[10])
        {
            Description = 'Country /Region Code';
        }
        Field(12; "External Doc No."; Text[35])
        {
            Description = 'External Doc No.';
        }
        Field(13; "Order Type"; Code[2])
        {
            Description = 'Order Type';
        }
        Field(14; "Sales Order No."; Code[20])
        {
            Description = 'Sales Order No.';
        }
        Field(15; "Order Date"; Date)
        {
            Description = 'Order Date';
        }
        Field(16; "Promised Delivery Date"; Date)
        {
            Description = 'Promised Delivery Date';
        }
        Field(17; "Location Code"; Code[10])
        {
            Description = 'Location Code';
        }
        Field(18; Type; Option)
        {
            OptionMembers = Resource,Item,"G/L Account",Text;
            OptionCaptionML = ENU = 'Resource, Item, G/L Account, Text';
        }
        Field(19; "No."; Code[20])
        {
            Description = 'No.';
        }
        Field(20; Description; Text[50])
        {
            Description = 'Description';
        }
        Field(21; Quantity; Decimal)
        {
            Description = 'Quantity';
        }
        Field(22; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
        }
        Field(23; "Activity Type"; Option)
        {
            OptionMembers = ,Purchase,Installation,Training,Programming,Warranty;
            OptionCaptionML = ENU = ' ,Purchase,Installation,Training,Programming,Warranty';
        }
        Field(24; IP; Boolean)
        {
            Description = 'IP';
        }
        Field(25; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }
        Field(26; "Shipment No."; Code[20])
        {
            Description = 'Shipment No.';
        }
        Field(27; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        Field(28; "Invoice No."; Code[20])
        {
            Description = 'Invoice No.';
        }
        Field(29; "Invoice Date"; Date)
        {
            Description = 'Invoice Date';
        }
        Field(30; "Start Date"; Date)
        {
            Description = 'Start Date';
        }
        Field(31; "End Date"; Date)
        {
            Description = 'End Date';
        }
        Field(32; "CPQ Item"; Code[10])
        {
            Description = 'CPQ Item';
        }
        Field(33; Status; Option)
        {
            OptionCaptionML = ENU = 'Planning, Quote, Open, Completed';
            OptionMembers = Planning,Quote,Open,Completed;
        }
        Field(34; "Integration Status"; Option)
        {
            OptionCaptionML = ENU = ' ,InProgress,Successful,Failure';
            OptionMembers = ,InProgress,Successful,Failure;
        }
        Field(35; "Response Status"; Option)
        {
            OptionCaptionML = ENU = ' ,Created,Modified,Processed,UpdatedtoSmax';
            OptionMembers = ,Created,Modified,Processed,UpdatedtoSmax;
        }
        Field(36; "Integration Completed"; Boolean)
        {
            Description = 'Integration Completed';
        }
        Field(37; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Currency Code';
        }
        Field(38; "Customer Type"; Code[2])
        {
            Description = 'Customer Type';
        }
        Field(39; "Sales Order LineNo"; Integer)
        {
            Description = 'Sales Order LineNo';
        }
        Field(40; "Back Order Qty"; Integer)
        {
            Description = 'Back Order Qty';
        }
        Field(41; Message; Text[250])
        {
            Description = 'Message';
        }
        Field(42; "IP Code"; Code[20])

        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
            Description = 'IP Code';
        }
        Field(43; "IP Serial No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."Serial No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
            Description = 'IP Serial No.';
        }
        Field(44; "Target System"; Code[10])
        {
            Description = 'Target System';
        }
        Field(45; "Shipment Status"; Text[30])
        {
            Description = 'Shipment Status';
        }
        Field(46; "Smax Order No."; Text[35])
        {
            Description = 'Smax Order No.';
        }
        Field(47; "Smax Order for IP"; Text[35])
        {
            Description = 'Smax Order for IP';
        }
        Field(48; "IP Created"; Boolean)
        {
            Description = 'IP Created';
        }
        Field(49; "Shipment Done"; Boolean)
        {
            Description = 'Shipment Done';
        }
        Field(50; "Invoice Closed"; Boolean)
        {
            Description = 'Invoice Closed';
        }
        Field(51; "Invoice Status"; Text[30])
        {
            Description = 'Invoice Status';
        }
        Field(52; "PO Value"; Decimal)
        {
            Description = 'PO Value';
        }
        Field(53; "Invoice Inserted"; Boolean)
        {
            Description = 'Invoice Inserted';
        }
        Field(54; "Invoice Created"; Boolean)
        {
            Description = 'Invoice Created';
        }
        Field(55; "Smax Line No"; Text[30])
        {
            Description = 'Smax Line No';
        }
        Field(56; "Smax Work order"; Text[30])
        {
            Description = 'Smax Work order';
        }
        Field(57; "BOM Component"; Boolean)
        {
            Description = 'BOM Component';
        }
        Field(58; "Invoice Total"; Decimal)
        {
            Description = 'Invoice Total';
        }

        Field(59; "Insert BOM"; Boolean)
        {
            Description = 'Insert BOM';
        }
        Field(60; Installation; Boolean)
        {
            Description = 'Installation';
        }
        Field(61; Training; Boolean)
        {
            Description = 'Training';
        }
        Field(62; Program; Boolean)
        {
            Description = 'Program';
        }
        Field(63; Picked; Boolean)
        {
            Description = 'Picked';
        }
        Field(64; Warranty; Boolean)
        {
            Description = 'Warranty';
        }
        Field(65; "Next Record"; Boolean)
        {
            Description = 'Next Record';
        }
        Field(107; "Qty to Invoice"; Decimal)
        {
            Description = 'Qty to Invoice';
        }
        //Field(250; "Completed %"; Decimal)
        //{
        //  Description = 'Completed %';
        //}
    }

    keys
    {
        key(PK; "Job No.", "Job Task No.", "Line No.")
        {
            Clustered = true;
        }
        key("Integration Completed"; IP, "Activity Type", "Integration Status", "Response Status")
        {
            Enabled = true;
        }
    }
    // This Procedure is moved to New codeunit Smax_Ext 56011
    // PROCEDURE IPCreated(JobRecordsforSmax: Record "Job Records for Smax");
    // VAR
    //     LJobRecordsforSmax: Record "Job Records for Smax";
    // BEGIN
    //     IF JobRecordsforSmax."IP Created" THEN BEGIN
    //         LJobRecordsforSmax.RESET;
    //         LJobRecordsforSmax.SETRANGE("Job No.", JobRecordsforSmax."Job No.");
    //         LJobRecordsforSmax.SETRANGE("IP Created", FALSE);
    //         IF LJobRecordsforSmax.FINDSET THEN
    //             REPEAT
    //                 LJobRecordsforSmax."IP Created" := TRUE;
    //                 LJobRecordsforSmax.MODIFY;
    //             UNTIL LJobRecordsforSmax.NEXT = 0;
    //     END;
    // END;

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