table 55007 "ITDW Proforma Records"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job No."; Code[20])
        {

            Description = 'Job No.';
        }
        field(2; "Job Task No."; Code[20])
        {
            Description = 'Job Task No.';
        }
        field(3; "Line No."; Integer)
        {
            Description = 'Line No.';
        }
        field(4; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No."';
        }
        field(5; "Opportunity No."; Code[10])
        {
            Description = 'Opportunity No.';
        }
        field(6; "Customer No."; Code[20])
        {
            Description = 'Customer No.';
        }
        field(7; Name; Text[50])
        {
            Description = 'Name';
        }
        field(8; Address; Text[50])
        {
            Description = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Description = 'Address 2';
        }
        field(10; "Post Code"; Code[10])
        {
            Description = 'Post Code';
        }
        field(11; "Country /Region Code"; Code[10])
        {
            Description = '';
        }
        field(12; "External Doc No."; Text[35])
        {
            Description = 'Country /Region Code';
        }
        field(13; "Order Type"; Code[2])
        {
            Description = '"Order Type';
        }
        field(14; "Sales Order No."; Code[20])
        {
            Description = 'Sales Order No.';
        }
        field(15; "Order Date"; Date)
        {
            Description = 'Order Date';
        }
        field(16; "Promised Delivery Date"; Date)
        {
            Description = '"Promised Delivery Date';
        }
        field(17; "Location Code"; Code[10])
        {
            Description = 'Location Code';
        }
        field(18; Type; Option)
        {
            OptionCaptionML = ENU = 'Resource, Item, G/L Account, Text';
            OptionMembers = Resource,Item,"G/L Account",Text;
        }
        field(19; "No."; Code[20])
        {
            Description = 'No.';
        }
        field(20; Description; Text[50])
        {
            Description = 'Description';
        }
        field(21; Quantity; Decimal)
        {
            Description = 'Quantity';
        }
        field(22; "Unit Price"; Decimal)
        {
            Description = 'Unit Price';
        }
        field(23; "Activity Type"; Option)
        {
            OptionCaptionML = ENU = ' ,Purchase,Installation,Training,Programming,Warranty';
            OptionMembers = ,Purchase,Installation,Training,Programming,Warranty;
        }
        field(24; IP; Boolean)
        {
            Description = 'IP';
        }
        field(25; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }
        field(26; "Shipment No."; Code[20])
        {
            Description = 'Shipment No.';
        }
        field(27; "Shipment Date"; Date)
        {
            Description = 'Shipment Date';
        }
        field(28; "Invoice No."; Code[20])
        {
            Description = 'Invoice No.';
        }
        field(29; "Invoice Date"; Date)
        {
            Description = 'Invoice Date';
        }
        field(30; "Start Date"; Date)
        {
            Description = 'Start Date';
        }
        field(31; "End Date"; Date)
        {
            Description = 'End Date';
        }
        field(32; "CPQ Item"; Code[10])
        {
            Description = 'CPQ Item';
        }
        field(33; Status; Option)
        {
            OptionCaptionML = ENU = 'Planning, Quote, Open, Completed';
            OptionMembers = Planning,Quote,Open,Completed;
        }
        field(34; "Integration Status"; Option)
        {
            OptionCaptionML = ENU = ' ,InProgress,Successful,Failure';
            OptionMembers = ,InProgress,Successful,Failure;
        }
        field(35; "Response Status"; Option)
        {
            OptionCaptionML = ENU = ' ,Created,Modified,Processed,UpDatedtoSmax';
            OptionMembers = ,Created,Modified,Processed,UpDatedtoSmax;
        }
        field(36; "Integration Completed"; Boolean)
        {
            Description = 'Integration Completed';
        }
        field(37; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Description = 'Currency Code';
        }
        field(38; "Customer Type"; Code[2])
        {
            Description = 'Customer Type';
        }
        field(39; "Sales Order LineNo"; Integer)
        {
            Description = 'Sales Order LineNo';
        }
        field(40; "Back Order Qty"; Integer)
        {
            Description = 'Back Order Qty';
        }
        field(41; Message; Text[250])
        {
            Description = 'Message';
        }
        field(42; "IP Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
        }
        field(43; "IP Serial No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Records for Smax"."Serial No." WHERE("Job No." = FIELD("Job No."), IP = CONST(true)));
        }
        field(44; "Target System"; Code[10])
        {
            Description = '';
        }
        field(45; "Shipment Status"; Text[30])
        {
            Description = '';
        }
        field(46; "Smax Order No."; Text[35])
        {
            Description = '';
        }
        field(47; "Smax Order for IP"; Text[35])
        {
            Description = '';
        }
        field(48; "IP Created"; Boolean)
        {
            Description = '';
        }
        field(49; "Shipment Done"; Boolean)
        {
            Description = '';
        }
        field(50; "Invoice Closed"; Boolean)
        {
            Description = '';
        }
        field(51; "Invoice Status"; Text[30])
        {
            Description = '';
        }
        field(52; "PO Value"; Decimal)
        {
            Description = '';
        }
        field(53; "Invoice Inserted"; Boolean)
        {
            Description = '';
        }
        field(54; "Invoice Created"; Boolean)
        {
            Description = '';
        }
        field(55; "Smax Line No"; Text[30])
        {
            Description = '';
        }
        field(56; "Smax Work order"; Text[30])
        {
            Description = '';
        }
    }

    keys
    {
        key(PK; "Job No.", "Job Task No.", "Line No.")
        {
            Clustered = true;
        }

        key("Integration Completed"; IP, "Activity Type", "Integration Status", "Response Status")
        {

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