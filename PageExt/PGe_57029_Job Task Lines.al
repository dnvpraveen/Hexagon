pageextension 57029 "Hex Job Task Lines" extends "Job Task Lines"
{
    layout
    {
        // Add changes to page layout here dnv
        addafter("Job Task No.")
        {

            field("Concat"; rec."Job No." + '-' + rec."Job Task No.")
            {
                Caption = 'Concat';
                ApplicationArea = all;
            }

            field("Smax Order No."; JobSevicesMax."Smax Order No.")
            {
                Caption = 'Smax Order No.';
                ApplicationArea = all;
            }
            field("Customer No."; JobSevicesMax."Customer No.")
            {
                Caption = 'Customer No.';
                ApplicationArea = all;
            }
            field("Customer Name"; JobSevicesMax.Name)
            {
                Caption = 'Customer Name';
                ApplicationArea = all;
            }
            field("External Document No."; JobSevicesMax."External Doc No.")
            {
                Caption = 'External Document No.';
                ApplicationArea = all;
            }
            field("Performance Obligation2"; rec."Performance Obligation")
            {
                Caption = 'Performance Obligation';
                ApplicationArea = all;
            }
            field("Activity Type2"; rec."Activity Type")
            {
                Caption = 'Activity Type';
                ApplicationArea = all;
            }
            field("IFRS15 Perf. Obligation Status2"; rec."IFRS15 Perf. Obligation Status")
            {
                Caption = 'IFRS15 Perf. Obligation Status';
                ApplicationArea = all;
            }
            field("Currency"; JobSevicesMax."Currency Code")
            {
                Caption = 'Currency Code';
                ApplicationArea = all;
            }
            field("IFRS15 Line Amount2"; rec."IFRS15 Line Amount")
            {
                Caption = 'IFRS15 Line Amount';
                ApplicationArea = all;
            }
            field("IFRS15 Line Amount (LCY)2"; rec."IFRS15 Line Amount (LCY)")
            {
                Caption = 'IFRS15 Line Amount (LCY)';
                ApplicationArea = all;
            }
            field("Deferral Template2"; rec."Deferral Template")
            {
                Caption = 'Deferral Template';
                ApplicationArea = all;
            }
            field(Pending; rec.Pending)
            {
                Caption = 'Pending';
                ApplicationArea = all;
            }
        }

        addlast(Content)
        {
            field("Performance Obligation"; "Performance Obligation")
            {
                Caption = 'Performance Obligation';
            }
            field("Activity Type"; "Activity Type")
            {
                Caption = 'Activity Type';
            }
            field("IFRS15 Perf. Obligation Status"; "IFRS15 Perf. Obligation Status")
            {
                Editable = IFRS15Editable;

                trigger OnValidate()
                begin
                    CurrPage.UPDATE;
                    SetIFRS15FieldsEditable;
                end;
            }
            field("IFRS15 Line Amount"; "IFRS15 Line Amount")
            {
                Caption = 'IFRS15 Line Amount';
            }
            field("IFRS15 Line Amount (LCY)"; "IFRS15 Line Amount (LCY)")
            {
                Caption = 'IFRS15 Line Amount (LCY)';
            }
            field("Deferral Template"; "Deferral Template")
            {
                Editable = IFRS15Editable;
                Caption = 'Deferral Template';
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("&Dimensions")
        {
            action(UpdateReport)
            {
                Caption = 'Update Backlog Report';
                Image = UpdateShipment;
                trigger OnAction()
                var
                    Backlog: Record Backlog_HGN;
                    Ultimo: Integer;
                begin

                    Backlog.Reset();
                    Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::"Job Line");
                    if Backlog.FindSet() then
                        repeat
                            Backlog.Delete();
                        until Backlog.Next() = 0;
                    Backlog.Reset();
                    if Backlog.FindLast() then
                        Ultimo := Backlog."Entry No." + 1 else
                        Ultimo := 1;
                    rec.FindSet();
                    repeat
                        Clear(JobSevicesMax);
                        JobSevicesMax.Reset();
                        JobSevicesMax.SetRange("Job No.", rec."Job No.");
                        JobSevicesMax.SetRange("Job Task No.", rec."Job Task No.");
                        if JobSevicesMax.FindSet() then;
                        rec.CalcFields(Pending);
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(Code, rec."Global Dimension 2 Code");
                        IF DimensionValue.FINDSET THEN;
                        Backlog."Entry No." := Ultimo;
                        Backlog.Init();
                        Backlog."No." := rec."Job No.";
                        Backlog."Sell-to Customer No." := JobSevicesMax."Customer No.";
                        Backlog."Sell-to Customer Name" := JobSevicesMax.Name;
                        Backlog."External Document No." := JobSevicesMax."External Doc No.";
                        Backlog."Product CAT Name" := DimensionValue.Name;
                        Backlog."PRODUCT CAT Code" := rec."Global Dimension 2 Code";
                        Backlog."Item Description" := rec.Description;
                        Backlog."Item No." := Format(rec."Activity Type");
                        Backlog."Document Date" := rec."Start Date";
                        Backlog."Promised Delivery Date" := rec."Start Date";
                        Backlog."Currency Code" := JobSevicesMax."Currency Code";
                        Backlog.Amount := rec."IFRS15 Line Amount";
                        Backlog."Amount LCY" := rec."IFRS15 Line Amount (LCY)";
                        Backlog."Tipo Reporte" := Backlog."Tipo Reporte"::"Job Line";
                        DimensionEntry.Reset();
                        DimensionEntry.SetRange("No.", rec."Job No.");
                        DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                        if DimensionEntry.FindSet() then begin
                            DimensionValue.RESET;
                            DimensionValue.SETRANGE(Code, DimensionEntry."Dimension Value Code");
                            IF DimensionValue.FINDSET THEN;
                            Backlog."MTK Sector Name" := DimensionValue.Name;
                            Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                        end;

                        Backlog.Insert();
                        Ultimo := Ultimo + 1;
                    until rec.Next() = 0;


                    Message('Report has been updated!');

                end;
            }
        }
    }

    var
        myInt: Integer;
        IFRS15Editable: Boolean;
        JobSevicesMax: Record "Job Records for Smax";
        DimensionValue: Record "Dimension Value";
        SalesHeader: record job;
        DimensionEntry: Record "Default Dimension";


    trigger OnAfterGetRecord()
    begin
        Clear(JobSevicesMax);
        JobSevicesMax.Reset();
        JobSevicesMax.SetRange("Job No.", rec."Job No.");
        JobSevicesMax.SetRange("Job Task No.", rec."Job Task No.");
        if JobSevicesMax.FindSet() then;
        rec.CalcFields(Pending);
    end;

    LOCAL PROCEDURE SetIFRS15FieldsEditable();
    BEGIN
        // TM TF IFRS15 02/07/18 Start
        IFRS15Editable := FALSE;
        IF ("Job Task Type" = "Job Task Type"::Posting) AND ("IFRS15 Perf. Obligation Status" <> "IFRS15 Perf. Obligation Status"::Posted) THEN
            IFRS15Editable := TRUE;
        // TM TF IFRS15 02/07/18 End
    END;


    procedure UpdateBacklog()
    var
        Backlog: Record Backlog_HGN;
        Ultimo: Integer;
    begin

        Backlog.Reset();
        Backlog.SetRange("Tipo Reporte", Backlog."Tipo Reporte"::"Job Line");

        if Backlog.FindSet() then
            repeat
                Backlog.Delete();
            until Backlog.Next() = 0;
        Backlog.Reset();
        if Backlog.FindLast() then
            Ultimo := Backlog."Entry No." + 1 else
            Ultimo := 1;
        rec.SetRange(Pending, true);
        rec.SetRange("IFRS15 Perf. Obligation Status", rec."IFRS15 Perf. Obligation Status"::" ");
        rec.SetFilter("IFRS15 Line Amount (LCY)", '<>0');
        if rec.FindSet() then
            repeat
                Clear(JobSevicesMax);
                JobSevicesMax.Reset();
                JobSevicesMax.SetRange("Job No.", rec."Job No.");
                JobSevicesMax.SetRange("Job Task No.", rec."Job Task No.");
                if JobSevicesMax.FindSet() then;
                rec.CalcFields(Pending);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, rec."Global Dimension 2 Code");
                IF DimensionValue.FINDSET THEN;
                Backlog."Entry No." := Ultimo;
                Backlog.Init();
                Backlog."No." := rec."Job No.";
                Backlog."Sell-to Customer No." := JobSevicesMax."Customer No.";
                Backlog."Sell-to Customer Name" := JobSevicesMax.Name;
                Backlog."External Document No." := JobSevicesMax."External Doc No.";
                Backlog."Product CAT Name" := DimensionValue.Name;
                Backlog."PRODUCT CAT Code" := rec."Global Dimension 2 Code";
                Backlog."Item Description" := rec.Description;
                Backlog."Item No." := Format(rec."Activity Type");
                Backlog."Document Date" := rec."Start Date";
                Backlog."Promised Delivery Date" := rec."Start Date";
                Backlog."Currency Code" := JobSevicesMax."Currency Code";
                Backlog.Amount := rec."IFRS15 Line Amount";
                Backlog."Amount LCY" := rec."IFRS15 Line Amount (LCY)";
                Backlog."Tipo Reporte" := Backlog."Tipo Reporte"::"Job Line";
                DimensionEntry.Reset();
                DimensionEntry.SetRange("No.", rec."Job No.");
                DimensionEntry.SetRange("Dimension Code", 'MKT SECTOR');
                if DimensionEntry.FindSet() then begin
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, DimensionEntry."Dimension Value Code");
                    IF DimensionValue.FINDSET THEN;
                    Backlog."MTK Sector Name" := DimensionValue.Name;
                    Backlog."MTK Sector Code" := DimensionEntry."Dimension Value Code"
                end;

                Backlog.Insert();
                Ultimo := Ultimo + 1;
            until rec.Next() = 0;

    end;

}
