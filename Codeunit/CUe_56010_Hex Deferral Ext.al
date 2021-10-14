codeunit 56010 "Hex Deferral Ext"
{

    PROCEDURE CalculateDeferralSchedule(VAR DefHeader: Record "Deferral Header");
    var
        AmountPerDay: Decimal;
        PeriodMonth: Record date;
        SO: Record 36;
        DefLine: Record "Deferral Line";
        TotalAmountOnLines: Decimal;
        StartingDateOffsetDays: Integer;
        EndingDateOffsetDays: Integer;
        AmountToDefer: Decimal;
        AccumulatedAmount: Decimal;
    BEGIN
        DefHeader.TESTFIELD("Start Date");
        DefHeader.TESTFIELD("End Date");

        DefLine.RESET;
        DefLine.SETRANGE("Deferral Doc. Type", DefHeader."Deferral Doc. Type");
        DefLine.SETRANGE("Gen. Jnl. Template Name", DefHeader."Gen. Jnl. Template Name");
        DefLine.SETRANGE("Gen. Jnl. Batch Name", DefHeader."Gen. Jnl. Batch Name");
        DefLine.SETRANGE("Document Type", DefHeader."Document Type");
        DefLine.SETRANGE("Document No.", DefHeader."Document No.");
        DefLine.SETRANGE("Line No.", DefHeader."Line No.");
        DefLine.DELETEALL;
        DefLine.RESET;

        DefHeader."No. of Days" := DefHeader."End Date" - DefHeader."Start Date" + 1;

        SO.GET(DefHeader."Document Type", DefHeader."Document No.");

        IF SO."Posting Date" > DefHeader."End Date" THEN BEGIN  //posting after deferral range

            InitDefLine(DefLine, DefHeader);
            DefLine."Posting Date" := SO."Posting Date";
            DefLine.Amount := DefHeader."Amount to Defer";
            DefLine.INSERT;
        END ELSE BEGIN
            PeriodMonth.SETRANGE("Period Type", PeriodMonth."Period Type"::Month);
            PeriodMonth.SETFILTER("Period Start", '..' + FORMAT(DefHeader."End Date"));
            PeriodMonth.SETFILTER("Period End", FORMAT(DefHeader."Start Date") + '..');

            DefHeader."No. of Periods" := PeriodMonth.COUNT;

            AmountPerDay := DefHeader."Amount to Defer" / DefHeader."No. of Days";
            DefHeader."Daily Deferral" := ROUND(AmountPerDay, 0.01);
            TotalAmountOnLines := 0;
            AccumulatedAmount := 0;

            IF PeriodMonth.FINDSET THEN
                StartingDateOffsetDays := DefHeader."Start Date" - PeriodMonth."Period Start";
            REPEAT
                CASE TRUE OF
                    (SO."Posting Date" > PeriodMonth."Period End") AND (DefHeader."Start Date" <= PeriodMonth."Period End") AND
                       (DefHeader."Start Date" >= PeriodMonth."Period Start"):       //1st Month before posting date
                        BEGIN
                            //0 for this period, don't accumulate offset days
                            AmountToDefer := 0;
                            AccumulatedAmount += (GetPeriodDays(PeriodMonth) - StartingDateOffsetDays) * AmountPerDay;
                        END;

                    (SO."Posting Date" > PeriodMonth."Period End"):       //Months before posting date
                        BEGIN
                            //0 for this period
                            AmountToDefer := 0;
                            AccumulatedAmount += (GetPeriodDays(PeriodMonth)) * AmountPerDay;
                        END;

                    (SO."Posting Date" >= PeriodMonth."Period Start") AND (SO."Posting Date" <= NORMALDATE(PeriodMonth."Period End"))
                    AND (DefHeader."Start Date" >= PeriodMonth."Period Start"):                                    //posting date within first month
                                                                                                                   //Reverse OffsetOnlyPeriod
                        AmountToDefer := (GetPeriodDays(PeriodMonth) - StartingDateOffsetDays) * AmountPerDay;

                    (SO."Posting Date" >= PeriodMonth."Period Start") AND (SO."Posting Date" <= PeriodMonth."Period End"):  //posting date within this period
                                                                                                                            //AddAccumulated
                        AmountToDefer := ((GetPeriodDays(PeriodMonth)) * AmountPerDay) + AccumulatedAmount;

                    (SO."Posting Date" < DefHeader."Start Date") AND (DefHeader."Start Date" > PeriodMonth."Period Start"):     //posting date before deferment, first month
                                                                                                                                //NormalPeriod - offset
                        AmountToDefer := (GetPeriodDays(PeriodMonth) - StartingDateOffsetDays) * AmountPerDay;

                    ELSE
                        //NormalPeriod
                        AmountToDefer := (GetPeriodDays(PeriodMonth)) * AmountPerDay;
                END;

                IF DefHeader."End Date" <= NORMALDATE(PeriodMonth."Period End") THEN BEGIN
                    //last month and rounding
                    EndingDateOffsetDays := NORMALDATE(PeriodMonth."Period End") - DefHeader."End Date";
                    AmountToDefer := AmountToDefer - (EndingDateOffsetDays * AmountPerDay);
                    IF (AmountToDefer + TotalAmountOnLines) <> DefHeader."Amount to Defer" THEN
                        AmountToDefer := AmountToDefer + DefHeader."Amount to Defer" - (AmountToDefer + TotalAmountOnLines);
                END;
                AmountToDefer := ROUND(AmountToDefer, 0.01);
                TotalAmountOnLines += AmountToDefer;
                InitDefLine(DefLine, DefHeader);
                DefLine."Posting Date" := CreatePeriodPostingDate(PeriodMonth, SO."Posting Date");
                DefLine.Amount := AmountToDefer;
                DefLine.INSERT;

            UNTIL PeriodMonth.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE InitDefLine(VAR DefLine: Record "Deferral Line"; VAR DefHeader: Record "Deferral Header");
    BEGIN
        DefLine.INIT;
        DefLine."Deferral Doc. Type" := DefHeader."Deferral Doc. Type";
        DefLine."Gen. Jnl. Template Name" := DefHeader."Gen. Jnl. Template Name";
        DefLine."Gen. Jnl. Batch Name" := DefHeader."Gen. Jnl. Batch Name";
        DefLine."Document Type" := DefHeader."Document Type";
        DefLine."Document No." := DefHeader."Document No.";
        DefLine."Line No." := DefHeader."Line No.";
        DefLine."Currency Code" := DefHeader."Currency Code";
    END;

    PROCEDURE CreatePeriodPostingDate(VAR DateRec: Record Date; PostingDate: Date): Date;
    VAR
        Day: Integer;
        Month: Integer;
        Year: Integer;
    BEGIN
        //day from posting date, everything else from period
        Day := DATE2DMY(PostingDate, 1);
        Month := DATE2DMY(DateRec."Period Start", 2);
        Year := DATE2DMY(DateRec."Period Start", 3);

        CASE Month OF
            2:
                IF Day > 28 THEN
                    Day := DATE2DMY(DateRec."Period End", 1);
            4, 6, 9, 11:
                IF Day > 30 THEN
                    Day := 30;
        END;

        EXIT(DMY2DATE(Day, Month, Year));
    END;

    LOCAL PROCEDURE GetPeriodDays(VAR DateRec: Record Date): Integer;
    BEGIN
        EXIT(NORMALDATE(DateRec."Period End") - DateRec."Period Start" + 1);
    END;

    PROCEDURE CreateDeferralSchedulePurchase(DeferralCode: Code[10]; DeferralDocType: Integer; GenJnlTemplateName: Code[10]; GenJnlBatchName: Code[10];
    DocumentType: Integer; DocumentNo: Code[20]; LineNo: Integer; AmountToDefer: Decimal;
      CalcMethod: Option "Straight-Line","Equal per Period","Days per Period","User-Defined";
      StartDate: Date; NoOfPeriods: Integer;
     ApplyDeferralPercentage: Boolean; DeferralDescription: Text[50]; AdjustStartDate: Boolean; CurrencyCode2: Code[10]);
    VAR
        DeferralTemplate: Record 1700;
        DeferralHeader: Record 1701;
        DeferralLine: Record 1702;
        AdjustedStartDate: Date;
        AdjustedDeferralAmount: Decimal;
        DeferralUtilities: codeunit "Deferral Utilities";
    BEGIN
        InitCurrency(CurrencyCode2);
        //InitCurrency(CurrencyCode); old code
        DeferralTemplate.GET(DeferralCode);
        // "Start Date" passed in needs to be adjusted based on the Deferral Code's Start Date setting

        IF AdjustStartDate THEN
            AdjustedStartDate := SetStartDate(DeferralTemplate, StartDate)

        ELSE
            AdjustedStartDate := StartDate;


        AdjustedDeferralAmount := AmountToDefer;
        IF ApplyDeferralPercentage THEN
            AdjustedDeferralAmount := ROUND(AdjustedDeferralAmount * (DeferralTemplate."Deferral %" / 100), AmountRoundingPrecision);

        DeferralUtilities.SetDeferralRecords(DeferralHeader, DeferralDocType, GenJnlTemplateName, GenJnlBatchName, DocumentType, DocumentNo, LineNo,
         CalcMethod, NoOfPeriods, AdjustedDeferralAmount, AdjustedStartDate,
         DeferralCode, DeferralDescription, AmountToDefer, TRUE, CurrencyCode2);


        CASE CalcMethod OF
            CalcMethod::"Straight-Line":
                CalculateStraightline(DeferralHeader, DeferralLine, DeferralTemplate);
            CalcMethod::"Equal per Period":
                CalculateEqualPerPeriod(DeferralHeader, DeferralLine, DeferralTemplate);
            CalcMethod::"Days per Period":
                CalculateDaysPerPeriod(DeferralHeader, DeferralLine, DeferralTemplate);
            CalcMethod::"User-Defined":
                CalculateUserDefined(DeferralHeader, DeferralLine, DeferralTemplate);
        END;
    END;

    LOCAL PROCEDURE InitCurrency(CurrencyCode: Code[10]);
    VAR
        Currency: Record 4;
    BEGIN
        IF CurrencyCode = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(CurrencyCode);
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    END;

    LOCAL PROCEDURE SetStartDate(DeferralTemplate: Record 1700; StartDate: Date) AdjustedStartDate: Date;
    VAR
        AccountingPeriod: Record 50;
        DeferralStartOption: Option "Posting Date","Beginning of Period","End of Period","Beginning of Next Period";
    BEGIN
        // "Start Date" passed in needs to be adjusted based on the Deferral Code's Start Date setting;
        CASE DeferralTemplate."Start Date" OF
            DeferralStartOption::"Posting Date":
                AdjustedStartDate := StartDate;
            DeferralStartOption::"Beginning of Period":
                BEGIN
                    IF AccountingPeriod.ISEMPTY THEN
                        EXIT(CALCDATE('<-CM>', StartDate));
                    AccountingPeriod.SETRANGE("Starting Date", 0D, StartDate);
                    IF AccountingPeriod.FINDLAST THEN
                        AdjustedStartDate := AccountingPeriod."Starting Date";
                END;
            DeferralStartOption::"End of Period":
                BEGIN
                    IF AccountingPeriod.ISEMPTY THEN
                        EXIT(CALCDATE('<CM>', StartDate));
                    AccountingPeriod.SETFILTER("Starting Date", '>%1', StartDate);
                    IF AccountingPeriod.FINDFIRST THEN
                        AdjustedStartDate := CALCDATE('<-1D>', AccountingPeriod."Starting Date");
                END;
            DeferralStartOption::"Beginning of Next Period":
                BEGIN
                    IF AccountingPeriod.ISEMPTY THEN
                        EXIT(CALCDATE('<CM + 1D>', StartDate));
                    AccountingPeriod.SETFILTER("Starting Date", '>%1', StartDate);
                    IF AccountingPeriod.FINDFIRST THEN
                        AdjustedStartDate := AccountingPeriod."Starting Date";
                END;
        END;

        //OnAfterSetStartDate(DeferralTemplate, StartDate);
    END;
    //TVT01 Changes to deferrals

    [EventSubscriber(ObjectType::Codeunit, 1720, 'OnBeforeCalculateStraightline', '', false, false)]
    procedure CalculateStraightline(DeferralHeader: Record "Deferral Header"; VAR DeferralLine: Record "Deferral Line"; DeferralTemplate: Record "Deferral Template")

    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 1720, 'OnBeforeCalculateEqualPerPeriod', '', false, false)]
    procedure CalculateEqualPerPeriod(DeferralHeader: Record "Deferral Header"; VAR DeferralLine: Record "Deferral Line"; DeferralTemplate: Record "Deferral Template")

    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 1720, 'OnBeforeCalculateDaysPerPeriod', '', false, false)]
    procedure CalculateDaysPerPeriod(DeferralHeader: Record "Deferral Header"; VAR DeferralLine: Record "Deferral Line"; DeferralTemplate: Record "Deferral Template")

    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 1720, 'OnBeforeCalculateUserDefined', '', false, false)]
    procedure CalculateUserDefined(DeferralHeader: Record "Deferral Header"; VAR DeferralLine: Record "Deferral Line"; DeferralTemplate: Record "Deferral Template")

    begin

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterGetDeferralAmount', '', false, false)]
    procedure "Hex OnAfterGetDeferralAmount"(VAR GenJournalLine: Record "Gen. Journal Line"; VAR DeferralAmount: Decimal)
    var
        IFRS15Setup: Record "IFRS15 Setup";
    begin
        // base code amended by gk
        IFRS15Setup.GET;
        IF NOT (GenJournalLine."Source Type" IN [GenJournalLine."Source Type"::Vendor, GenJournalLine."Source Type"::Customer]) THEN
            IF (GenJournalLine."Source Code" = IFRS15Setup."Source Code") THEN
                DeferralAmount := GenJournalLine.Amount
            ELSE BEGIN // base code amended by gk
                IF GenJournalLine."VAT Base Amount" <> 0 THEN
                    DeferralAmount := GenJournalLine."VAT Base Amount"
                ELSE
                    DeferralAmount := GenJournalLine.Amount;
            END; // base code amended by gk
    end;

    [EventSubscriber(ObjectType::Codeunit, 1720, 'OnBeforePostedDeferralLineInsert', '', false, false)]
    procedure "Hex OnBeforePostedDeferralLineInsert"(VAR PostedDeferralLine: Record "Posted Deferral Line"; GenJournalLine: Record "Gen. Journal Line")
    var
        //DeferralHeader: Record "Deferral Header";
        //DeferralLine:	Record	Deferral Line	
        DeferralTemplate: Record "Deferral Template";
    begin
        //gk
        IF GenJournalLine."IFRS15 Posting" THEN
            IF DeferralTemplate.GET(GenJournalLine."Deferral Code") THEN
                PostedDeferralLine."Deferral Account" := DeferralTemplate."P&L Deferral Account";
        //gk
    end;

    var
        AmountRoundingPrecision: Decimal;

}
