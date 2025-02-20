page 60013 "Backlog"
{
    PageType = List;
    SourceTable = BackLog_HGN;
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name") { ApplicationArea = All; }
                field("Item No."; rec."Item No.") { ApplicationArea = All; }
                field("Item Description"; rec."Item Description") { ApplicationArea = All; }

                field("External Document No."; rec."External Document No.") { ApplicationArea = All; }
                field("PRODUCT CAT Code"; rec."PRODUCT CAT Code") { ApplicationArea = All; }
                field("Product CAT Name"; rec."Product CAT Name") { ApplicationArea = All; }
                field("MTK Sector Code"; rec."MTK Sector Code") { ApplicationArea = All; }
                field("MTK Sector Name"; rec."MTK Sector Name") { ApplicationArea = All; }
                field("Document Date"; rec."Document Date") { ApplicationArea = All; }
                field("Promised Delivery Date"; rec."Promised Delivery Date") { ApplicationArea = All; }
                field("Currency Code"; rec."Currency Code") { ApplicationArea = All; }
                field("Amount"; rec."Amount") { ApplicationArea = All; }
                field("Amount LCY"; rec."Amount LCY") { ApplicationArea = All; }
                field("Tipo Reporte"; rec."Tipo Reporte") { ApplicationArea = All; }
                field("Entry No."; rec."Entry No.") { ApplicationArea = All; }
                field(Q1; rec.Q1) { ApplicationArea = All; }
                field(Q2; rec.Q2) { ApplicationArea = All; }
                field(Q3; rec.q3) { ApplicationArea = All; }
                field(Q4; rec.q4) { ApplicationArea = All; }
                field(NextYear; rec.NextYear) { ApplicationArea = All; }

            }
        }
    }
    trigger OnAfterGetRecord()

    var
        CurrentYear: Integer;
        Q1Start: Date;
        Q1End: Date;
        Q2Start: Date;
        Q2End: Date;
        Q3Start: Date;
        Q3End: Date;
        Q4Start: Date;
        Q4End: Date;
        NextYearStart: Date;
    begin
        rec.Q1 := 0;
        rec.Q2 := 0;
        rec.Q3 := 0;
        rec.Q4 := 0;
        rec.NextYear := 0;
        CurrentYear := DATE2DMY(WorkDate(), 3);

        // Definir los rangos de fechas dinámicamente
        Q1Start := DMY2DATE(1, 1, CurrentYear);
        Q1End := DMY2DATE(31, 3, CurrentYear);
        Q2Start := DMY2DATE(1, 4, CurrentYear);
        Q2End := DMY2DATE(30, 6, CurrentYear);
        Q3Start := DMY2DATE(1, 7, CurrentYear);
        Q3End := DMY2DATE(30, 9, CurrentYear);
        Q4Start := DMY2DATE(1, 10, CurrentYear);
        Q4End := DMY2DATE(31, 12, CurrentYear);
        NextYearStart := DMY2DATE(1, 1, CurrentYear + 1);

        if rec."Promised Delivery Date" <> 0D THEN BEGIN
            if (rec."Promised Delivery Date" >= Q1Start) and (rec."Promised Delivery Date" <= Q1End) THEN
                REC.Q1 := REC."Amount LCY";
            if (rec."Promised Delivery Date" >= Q2Start) and (rec."Promised Delivery Date" <= Q2End) THEN
                REC.Q2 := REC."Amount LCY";
            if (rec."Promised Delivery Date" >= Q3Start) and (rec."Promised Delivery Date" <= Q3End) THEN
                REC.Q3 := REC."Amount LCY";
            if (rec."Promised Delivery Date" >= Q4Start) and (rec."Promised Delivery Date" <= Q4End) THEN
                REC.Q4 := REC."Amount LCY";
        END;

        if (rec."Promised Delivery Date" = 0D) or (rec."Promised Delivery Date" < WorkDate()) THEN BEGIN
            if (WorkDate() >= Q1Start) and (WorkDate() <= Q1End) THEN
                REC.Q1 := REC."Amount LCY";
            if (WorkDate() >= Q2Start) and (WorkDate() <= Q2End) THEN
                REC.Q2 := REC."Amount LCY";
            if (WorkDate() >= Q3Start) and (WorkDate() <= Q3End) THEN
                REC.Q3 := REC."Amount LCY";
            if (WorkDate() >= Q4Start) and (WorkDate() <= Q4End) THEN
                REC.Q4 := REC."Amount LCY";
        END;

        if (rec."Promised Delivery Date" >= NextYearStart) THEN BEGIN
            REC.NextYear := REC."Amount LCY";
        END;
    end;
}


