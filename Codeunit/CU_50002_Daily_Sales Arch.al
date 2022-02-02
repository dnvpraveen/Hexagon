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
        //AutoArchive := TRUE;
        SalesHeader.SETCURRENTKEY("Document Type", "No.");
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        IF SalesHeader.FINDSET THEN
            REPEAT
                ArchiveMgt.StoreSalesDocument(SalesHeader, FALSE);
            UNTIL SalesHeader.NEXT = 0;
        //HexAm01 Start End
    END;

    var
        myInt: Integer;
}