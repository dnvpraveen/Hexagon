codeunit 55000 "Update Job Records"
{
    trigger OnRun()
    begin

    end;

    VAR
        OriginalOrderNo: Text[35];

    PROCEDURE UpdateRecords(Job: Record 167);
    VAR
        JobRecordsforSmax: Record 55000;
        JobRecordsforSmax2: Record 55000;
        JobTask: Record 1001;
        JobPlanningLine: Record 1003;
        Customer: Record 18;
    BEGIN
        JobTask.RESET;
        JobTask.SETRANGE("Job No.", Job."No.");
        IF JobTask.FINDSET THEN BEGIN
            CLEAR(OriginalOrderNo);
            REPEAT
                JobPlanningLine.RESET;
                JobPlanningLine.SETRANGE("Job No.", JobTask."Job No.");
                JobPlanningLine.SETRANGE("Job Task No.", JobTask."Job Task No.");
                JobPlanningLine.SETFILTER(Type, '<>%1', JobPlanningLine.Type::Text);
                IF JobPlanningLine.FINDSET THEN BEGIN
                    REPEAT
                        JobRecordsforSmax2.RESET;
                        JobRecordsforSmax2.SETRANGE("Job No.", JobPlanningLine."Job No.");
                        JobRecordsforSmax2.SETRANGE("Job Task No.", JobPlanningLine."Job Task No.");
                        JobRecordsforSmax2.SETRANGE("Line No.", JobPlanningLine."Line No.");
                        IF NOT JobRecordsforSmax2.FINDFIRST THEN BEGIN
                            JobRecordsforSmax.INIT;
                            JobRecordsforSmax."Job No." := JobPlanningLine."Job No.";
                            JobRecordsforSmax."Job Task No." := JobPlanningLine."Job Task No.";
                            JobRecordsforSmax."Line No." := JobPlanningLine."Line No.";
                            JobRecordsforSmax."ERP Company No." := JobPlanningLine."ERP Company No.";
                            JobRecordsforSmax."Opportunity No." := JobPlanningLine."Opportunity No.";
                            JobRecordsforSmax."Customer No." := Job."Bill-to Customer No.";
                            JobRecordsforSmax."Order Date" := WORKDATE;
                            IF Customer.GET(JobRecordsforSmax."Customer No.") THEN BEGIN
                                JobRecordsforSmax.Name := Customer.Name;
                                JobRecordsforSmax.Address := Customer.Address;
                                JobRecordsforSmax."Address 2" := Customer."Address 2";
                                JobRecordsforSmax."Post Code" := Customer."Post Code";
                                JobRecordsforSmax."BOM Component" := JobPlanningLine."BOM Component";
                                //JobRecordsforSmax."Country /Region Code" := Customer."Country/Region Code";//Mexico Country convertion
                                JobRecordsforSmax."Country /Region Code" := Customer.HEXCountry;//Mexico Country convertion
                                IF Customer."Customer Posting Group" = 'DOMESTIC' THEN
                                    JobRecordsforSmax."Customer Type" := 'DO';
                                IF (Customer."Customer Posting Group" = 'FOREIGN') OR (Customer."Customer Posting Group" = 'INTERCOMP') THEN
                                    JobRecordsforSmax."Customer Type" := 'FO';
                            END;
                            JobRecordsforSmax."Currency Code" := Job."Currency Code";
                            JobRecordsforSmax."External Doc No." := Job."External Doc No.";
                            //JobRecordsforSmax."Order Date" := Job."Order Date";
                            JobRecordsforSmax."Promised Delivery Date" := JobPlanningLine."Promised Delivery Date";
                            JobRecordsforSmax."Order Type" := JobPlanningLine."Order Type";
                            JobRecordsforSmax."Location Code" := JobPlanningLine."Location Code";
                            JobRecordsforSmax.Type := JobPlanningLine.Type;
                            JobRecordsforSmax."No." := JobPlanningLine."No.";
                            JobRecordsforSmax.Description := JobPlanningLine.Description;
                            JobRecordsforSmax.Quantity := JobPlanningLine.Quantity;
                            JobRecordsforSmax."Unit Price" := JobPlanningLine."Unit Price";
                            JobRecordsforSmax."PO Value" := JobPlanningLine.Quantity * JobPlanningLine."Unit Price";
                            JobRecordsforSmax."PO Value" := JobPlanningLine.Quantity * JobPlanningLine."Unit Price";
                            JobRecordsforSmax."Activity Type" := JobPlanningLine."Activity Type";
                            JobRecordsforSmax."Smax Order No." := JobPlanningLine."Job No." + '-' + JobPlanningLine."Job Task No." + '-' +
                                        FORMAT(JobPlanningLine."Line No.");
                            JobRecordsforSmax.IP := JobPlanningLine.IP;
                            IF JobPlanningLine.IP THEN
                                OriginalOrderNo := JobPlanningLine."Job No." + '-' + JobPlanningLine."Job Task No." + '-' + FORMAT(JobPlanningLine."Line No.");
                            JobRecordsforSmax."Smax Order for IP" := OriginalOrderNo;
                            JobRecordsforSmax."Start Date" := JobPlanningLine."Warranty Start Date";
                            JobRecordsforSmax."End Date" := JobPlanningLine."Warranty End Date";
                            JobRecordsforSmax."CPQ Item" := Job."CPQ Item";
                            JobRecordsforSmax.Status := Job.Status;
                            JobRecordsforSmax."Response Status" := JobRecordsforSmax."Response Status"::Created;
                            JobRecordsforSmax."Integration Status" := 0;
                            JobRecordsforSmax.INSERT;
                        END ELSE BEGIN
                            JobRecordsforSmax."Job No." := JobPlanningLine."Job No.";
                            JobRecordsforSmax."Job Task No." := JobPlanningLine."Job Task No.";
                            JobRecordsforSmax."Line No." := JobPlanningLine."Line No.";
                            JobRecordsforSmax."ERP Company No." := JobPlanningLine."ERP Company No.";
                            JobRecordsforSmax."Opportunity No." := JobPlanningLine."Opportunity No.";
                            JobRecordsforSmax."Customer No." := Job."Bill-to Customer No.";
                            JobRecordsforSmax."Order Date" := WORKDATE;
                            IF Customer.GET(JobRecordsforSmax."Customer No.") THEN BEGIN
                                JobRecordsforSmax.Name := Customer.Name;
                                JobRecordsforSmax.Address := Customer.Address;
                                JobRecordsforSmax."Address 2" := Customer."Address 2";
                                JobRecordsforSmax."Post Code" := Customer."Post Code";
                                //JobRecordsforSmax."Country /Region Code" := Customer."Country/Region Code";//Mexico Country convertion
                                JobRecordsforSmax."Country /Region Code" := Customer.HEXCountry;//Mexico Country convertion
                                IF Customer."Customer Posting Group" = 'DOMESTIC' THEN
                                    JobRecordsforSmax."Customer Type" := 'DO';
                                IF (Customer."Customer Posting Group" = 'FOREIGN') OR (Customer."Customer Posting Group" = 'INTERCOMP') THEN
                                    JobRecordsforSmax."Customer Type" := 'FO';
                            END;
                            JobRecordsforSmax."Currency Code" := Job."Currency Code";
                            JobRecordsforSmax."External Doc No." := Job."External Doc No.";
                            //JobRecordsforSmax."Order Date" := Job."Order Date";
                            JobRecordsforSmax."Promised Delivery Date" := JobPlanningLine."Promised Delivery Date";
                            JobRecordsforSmax."Order Type" := JobPlanningLine."Order Type";
                            JobRecordsforSmax."Location Code" := JobPlanningLine."Location Code";
                            JobRecordsforSmax.Type := JobPlanningLine.Type;
                            JobRecordsforSmax."No." := JobPlanningLine."No.";
                            JobRecordsforSmax.Description := JobPlanningLine.Description;
                            JobRecordsforSmax.Quantity := JobPlanningLine.Quantity;
                            JobRecordsforSmax."Unit Price" := JobPlanningLine."Unit Price";
                            JobRecordsforSmax."Activity Type" := JobPlanningLine."Activity Type";
                            JobRecordsforSmax."BOM Component" := JobPlanningLine."BOM Component";
                            JobRecordsforSmax."Smax Order No." := JobPlanningLine."Job No." + '-' + JobPlanningLine."Job Task No." + '-' +
                                        FORMAT(JobPlanningLine."Line No.");
                            JobRecordsforSmax.IP := JobPlanningLine.IP;
                            IF JobPlanningLine.IP THEN
                                OriginalOrderNo := JobPlanningLine."Job No." + '-' + JobPlanningLine."Job Task No." + '-' + FORMAT(JobPlanningLine."Line No.");
                            JobRecordsforSmax."Smax Order for IP" := OriginalOrderNo;
                            JobRecordsforSmax."Start Date" := JobPlanningLine."Warranty Start Date";
                            JobRecordsforSmax."End Date" := JobPlanningLine."Warranty End Date";
                            JobRecordsforSmax."CPQ Item" := Job."CPQ Item";
                            JobRecordsforSmax.Status := Job.Status;
                            JobRecordsforSmax."Response Status" := JobRecordsforSmax."Response Status"::Modified;
                            JobRecordsforSmax."Integration Status" := 0;
                            JobRecordsforSmax.MODIFY;
                        END;
                    UNTIL JobPlanningLine.NEXT = 0;
                END;
            UNTIL JobTask.NEXT = 0;
        END;
    END;

    PROCEDURE UpdateShipmentDetails(SalesShipmentHeader: Record 110);
    VAR
        JobRecordsforSmax: Record 55000;
        JobRecordsforSmax2: Record 55000;
    BEGIN
        JobRecordsforSmax.RESET;
        JobRecordsforSmax.SETRANGE("Job No.", SalesShipmentHeader."Assigned Job No.");
        JobRecordsforSmax.SETRANGE(IP, TRUE);
        IF JobRecordsforSmax.FINDFIRST THEN BEGIN
            JobRecordsforSmax."Sales Order No." := SalesShipmentHeader."Order No.";
            JobRecordsforSmax."Sales Order LineNo" := 1;
            JobRecordsforSmax."Back Order Qty" := 0;
            JobRecordsforSmax."Shipment No." := SalesShipmentHeader."No.";
            JobRecordsforSmax."Shipment Date" := SalesShipmentHeader."Posting Date";
            JobRecordsforSmax."Response Status" := JobRecordsforSmax."Response Status"::Modified;
            JobRecordsforSmax."Shipment Status" := 'Staged';
            JobRecordsforSmax."Integration Status" := 0;
            JobRecordsforSmax."IP Created" := TRUE;
            JobRecordsforSmax.MODIFY;
        END;
    END;

    PROCEDURE UpdateInvoiceDetails(SalesInvoiceHeader: Record 112);
    VAR
        JobRecordsforSmax: Record 55000;
        JobRecordsforSmax2: Record 55000;
        OrderLogDetails: Record 55006;
    BEGIN
        JobRecordsforSmax.RESET;
        JobRecordsforSmax.SETRANGE("Job No.", SalesInvoiceHeader."Assigned Job No.");
        JobRecordsforSmax.SETRANGE(IP, TRUE);
        IF JobRecordsforSmax.FINDFIRST THEN BEGIN
            JobRecordsforSmax."Invoice No." := SalesInvoiceHeader."No.";
            JobRecordsforSmax."Invoice Date" := SalesInvoiceHeader."Posting Date";
            JobRecordsforSmax."Response Status" := JobRecordsforSmax."Response Status"::Modified;
            JobRecordsforSmax."Invoice Status" := 'Invoiced';
            JobRecordsforSmax."Invoice Created" := TRUE;
            JobRecordsforSmax."Integration Status" := 0;
            JobRecordsforSmax."IP Created" := TRUE;
            JobRecordsforSmax.MODIFY;
        END;

        OrderLogDetails.RESET;
        OrderLogDetails.SETRANGE("Smax Order No.", SalesInvoiceHeader."Work Order No.");
        OrderLogDetails.SETRANGE("Invoice Create", TRUE);
        IF OrderLogDetails.FINDSET THEN BEGIN
            REPEAT
                OrderLogDetails."NAV Invoice No." := SalesInvoiceHeader."No.";
                OrderLogDetails.MODIFY;
            UNTIL OrderLogDetails.NEXT = 0;
        END;
    END;

    PROCEDURE UpdateSerialNo(JobLedgerEntry: Record 169);
    VAR
        JobRecordsforSmax: Record 55000;
        JobRecordsforSmax2: Record 55000;
    BEGIN
        JobRecordsforSmax.RESET;
        JobRecordsforSmax.SETRANGE("Job No.", JobLedgerEntry."Job No.");
        JobRecordsforSmax.SETRANGE("No.", JobLedgerEntry."No.");
        JobRecordsforSmax.SETRANGE(IP, TRUE);
        IF JobRecordsforSmax.FINDFIRST THEN BEGIN
            JobRecordsforSmax."Serial No." := JobLedgerEntry."Serial No.";
            JobRecordsforSmax."Response Status" := JobRecordsforSmax."Response Status"::Modified;
            JobRecordsforSmax."Integration Status" := 0;
            JobRecordsforSmax."IP Created" := TRUE;
            JobRecordsforSmax.MODIFY;
        END;
    END;

    PROCEDURE UpdateBillingInvoiceDetails(LSalesInvoiceHeader: Record 112; LSalesInvoiceLine: Record 113);
    VAR
        SalesInvoiceHeader_ACk: Record 55012;
        SalesInvoiceLine_Ack: Record 55013;
    BEGIN
        SalesInvoiceHeader_ACk.RESET;
        SalesInvoiceHeader_ACk.SETRANGE("No.", LSalesInvoiceHeader."No.");
        IF NOT SalesInvoiceHeader_ACk.FINDFIRST THEN BEGIN
            SalesInvoiceHeader_ACk.INIT;
            SalesInvoiceHeader_ACk.TRANSFERFIELDS(LSalesInvoiceHeader);
            SalesInvoiceHeader_ACk.INSERT;
        END;

        SalesInvoiceLine_Ack.RESET;
        SalesInvoiceLine_Ack.SETRANGE("Document No.", LSalesInvoiceLine."Document No.");
        SalesInvoiceLine_Ack.SETRANGE("Line No.", LSalesInvoiceLine."Line No.");
        IF NOT SalesInvoiceLine_Ack.FINDFIRST THEN BEGIN
            SalesInvoiceLine_Ack.INIT;
            SalesInvoiceLine_Ack.TRANSFERFIELDS(LSalesInvoiceLine);
            SalesInvoiceLine_Ack."Smax Line No." := LSalesInvoiceLine."Smax Line No.";
            SalesInvoiceLine_Ack."Order Created" := TRUE;
            SalesInvoiceLine_Ack.INSERT;
        END;
    END;


}

