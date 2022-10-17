report 50015 "Aged Accounts Receivable Cust"
{
    // Sign      Name
    // --------------------------------------
    // UPG1.0    Ganga Raju
    // 
    // Version    Date       Description
    // --------------------------------------------------------------------------------------------
    // UPG1.0     04JUL18    Created New Report 50055(Aged Accounts Receivable Cust).
    DefaultLayout = RDLC;
    RDLCLayout = './AgedAccountsReceivableCust.rdlc';

    Caption = 'Aged Accounts Receivable Cust';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Customer Posting Group";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(FormatEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(NOTDUE365daysCaption; NOTDUE365daysCaptionLbl)
            {
            }
            column(NOTDUELs365daysCaption; NOTDUELs365daysCaptionLbl)
            {
            }
            column(TotalOverDueCaption; TotalOverDueCaptionLbl)
            {
            }
            column(TotalARCaption; TotalARCaptionLbl)
            {
            }
            column(HeaderText8; HeaderText[8])
            {
            }
            column(HeaderText7; HeaderText[7])
            {
            }
            column(HeaderText6; HeaderText[6])
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalCLE8RemAmt; GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE7RemAmt; GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE6RemAmt; GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE6CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE7CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE8CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            dataitem(DataItem8503; 21)
            {
                DataItemLink = "customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record 21;
                begin
                    CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustLedgEntry);
                            UNTIL CustLedgEntry.NEXT = 0;
                    END;

                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenCustLedgEntry; 21)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP;
                    END;

                    InsertTemp(OpenCustLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END;
                end;
            }
            dataitem(CurrencyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempCustLedgEntryLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(Name1_Cust; Customer.Name)
                    {
                        IncludeCaption = true;
                    }
                    column(No_Cust; Customer."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE6RemAmtLCY; AgedCustLedgEntry[6]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE7RemAmtLCY; AgedCustLedgEntry[7]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE8RemAmtLCY; AgedCustLedgEntry[8]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDueDate; FORMAT(CustLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CLEDocType; FORMAT(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CLEPostingDate; FORMAT(CustLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedCLE8TempRemAmt; AgedCustLedgEntry[8]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE7TempRemAmt; AgedCustLedgEntry[7]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE6TempRemAmt; AgedCustLedgEntry[6]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Name_Cust; STRSUBSTNO(Text005, Customer.Name))
                    {
                    }
                    column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE6RemAmtLCY; TotalCustLedgEntry[6]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE7RemAmtLCY; TotalCustLedgEntry[7]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE8RemAmtLCY; TotalCustLedgEntry[8]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CurrrencyCode; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCLE8RemAmt; TotalCustLedgEntry[8]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE7RemAmt; TotalCustLedgEntry[7]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE6RemAmt; TotalCustLedgEntry[6]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCheck; CustFilterCheck)
                    {
                    }
                    column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE8PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE7PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE6PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE8RemAmtLCY; GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE7RemAmtLCY; GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE6RemAmtLCY; GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(NotDueL365; NotDueL365)
                    {
                    }
                    column(NotDueG365; NotDueG365)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempCustLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                        IF DetailedCustomerLedgerEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF (DetailedCustomerLedgerEntry."Entry Type" =
                                    DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (CustLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedCustomerLedgerEntry."Posting Date" :=
                                          CustLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (CustLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Due Date"
                                END;

                                IF (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) OR
                                   (TempCustLedgEntry.Open AND
                                    (AgingBy = AgingBy::"Due Date") AND
                                    (CustLedgEntryEndingDate."Due Date" > EndingDate))
                                //AND(CustLedgEntryEndingDate."Posting Date" <= EndingDate))
                                THEN BEGIN
                                    IF DetailedCustomerLedgerEntry."Entry Type" IN
                                       [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Amount (LCY)" :=
                                          CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    END;
                                    //IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                    CustLedgEntryEndingDate."Remaining Amount" :=
                                      CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                    CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                      CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    //END;
                                END;
                            UNTIL DetailedCustomerLedgerEntry.NEXT = 0;

                        IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        CustLedgEntryEndingDate."Remaining Amount" := 0;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedCustLedgEntry);
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                        IF PrintAmountInLCY AND PrintDetails THEN
                            MakeExcelBody
                        ELSE
                            IF PrintDetails THEN
                                OnlyWithPrintDetail;
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF (CustNo <> Customer."No.") OR (CurrCode <> CurrencyCode) THEN BEGIN
                            CustNo := Customer."No.";
                            CurrCode := CurrencyCode;
                            ExcelDetails;
                        END;

                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals;

                        IF PrintAmountInLCY AND PrintDetails THEN
                            WithPrintDetlAndPrintAmtLCYTot
                        ELSE
                            IF PrintDetails THEN
                                WithPrintDetailFooter
                            ELSE
                                IF (NOT PrintAmountInLCY AND NOT PrintDetails) THEN
                                    WithOutBothPrintAndPrintLCYFooter;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN BEGIN
                            IF (TempCurrency.Code = '') OR (TempCurrency.Code = GLSetup."LCY Code") THEN
                                TempCustLedgEntry.SETFILTER("Currency Code", '%1|%2', GLSetup."LCY Code", '')
                            ELSE
                                TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                        END;

                        PageGroupNo := NextPageGroupNo;
                        IF NewPagePercustomer AND (NumberOfCurrencies > 0) THEN
                            NextPageGroupNo := PageGroupNo + 1;

                        IF (PrintAmountInLCY AND PrintDetails) OR PrintDetails THEN
                            WithPrintDetailHeader;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalCustLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency.NEXT = 0 THEN
                            CurrReport.BREAK;

                    IF TempCurrency.Code <> '' THEN
                        CurrencyCode := TempCurrency.Code
                    ELSE
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPagePercustomer THEN
                    PageGroupNo += 1;
                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempCustLedgEntry.RESET;
                TempCustLedgEntry.DELETEALL;
            end;

            trigger OnPostDataItem()
            begin
                GrandTotalFooter;
            end;
        }
        dataitem(CurrencyTotals; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurrNo; Number = 1)
            {
            }
            column(TempCurrCode; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE8RemAmt; AgedCustLedgEntry[8]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE7RemAmt; AgedCustLedgEntry[7]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 99991231D THEN
                            AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedCustLedgEntry[7]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT = 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        Caption = 'Aged As Of';
                    }
                    field(Agingby; AgingBy)
                    {
                        Caption = 'Aging by';
                        Editable = false;
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                        Visible = false;
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        Caption = 'Print Amounts in LCY';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        Caption = 'Print Details';
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                    }
                    field(NewPagePercustomer; NewPagePercustomer)
                    {
                        Caption = 'New Page per Customer';
                    }
                    field("Not Due"; NotDue)
                    {
                    }
                    field("Period 1"; Period[3])
                    {
                    }
                    field("Period 2"; Period[4])
                    {
                    }
                    field("Period 3"; Period[5])
                    {
                    }
                    field("Period 4"; Period[6])
                    {
                    }
                    field("Period 5"; Period[7])
                    {
                    }
                    field("Print To Excel"; PrintToExcel)
                    {
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;
            HeadingType := HeadingType::"Number of Days";
            PrintDetails := FALSE;
        end;
    }

    labels
    {
        BalanceCaption = 'Balance';
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            ExcelBuffer.CreateBookAndOpenExcel('', 'Aged Accounts Receivable Cust', 'Aged Accounts Receivable Cust', COMPANYNAME, USERID);
        END;
    end;

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;

        GLSetup.GET;
        CalcDates;
        CreateHeadings;

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');

        IF PrintToExcel THEN BEGIN
            FontNameTxt := 'Segoe UI';
            FontSizeInt := 8;
            MakeExcelHeader;
        END;
    end;

    var
        GLSetup: Record 98;
        TempCustLedgEntry: Record 21 temporary;
        CustLedgEntryEndingDate: Record 21;
        TotalCustLedgEntry: array[8] of Record 21;
        GrandTotalCustLedgEntry: array[8] of Record 21;
        AgedCustLedgEntry: array[9] of Record 21;
        TempCurrency: Record 4 temporary;
        TempCurrency2: Record 4 temporary;
        TempCurrencyAmount: Record 264 temporary;
        DetailedCustomerLedgerEntry: Record 379;
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[8] of Date;
        PeriodEndDate: array[8] of Date;
        HeaderText: array[8] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label '>';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        CustFilterCheck: Boolean;
        Text032: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAccReceivableCptnLbl: Label 'Aged Accounts Receivable';
        CurrReportPageNoCptnLbl: Label 'Page';
        AllAmtinLCYCptnLbl: Label 'All Amounts in LCY';
        AgedOverdueAmtCptnLbl: Label 'Aged Overdue Amounts';
        CLEEndDateAmtLCYCptnLbl: Label 'Original Amount ';
        CLEEndDateDueDateCptnLbl: Label 'Due Date';
        CLEEndDateDocNoCptnLbl: Label 'Document No.';
        CLEEndDatePstngDateCptnLbl: Label 'Posting Date';
        CLEEndDateDocTypeCptnLbl: Label 'Document Type';
        OriginalAmtCptnLbl: Label 'Currency Code';
        TotalLCYCptnLbl: Label 'Total (LCY)';
        CurrSpecificationCptnLbl: Label 'Currency Specification';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        Period: array[8] of DateFormula;
        NOTDUE365daysCaptionLbl: Label 'NOT DUE 365 days';
        NOTDUELs365daysCaptionLbl: Label 'NOT DUE <365 days';
        NotDueL365: Decimal;
        NotDueG365: Decimal;
        TotalOverDueCaptionLbl: Label 'Total Over Due';
        TotalARCaptionLbl: Label 'Total AR';
        NotDue: DateFormula;
        ExcelBuffer: Record 370 temporary;
        CustNo: Code[10];
        CurrCode: Code[10];
        TotalCustLedgEntry2: array[8] of Record 21;
        PrintToExcel: Boolean;
        TotalARValue: Decimal;
        WithoutTotalARValue: Decimal;
        GrandTotAmount: Decimal;
        FontNameTxt: Text;
        FontSizeInt: Integer;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := NOTDUE365daysCaptionLbl;
            HeaderText[2] := NOTDUELs365daysCaptionLbl;
            IF HeadingType = HeadingType::"Number of Days" THEN
                i := 3
            ELSE
                i := 1
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;

        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record 21)
    var
        Currency: Record 4;
    begin
        WITH TempCustLedgEntry DO BEGIN
            IF GET(CustLedgEntry."Entry No.") THEN
                EXIT;
            TempCustLedgEntry := CustLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF TempCurrency.GET('') AND ("Currency Code" = GLSetup."LCY Code") THEN
                EXIT;
            IF TempCurrency.GET(GLSetup."LCY Code") AND ("Currency Code" = '') THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := 99991231D;
            IF FIND THEN BEGIN
                Amount := Amount + TotalCustLedgEntry[1].Amount;
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := 99991231D;
                Amount := TotalCustLedgEntry[1].Amount;
                INSERT;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean; NewPeriod: array[6] of DateFormula)
    var
        i: Integer;
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
        Period[i] := NewPeriod[i];
    end;

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[2] := CALCDATE(NotDue, EndingDate);
            PeriodStartDate[2] := EndingDate + 1;

            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := PeriodEndDate[2] + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;

        FOR i := 3 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            IF i <> 8 THEN
                IF NOT EVALUATE(PeriodLength2, STRSUBSTNO(Text032, Period[i])) THEN
                    ERROR(EnterDateFormulaErr);
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            IF i <> 8 THEN
                PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;
        PeriodStartDate[i] := 0D;
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, Period[i]);
    end;

    local procedure MakeExcelHeader()
    begin
        ExcelBuffer.DELETEALL;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont('Aged Accounts Receivable', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(COMPANYNAME, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(AllAmtinLCYCptnLbl, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(CustFilter, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont('No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        IF PrintDetails THEN BEGIN
            ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        END;
        ExcelBuffer.AddColumnWithFont(HeaderText[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(HeaderText[8], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalOverDueCaptionLbl, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalARCaptionLbl, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure MakeExcelBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(CustLedgEntryEndingDate."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Due Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[1]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[2]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[3]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[4]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[5]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[6]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[7]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[3]."Remaining Amt. (LCY)" + AgedCustLedgEntry[4]."Remaining Amt. (LCY)" + AgedCustLedgEntry[5]."Remaining Amt. (LCY)"
        + AgedCustLedgEntry[6]."Remaining Amt. (LCY)" + AgedCustLedgEntry[7]."Remaining Amt. (LCY)" + AgedCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[1]."Remaining Amt. (LCY)" + AgedCustLedgEntry[2]."Remaining Amt. (LCY)" + AgedCustLedgEntry[3]."Remaining Amt. (LCY)" +
        AgedCustLedgEntry[4]."Remaining Amt. (LCY)" + AgedCustLedgEntry[5]."Remaining Amt. (LCY)"
        + AgedCustLedgEntry[6]."Remaining Amt. (LCY)" + AgedCustLedgEntry[7]."Remaining Amt. (LCY)" + AgedCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure ExcelDetails()
    begin
        WithOutPrintDetailWithPrintAmtLCY;
    end;

    local procedure WithOutPrintDetailWithPrintAmtLCY()
    begin
        CLEAR(TotalARValue);
        TotalARValue := TotalCustLedgEntry[1]."Remaining Amt. (LCY)" + TotalCustLedgEntry[2]."Remaining Amt. (LCY)" + TotalCustLedgEntry[3]."Remaining Amt. (LCY)" +
            TotalCustLedgEntry[4]."Remaining Amt. (LCY)" + TotalCustLedgEntry[5]."Remaining Amt. (LCY)" + TotalCustLedgEntry[6]."Remaining Amt. (LCY)" +
            TotalCustLedgEntry[7]."Remaining Amt. (LCY)" + TotalCustLedgEntry[8]."Remaining Amt. (LCY)";
        IF TotalARValue <> 0 THEN BEGIN
            IF PrintAmountInLCY AND (NOT PrintDetails) THEN BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumnWithFont(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                IF PrintDetails THEN BEGIN
                    ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                    ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                    ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                END;
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[2]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[4]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[5]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[6]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[7]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amt. (LCY)" + TotalCustLedgEntry[4]."Remaining Amt. (LCY)" + TotalCustLedgEntry[5]."Remaining Amt. (LCY)" +
                TotalCustLedgEntry[6]."Remaining Amt. (LCY)" + TotalCustLedgEntry[7]."Remaining Amt. (LCY)" + TotalCustLedgEntry[8]."Remaining Amt. (LCY)"
                , FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(TotalARValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            END;
        END;
    end;

    local procedure OnlyWithPrintDetail()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(CustLedgEntryEndingDate."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(FORMAT(CustLedgEntryEndingDate."Due Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[1]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[2]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[3]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[4]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[5]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[6]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[7]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[8]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[3]."Remaining Amount" + AgedCustLedgEntry[4]."Remaining Amount" + AgedCustLedgEntry[5]."Remaining Amount"
        + AgedCustLedgEntry[6]."Remaining Amount" + AgedCustLedgEntry[7]."Remaining Amount" + AgedCustLedgEntry[8]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(AgedCustLedgEntry[1]."Remaining Amount" + AgedCustLedgEntry[2]."Remaining Amount" + AgedCustLedgEntry[3]."Remaining Amount" +
        AgedCustLedgEntry[4]."Remaining Amount" + AgedCustLedgEntry[5]."Remaining Amount"
        + AgedCustLedgEntry[6]."Remaining Amount" + AgedCustLedgEntry[7]."Remaining Amount" + AgedCustLedgEntry[8]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure WithPrintDetailHeader()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(Customer.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure WithPrintDetailFooter()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(STRSUBSTNO(Text005, Customer.Name), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[2]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[4]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[5]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[6]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[7]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[8]."Remaining Amount", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amount" + TotalCustLedgEntry[4]."Remaining Amount" + TotalCustLedgEntry[5]."Remaining Amount" +
        TotalCustLedgEntry[6]."Remaining Amount" + TotalCustLedgEntry[7]."Remaining Amount" + TotalCustLedgEntry[8]."Remaining Amount"
        , FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amount" + TotalCustLedgEntry[2]."Remaining Amount" + TotalCustLedgEntry[3]."Remaining Amount"
        + TotalCustLedgEntry[4]."Remaining Amount" + TotalCustLedgEntry[5]."Remaining Amount" +
        TotalCustLedgEntry[6]."Remaining Amount" + TotalCustLedgEntry[7]."Remaining Amount" + TotalCustLedgEntry[8]."Remaining Amount"
        , FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure WithPrintDetlAndPrintAmtLCYTot()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumnWithFont(STRSUBSTNO(Text005, Customer.Name), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[2]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[4]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[5]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[6]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[7]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amt. (LCY)" + TotalCustLedgEntry[4]."Remaining Amt. (LCY)" + TotalCustLedgEntry[5]."Remaining Amt. (LCY)" +
        TotalCustLedgEntry[6]."Remaining Amt. (LCY)" + TotalCustLedgEntry[7]."Remaining Amt. (LCY)" + TotalCustLedgEntry[8]."Remaining Amt. (LCY)"
        , FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amt. (LCY)" + TotalCustLedgEntry[2]."Remaining Amt. (LCY)" + TotalCustLedgEntry[3]."Remaining Amt. (LCY)"
        + TotalCustLedgEntry[4]."Remaining Amt. (LCY)" + TotalCustLedgEntry[5]."Remaining Amt. (LCY)" +
        TotalCustLedgEntry[6]."Remaining Amt. (LCY)" + TotalCustLedgEntry[7]."Remaining Amt. (LCY)" + TotalCustLedgEntry[8]."Remaining Amt. (LCY)"
        , FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
    end;

    local procedure WithOutBothPrintAndPrintLCYFooter()
    begin
        CLEAR(WithoutTotalARValue);
        WithoutTotalARValue := TotalCustLedgEntry[1]."Remaining Amount" + TotalCustLedgEntry[2]."Remaining Amount" + TotalCustLedgEntry[3]."Remaining Amount"
          + TotalCustLedgEntry[4]."Remaining Amount" + TotalCustLedgEntry[5]."Remaining Amount" +
          TotalCustLedgEntry[6]."Remaining Amount" + TotalCustLedgEntry[7]."Remaining Amount" + TotalCustLedgEntry[8]."Remaining Amount";
        IF WithoutTotalARValue <> 0 THEN BEGIN
            ExcelBuffer.NewRow;
            ExcelBuffer.AddColumnWithFont(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(STRSUBSTNO(Text005, Customer.Name), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
            IF PrintDetails THEN BEGIN
                ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
            END;
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[1]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[2]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[4]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[5]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[6]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[7]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[8]."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(TotalCustLedgEntry[3]."Remaining Amount" + TotalCustLedgEntry[4]."Remaining Amount" + TotalCustLedgEntry[5]."Remaining Amount" +
            TotalCustLedgEntry[6]."Remaining Amount" + TotalCustLedgEntry[7]."Remaining Amount" + TotalCustLedgEntry[8]."Remaining Amount"
            , FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            ExcelBuffer.AddColumnWithFont(WithoutTotalARValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
        END;
    end;

    local procedure GrandTotalFooter()
    begin
        CLEAR(GrandTotAmount);
        GrandTotAmount := GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)" +
          GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)" +
          GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)"
          + GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)";

        IF CustFilterCheck THEN BEGIN
            IF GrandTotAmount <> 0 THEN BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumnWithFont(TotalLCYCptnLbl, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                IF PrintDetails THEN BEGIN
                    ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                    ExcelBuffer.AddColumnWithFont('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, FontNameTxt, FontSizeInt, TRUE);
                END;
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)" +
                  GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)"
                  + GrandTotalCustLedgEntry[7]."Remaining Amt. (LCY)" + GrandTotalCustLedgEntry[8]."Remaining Amt. (LCY)", FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
                ExcelBuffer.AddColumnWithFont(GrandTotAmount, FALSE, '', TRUE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number, FontNameTxt, FontSizeInt, TRUE);
            END;
        END;
    end;
}

