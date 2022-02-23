codeunit 50002 "Daily Sales Arch"
{
    trigger OnRun()
    begin
        DailyArchiveSales;
    end;

    PROCEDURE DailyArchiveSales();
    var
        ArchiveMgt: Codeunit ArchiveManagement;
        SalesHeader: Record "Sales Header";
    BEGIN
        //HexAm01 Start
        SalesHeader.INIT;
        AutoArchive := TRUE;
        SalesHeader.SETCURRENTKEY("Document Type", "No.");
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        IF SalesHeader.FINDSET THEN
            REPEAT
                ArchiveMgt.StoreSalesDocument(SalesHeader, FALSE);
            UNTIL SalesHeader.NEXT = 0;
        AutoArchive := false;
        //HexAm01 Start End
    END;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnBeforeSalesHeaderArchiveInsert', '', false, false)]
    procedure "Hex OnBeforeSalesHeaderArchiveInsert"(VAR SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header")
    begin
        if AutoArchive then
            SalesHeaderArchive."Archived By" := 'Daily Archive';
    end;

    var
        AutoArchive: Boolean;
}