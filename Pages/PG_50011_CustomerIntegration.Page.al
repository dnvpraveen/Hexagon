// page 50011 CustomerIntegration
// {
//     // #NAV2017PL/032# - Sprawdzenie podatnika VAT

//     Caption = 'CustomerIntegration';
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Prices and Discounts,Navigate,Customer';
//     RefreshOnActivate = true;
//     SourceTable = Customer;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; "No.")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
//                     Visible = NoFieldVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field(Name; Name)
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer. You can enter a maximum of 50 characters, both numbers and letters.';
//                 }
//                 field("Name 2"; "Name 2")
//                 {
//                 }
//                 field("Search Name"; "Search Name")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies an alternate name that you can use to search for a customer.';
//                     Visible = false;
//                 }
//                 field("IC Partner Code"; "IC Partner Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies the customer''s IC partner code, if the customer is one of your intercompany partners.';
//                 }
//                 field("Balance (LCY)"; "Balance (LCY)")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

//                     trigger OnDrillDown()
//                     begin
//                         OpenCustomerLedgerEntries(FALSE);
//                     end;
//                 }
//                 field("Balance Due (LCY)"; "Balance Due (LCY)")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

//                     trigger OnDrillDown()
//                     begin
//                         OpenCustomerLedgerEntries(TRUE);
//                     end;
//                 }
//                 field(BalanceLCYAsVendor; BalanceAsVendor)
//                 {
//                     Caption = 'Balance (LCY) As Vendor';
//                     Description = 'NAVPL8.00';
//                     Editable = false;
//                     Enabled = BalanceAsVendorEnable;

//                     trigger OnDrillDown()
//                     var
//                         DtldVendLedgEntry: Record "380";
//                         VendLedgEntry: Record "25";
//                     begin
//                         // START/NAV2017PL/000
//                         OnBalanceLCYAsVendorDrillDown;
//                         // STOP /NAV2017PL/000
//                     end;
//                 }
//                 field("Credit Limit (LCY)"; "Credit Limit (LCY)")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';

//                     trigger OnValidate()
//                     begin
//                         StyleTxt := SetStyle;
//                     end;
//                 }
//                 field(Blocked; Blocked)
//                 {
//                     ToolTip = 'Specifies which transactions with the customer that cannot be blocked, for example, because the customer is insolvent.';
//                 }
//                 field("Salesperson Code"; "Salesperson Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
//                 }
//                 field("Responsibility Center"; "Responsibility Center")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
//                 }
//                 field("Service Zone Code"; "Service Zone Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Contains the code for the service zone that is assigned to the customer.';
//                 }
//                 field(BlockedCustomer; BlockedCustomer)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Blocked';
//                     Enabled = DynamicEditable;
//                     OptionCaption = ' ,,,All';
//                     ToolTip = 'Specifies if transactions with the customer are blocked, for example, because the customer is insolvent.';
//                     Visible = FoundationOnly;

//                     trigger OnValidate()
//                     begin
//                         IF BlockedCustomer THEN
//                             Blocked := Blocked::All
//                         ELSE
//                             Blocked := Blocked::" ";
//                     end;
//                 }
//                 field("Document Sending Profile"; "Document Sending Profile")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the preferred method of sending documents to this customer, so that you do not have to select a sending option every time that you post and send a document to the customer. Sales documents to this customer will be sent using the specified sending profile and will override the default document sending profile.';
//                 }
//                 field(TotalSales2; GetTotalSales)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Total Sales';
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding VAT on all completed and open invoices and credit memos.';
//                 }
//                 // field(CustSalesLCY -CustProfit - AdjmtCostLCY; CustSalesLCY - CustProfit - AdjmtCostLCY)
//                 // {
//                 //     ApplicationArea = Basic,Suite;
//                 //     AutoFormatType = 1;
//                 //     Caption = 'Costs (LCY)';
//                 //     ToolTip = 'Specifies how much cost you have incurred from the customer in the current fiscal year.';
//                 // }
//                 field(AdjCustProfit; AdjCustProfit)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatType = 1;
//                     Caption = 'Profit (LCY)';
//                     Editable = false;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how much profit you have made from the customer in the current fiscal year.';
//                 }
//                 field(AdjProfitPct; AdjProfitPct)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Profit %';
//                     DecimalPlaces = 1 : 1;
//                     Editable = false;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how much profit you have made from the customer in the current fiscal year, expressed as a percentage of the customer''s total sales.';
//                 }
//                 field("Language Code"; "Language Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the language to be used on printouts for this customer.';
//                 }
//                 field("Last Date Modified"; "Last Date Modified")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies when the customer card was last modified.';
//                 }
//                 field("Our Account No."; "Our Account No.")
//                 {
//                 }
//                 field("PO Box"; "PO Box")
//                 {
//                 }
//             }
//             group("Address & Contact")
//             {
//                 Caption = 'Address & Contact';
//                 group(AddressDetails)
//                 {
//                     Caption = 'Address';
//                     field(Address; Address)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
//                     }
//                     field("Address 2"; "Address 2")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies additional address information.';
//                     }
//                     field("Post Code"; "Post Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the postal code.';
//                     }
//                     field(County; County)
//                     {
//                     }
//                     field(City; City)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies the customer''s city.';
//                     }
//                     field("Country/Region Code"; "Country/Region Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies the country/region of the address.';
//                     }
//                     field(ShowMap; ShowMapLbl)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Editable = false;
//                         ShowCaption = false;
//                         Style = StrongAccent;
//                         StyleExpr = TRUE;
//                         ToolTip = 'Specifies the customer''s address on your preferred map website.';

//                         trigger OnDrillDown()
//                         begin
//                             CurrPage.UPDATE(TRUE);
//                             DisplayMap;
//                         end;
//                     }
//                 }
//                 group(ContactDetails)
//                 {
//                     Caption = 'Contact';
//                     field("Primary Contact No."; "Primary Contact No.")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Primary Contact Code';
//                         ToolTip = 'Specifies the primary contact number for the customer.';
//                     }
//                     field(ContactName; Contact)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Contact Name';
//                         Editable = ContactEditable;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';

//                         trigger OnValidate()
//                         begin
//                             ContactOnAfterValidate;
//                         end;
//                     }
//                     field("Phone No."; "Phone No.")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies the customer''s telephone number.';
//                     }
//                     field("E-Mail"; "E-Mail")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the customer''s email address.';
//                     }
//                     field("Fax No."; "Fax No.")
//                     {
//                         Importance = Additional;
//                         ToolTip = 'Specifies the customer''s fax number.';
//                     }
//                     field("Home Page"; "Home Page")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         ToolTip = 'Specifies the customer''s home page address.';
//                     }
//                 }
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Bill-to Customer No."; "Bill-to Customer No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Bill-to Customer';
//                     Importance = Additional;
//                     ToolTip = 'Specifies a different customer who will be invoiced for products that you sell to the customer in the Name field on the customer card.';
//                 }
//                 field("VAT Registration No."; "VAT Registration No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.';

//                     trigger OnDrillDown()
//                     var
//                         VATRegistrationLogMgt: Codeunit "249";
//                         VATRegistrationLog: Record "249";
//                     begin
//                         // START/NAV2017PL/032
//                         VATRegistrationLog.SETRANGE("VAT Registration No.", "VAT Registration No.");
//                         VATRegistrationLog.SETRANGE("Account Type", 0);
//                         VATRegistrationLog.SETRANGE("Country/Region Code", "Country/Region Code");
//                         IF VATRegistrationLog.ISEMPTY THEN
//                             VATRegistrationLogMgt.LogCustomer(Rec);
//                         COMMIT;
//                         // STOP /NAV2017PL/032
//                         VATRegistrationLogMgt.AssistEditCustomerVATReg(Rec);
//                     end;
//                 }
//                 field(GLN; GLN)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the customer in connection with electronic document sending.';
//                 }
//                 field("Copy Sell-to Addr. to Qte From"; "Copy Sell-to Addr. to Qte From")
//                 {
//                     ToolTip = 'Specifies which customer address is inserted on sales quotes that you create for the customer.';
//                 }
//                 field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
//                 }
//                 field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.';
//                 }
//                 field("Customer Posting Group"; "Customer Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies the customer''s market type to link business transactions to.';
//                 }
//                 field("Invoice Copies"; "Invoice Copies")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how many copies of a invoice for the customer will be printed at a time.';
//                 }
//                 group(PricesandDiscounts)
//                 {
//                     Caption = 'Prices and Discounts';
//                     field("Currency Code"; "Currency Code")
//                     {
//                         ApplicationArea = Suite;
//                         Importance = Additional;
//                         ToolTip = 'Specifies the default currency for the customer.';
//                     }
//                     field("Customer Price Group"; "Customer Price Group")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
//                     }
//                     field("Customer Disc. Group"; "Customer Disc. Group")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
//                     }
//                     field("Allow Line Disc."; "Allow Line Disc.")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Additional;
//                         ToolTip = 'Specifies if a sales line discount is calculated when a special sales price is offered according to setup in the Sales Prices window.';
//                     }
//                     field("Invoice Disc. Code"; "Invoice Disc. Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Additional;
//                         NotBlank = true;
//                         ToolTip = 'Specifies a code for the invoice discount terms that you have defined for the customer.';
//                     }
//                     field("Prices Including VAT"; "Prices Including VAT")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Additional;
//                         ToolTip = 'Specifies if the Unit Price and Line Amount fields on sales lines for this customer should be shown with or without VAT.';
//                     }
//                 }
//                 field("Fiscal Receipt"; "Fiscal Receipt")
//                 {
//                     Description = 'NAVPL8.00';
//                     Importance = Additional;
//                 }
//             }
//             group(Payments)
//             {
//                 Caption = 'Payments';
//                 field("Prepayment %"; "Prepayment %")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Contains a prepayment percentage that applies to all orders for this customer, regardless of the items or services on the order lines.';
//                 }
//                 field("Application Method"; "Application Method")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how to apply payments to entries for this customer.';
//                 }
//                 field("Partner Type"; "Partner Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies for direct debit collections if the customer that the payment is collected from is a person or a company.';
//                 }
//                 field("Payment Terms Code"; "Payment Terms Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies a code that indicates the payment terms that you require of the customer.';
//                 }
//                 field("Payment Method Code"; "Payment Method Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how the customer usually submits payment, such as bank transfer or check.';
//                 }
//                 field("Reminder Terms Code"; "Reminder Terms Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
//                 }
//                 field("Fin. Charge Terms Code"; "Fin. Charge Terms Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies finance charges are calculated for the customer.';
//                 }
//                 field("Cash Flow Payment Terms Code"; "Cash Flow Payment Terms Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies a payment term that will be used to calculate cash flow for the customer.';
//                 }
//                 field("Print Statements"; "Print Statements")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies whether to include this customer when you print the Statement report.';
//                 }
//                 field("Last Statement No."; "Last Statement No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the number of the last statement that was printed for this customer.';
//                 }
//                 field("Block Payment Tolerance"; "Block Payment Tolerance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies that the customer is not allowed a payment tolerance.';
//                 }
//                 field("Preferred Bank Account Code"; "Preferred Bank Account Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the customer''s bank account that will be used by default when you process refunds to the customer and direct debit collections.';
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Location Code"; "Location Code")
//                 {
//                     Importance = Promoted;
//                     ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
//                 }
//                 field("Combine Shipments"; "Combine Shipments")
//                 {
//                     ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
//                 }
//                 field(Reserve; Reserve)
//                 {
//                     ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer.';
//                 }
//                 field("Shipping Advice"; "Shipping Advice")
//                 {
//                     Importance = Promoted;
//                     ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
//                 }
//                 group("Shipment Method")
//                 {
//                     Caption = 'Shipment Method';
//                     field("Shipment Method Code"; "Shipment Method Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Code';
//                         Importance = Promoted;
//                         ToolTip = 'Specifies which shipment method to use when you ship items to the customer.';
//                     }
//                     field("Shipping Agent Code"; "Shipping Agent Code")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Agent';
//                         Importance = Additional;
//                         ToolTip = 'Specifies which shipping company is used when you ship items to the customer.';
//                     }
//                     field("Shipping Agent Service Code"; "Shipping Agent Service Code")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Agent Service';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the code for the shipping agent service to use for this customer.';
//                     }
//                 }
//                 field("Shipping Time"; "Shipping Time")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the shipping time of the order.';
//                 }
//                 field("Base Calendar Code"; "Base Calendar Code")
//                 {
//                     DrillDown = false;
//                     ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
//                 }
//                 field("Customized Calendar"; CalendarMgmt.CustomizedCalendarExistText(CustomizedCalendar."Source Type"::Customer, "No.", '', "Base Calendar Code"))
//                 {
//                     Caption = 'Customized Calendar';
//                     Editable = false;
//                     ToolTip = 'Specifies that you have set up a customized version of a base calendar.';

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.SAVERECORD;
//                         TESTFIELD("Base Calendar Code");
//                         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, "No.", '', "Base Calendar Code");
//                     end;
//                 }
//                 field("Transaction Type"; "Transaction Type")
//                 {
//                     Description = 'NAVPL8.00';
//                 }
//                 field("Transaction Specification"; "Transaction Specification")
//                 {
//                     Description = 'NAVPL8.00';
//                 }
//                 field("Transport Method"; "Transport Method")
//                 {
//                     Description = 'NAVPL8.00';
//                 }
//             }
//             group(Statistics)
//             {
//                 Caption = 'Statistics';
//                 Editable = false;
//                 Visible = FoundationOnly;
//                 group(Balance)
//                 {
//                     Caption = 'Balance';
//                     field("Balance (LCY)2"; "Balance (LCY)")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Money Owed - Current';
//                         ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';
//                     }
//                     field(GetMoneyOwedExpected; GetMoneyOwedExpected)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Money Owed - Expected';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the payment amount that the customer will owe when ongoing sales invoices and credit memos are completed.';

//                         trigger OnDrillDown()
//                         begin
//                             CustomerMgt.DrillDownMoneyOwedExpected("No.");
//                         end;
//                     }
//                     field(TotalMoneyOwed; "Balance (LCY)" + GetMoneyOwedExpected)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Money Owed - Total';
//                         Style = Strong;
//                         StyleExpr = TRUE;
//                         ToolTip = 'Specifies the payment amount that the customer owes for completed sales plus sales that are still ongoing. The value is the sum of the values in the Money Owed - Current and Money Owed - Expected fields.';
//                     }
//                     field(CreditLimit; "Credit Limit (LCY)")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Credit Limit';
//                         ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
//                     }
//                     field(CalcCreditLimitLCYExpendedPct; CalcCreditLimitLCYExpendedPct)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Usage Of Credit Limit';
//                         ExtendedDatatype = Ratio;
//                         Style = Attention;
//                         StyleExpr = BalanceExhausted;
//                         ToolTip = 'Specifies how much of the customer''s payment balance consists of credit.';
//                     }
//                 }
//                 group(Payments)
//                 {
//                     Caption = 'Payments';
//                     field("Balance Due"; CalcOverdueBalance)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         CaptionClass = FORMAT(STRSUBSTNO(OverduePaymentsMsg, FORMAT(WORKDATE)));
//                         ToolTip = 'Specifies the sum of outstanding payments from the customer.';

//                         trigger OnDrillDown()
//                         var
//                             DtldCustLedgEntry: Record "379";
//                             CustLedgEntry: Record "21";
//                         begin
//                             DtldCustLedgEntry.SETFILTER("Customer No.", "No.");
//                             COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
//                             COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
//                             COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
//                             CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
//                         end;
//                     }
//                     field("Payments (LCY)"; "Payments (LCY)")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Payments This Year';
//                         ToolTip = 'Specifies the sum of payments received from the customer in the current fiscal year.';
//                     }
//                     // field(CustomerMgt.AvgDaysToPay("No.");
//                     //     CustomerMgt.AvgDaysToPay("No."))
//                     // {
//                     //     ApplicationArea = Basic,Suite;
//                     //     Caption = 'Average Collection Period (Days)';
//                     //     DecimalPlaces = 0 : 1;
//                     //     Importance = Additional;
//                     //     ToolTip = 'Specifies how long the customer typically takes to pay invoices in the current fiscal year.';
//                     // }
//                     field(DaysPaidPastDueDate; DaysPastDueDate)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Average Late Payments (Days)';
//                         DecimalPlaces = 0 : 1;
//                         Importance = Additional;
//                         Style = Attention;
//                         StyleExpr = AttentionToPaidDay;
//                         ToolTip = 'Specifies the average number of days the customer is late with payments.';
//                     }
//                 }
//                 group("Sales This Year")
//                 {
//                     Caption = 'Sales This Year';
//                     field(GetAmountOnPostedInvoices; GetAmountOnPostedInvoices)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         CaptionClass = STRSUBSTNO(PostedInvoicesMsg, FORMAT(NoPostedInvoices));
//                         ToolTip = 'Specifies your sales to the customer in the current fiscal year based on posted sales invoices. The figure in parenthesis Specifies the number of posted sales invoices.';

//                         trigger OnDrillDown()
//                         begin
//                             CustomerMgt.DrillDownOnPostedInvoices("No.")
//                         end;
//                     }
//                     field(GetAmountOnCrMemo; GetAmountOnCrMemo)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         CaptionClass = STRSUBSTNO(CreditMemosMsg, FORMAT(NoPostedCrMemos));
//                         ToolTip = 'Specifies your expected refunds to the customer in the current fiscal year based on posted sales credit memos. The figure in parenthesis shows the number of posted sales credit memos.';

//                         trigger OnDrillDown()
//                         begin
//                             CustomerMgt.DrillDownOnPostedCrMemo("No.")
//                         end;
//                     }
//                     field(GetAmountOnOutstandingInvoices; GetAmountOnOutstandingInvoices)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         CaptionClass = STRSUBSTNO(OutstandingInvoicesMsg, FORMAT(NoOutstandingInvoices));
//                         ToolTip = 'Specifies your expected sales to the customer in the current fiscal year based on ongoing sales invoices. The figure in parenthesis shows the number of ongoing sales invoices.';

//                         trigger OnDrillDown()
//                         begin
//                             CustomerMgt.DrillDownOnUnpostedInvoices("No.")
//                         end;
//                     }
//                     field(GetAmountOnOutstandingCrMemos; GetAmountOnOutstandingCrMemos)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         CaptionClass = STRSUBSTNO(OutstandingCrMemosMsg, FORMAT(NoOutstandingCrMemos));
//                         ToolTip = 'Specifies your refunds to the customer in the current fiscal year based on ongoing sales credit memos. The figure in parenthesis shows the number of ongoing sales credit memos.';

//                         trigger OnDrillDown()
//                         begin
//                             CustomerMgt.DrillDownOnUnpostedCrMemos("No.")
//                         end;
//                     }
//                     field(Totals; Totals)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Total Sales';
//                         Style = Strong;
//                         StyleExpr = TRUE;
//                         ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding VAT on all completed and open invoices and credit memos.';
//                     }
//                     field(CustInvDiscAmountLCY; CustInvDiscAmountLCY)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Invoice Discounts';
//                         ToolTip = 'Specifies the total of all invoice discounts that you have granted to the customer in the current fiscal year.';
//                     }
//                 }
//                 part(AgedAccReceivableChart; 768)
//                 {
//                     SubPageLink = "No." = FIELD("No.");
//                     Visible = ShowCharts;
//                 }
//             }
//             part(PriceAndLineDisc; 1345)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Special Prices & Discounts';
//                 Visible = FoundationOnly;
//             }
//         }
//         area(factboxes)
//         {
//             part(t; 785)
//             {
//                 ApplicationArea = Basic, Suite;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = NOT IsOfficeAddin;
//             }
//             part(Details; 1611)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Details';
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = IsOfficeAddin;
//             }
//             part(AgedAccReceivableChart2; 768)
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = IsOfficeAddin;
//             }
//             part(CRMI; 5360)
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = CRMIsCoupledToRecord;
//             }
//             part(Social; 875)
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Source Type" = CONST(Customer),
//                               "Source No." = FIELD("No.");
//                 Visible = SocialListeningVisible;
//             }
//             part(Test2; 876)
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Source Type" = CONST(Customer),
//                               "Source No." = FIELD("No.");
//                 UpdatePropagation = Both;
//                 Visible = SocialListeningSetupVisible;
//             }
//             part(SalesHistSelltoFactBox; 9080)
//             {
//                 ApplicationArea = Basic, Suite;
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//             }
//             part(SalesHistBilltoFactBox; 9081)
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = false;
//             }
//             part(CustomerStatisticsFactBox; 9082)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//             }
//             part(Test2; 9083)
//             {
//                 SubPageLink = "Table ID" = CONST(18),
//                               "No." = FIELD("No.");
//             }
//             part(Test3; 9085)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = false;
//             }
//             part(; 9086)
//             {
//                 SubPageLink = No.=FIELD(No.),
//                               Currency Filter=FIELD(Currency Filter),
//                               Date Filter=FIELD(Date Filter),
//                               Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
//                               Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
//                 Visible = false;
//             }
//             part(WorkflowStatus;1528)
//             {
//                 ApplicationArea = Suite;
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(;Links)
//             {
//             }
//             systempart(;Notes)
//             {
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Customer")
//             {
//                 Caption = '&Customer';
//                 Image = Customer;
//                 action(Dimensions)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page 540;
//                                     RunPageLink = Table ID=CONST(18),
//                                   No.=FIELD(No.);
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
//                 }
//                 action("Bank Accounts")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Bank Accounts';
//                     Image = BankAccount;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedOnly = true;
//                     RunObject = Page 424;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     ToolTip = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.';
//                 }
//                 action("Direct Debit Mandates")
//                 {
//                     Caption = 'Direct Debit Mandates';
//                     Image = MakeAgreement;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedOnly = true;
//                     RunObject = Page 1230;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     ToolTip = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.';
//                 }
//                 action(ShipToAddresses)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Ship-&to Addresses';
//                     Image = ShipAddress;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedOnly = true;
//                     RunObject = Page 301;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     ToolTip = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.';
//                 }
//                 action(Contact)
//                 {
//                     AccessByPermission = TableData 5050=R;
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'C&ontact';
//                     Image = ContactPerson;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'View or edit detailed information about the contact person at the customer.';

//                     trigger OnAction()
//                     begin
//                         ShowContact;
//                     end;
//                 }
//                 action("Cross Re&ferences")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Cross Re&ferences';
//                     Image = Change;
//                     RunObject = Page 5723;
//                                     RunPageLink = Cross-Reference Type=CONST(Customer),
//                                   Cross-Reference Type No.=FIELD(No.);
//                     RunPageView = SORTING(Cross-Reference Type,Cross-Reference Type No.);
//                     ToolTip = 'Set up the customer''s own identification of items that you sell to the customer. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 124;
//                                     RunPageLink = Table Name=CONST(Customer),
//                                   No.=FIELD(No.);
//                 }
//                 action(ApprovalEntries)
//                 {
//                     AccessByPermission = TableData 454=R;
//                     ApplicationArea = Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedOnly = true;
//                     ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

//                     trigger OnAction()
//                     begin
//                         ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
//                     end;
//                 }
//                 action(CustomerReportSelections)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Document Layouts';
//                     Image = Quote;
//                     ToolTip = 'Set up a layout for different types of documents such as invoices, quotes, and credit memos.';

//                     trigger OnAction()
//                     var
//                         CustomReportSelection: Record "9657";
//                     begin
//                         CustomReportSelection.SETRANGE("Source Type",DATABASE::Customer);
//                         CustomReportSelection.SETRANGE("Source No.","No.");
//                         PAGE.RUNMODAL(PAGE::"Customer Report Selections",CustomReportSelection);
//                     end;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 action(CRMGotoAccount)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Account';
//                     Image = CoupledCustomer;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
//                     begin
//                         CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
//                     end;
//                 }
//                 action(CRMSynchronizeNow)
//                 {
//                     AccessByPermission = TableData 5331=IM;
//                     ApplicationArea = All;
//                     Caption = 'Synchronize Now';
//                     Image = Refresh;
//                     ToolTip = 'Send or get updated data to or from Microsoft Dynamics CRM.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
//                     begin
//                         CRMIntegrationManagement.UpdateOneNow(RECORDID);
//                     end;
//                 }
//                 action(UpdateStatisticsInCRM)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Update Account Statistics';
//                     Enabled = CRMIsCoupledToRecord;
//                     Image = UpdateXML;
//                     ToolTip = 'Send customer statistics data to Dynamics CRM to update the Account Statistics FactBox.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
//                     begin
//                         CRMIntegrationManagement.CreateOrUpdateCRMAccountStatistics(Rec);
//                     end;
//                 }
//                 group(Coupling)
//                 {
//                     Caption = 'Coupling', Comment='Coupling is a noun';
//                     Image = LinkAccount;
//                     ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
//                     action(ManageCRMCoupling)
//                     {
//                         AccessByPermission = TableData 5331=IM;
//                         ApplicationArea = All;
//                         Caption = 'Set Up Coupling';
//                         Image = LinkAccount;
//                         ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM account.';

//                         trigger OnAction()
//                         var
//                             CRMIntegrationManagement: Codeunit "5330";
//                         begin
//                             CRMIntegrationManagement.DefineCoupling(RECORDID);
//                         end;
//                     }
//                     action(DeleteCRMCoupling)
//                     {
//                         AccessByPermission = TableData 5331=IM;
//                         ApplicationArea = All;
//                         Caption = 'Delete Coupling';
//                         Enabled = CRMIsCoupledToRecord;
//                         Image = UnLinkAccount;
//                         ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM account.';

//                         trigger OnAction()
//                         var
//                             CRMCouplingManagement: Codeunit "5331";
//                         begin
//                             CRMCouplingManagement.RemoveCoupling(RECORDID);
//                         end;
//                     }
//                 }
//             }
//             group(History)
//             {
//                 Caption = 'History';
//                 Image = History;
//                 action("Ledger E&ntries")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Ledger E&ntries';
//                     Image = CustomerLedger;
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     RunObject = Page 25;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Customer No.)
//                                   ORDER(Descending);
//                     ShortCutKey = 'Ctrl+F7';
//                     ToolTip = 'View the history of transactions that have been posted for the selected record.';
//                 }
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     RunObject = Page 151;
//                                     RunPageLink = No.=FIELD(No.),
//                                   Date Filter=FIELD(Date Filter),
//                                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
//                                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
//                     ShortCutKey = 'F7';
//                 }
//                 action("S&ales")
//                 {
//                     Caption = 'S&ales';
//                     Image = Sales;
//                     RunObject = Page 155;
//                                     RunPageLink = No.=FIELD(No.),
//                                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
//                                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
//                 }
//                 action("Entry Statistics")
//                 {
//                     Caption = 'Entry Statistics';
//                     Image = EntryStatistics;
//                     RunObject = Page 302;
//                                     RunPageLink = No.=FIELD(No.),
//                                   Date Filter=FIELD(Date Filter),
//                                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
//                                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
//                 }
//                 action("Statistics by C&urrencies")
//                 {
//                     Caption = 'Statistics by C&urrencies';
//                     Image = Currencies;
//                     RunObject = Page 486;
//                                     RunPageLink = Customer Filter=FIELD(No.),
//                                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
//                                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
//                                   Date Filter=FIELD(Date Filter);
//                 }
//                 action("Item &Tracking Entries")
//                 {
//                     Caption = 'Item &Tracking Entries';
//                     Image = ItemTrackingLedger;

//                     trigger OnAction()
//                     var
//                         ItemTrackingDocMgt: Codeunit "6503";
//                     begin
//                         ItemTrackingDocMgt.ShowItemTrackingForMasterData(1,"No.",'','','','','');
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("Prices and Discounts")
//             {
//                 Caption = 'Prices and Discounts';
//                 action("Invoice &Discounts")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Invoice &Discounts';
//                     Image = CalculateInvoiceDiscount;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Category7;
//                     RunObject = Page 23;
//                                     RunPageLink = Code=FIELD(Invoice Disc. Code);
//                     ToolTip = 'Set up different discounts that are applied to invoices for the customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.';
//                 }
//                 action(Prices)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Prices';
//                     Image = Price;
//                     RunObject = Page 7002;
//                                     RunPageLink = Sales Type=CONST(Customer),
//                                   Sales Code=FIELD(No.);
//                     RunPageView = SORTING(Sales Type,Sales Code);
//                     ToolTip = 'View or set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
//                 }
//                 action("Line Discounts")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Line Discounts';
//                     Image = LineDiscount;
//                     RunObject = Page 7004;
//                                     RunPageLink = Sales Type=CONST(Customer),
//                                   Sales Code=FIELD(No.);
//                     RunPageView = SORTING(Sales Type,Sales Code);
//                     ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
//                 }
//             }
//             group("S&ales")
//             {
//                 Caption = 'S&ales';
//                 Image = Sales;
//                 action("Prepa&yment Percentages")
//                 {
//                     Caption = 'Prepa&yment Percentages';
//                     Image = PrepaymentPercentages;
//                     RunObject = Page 664;
//                                     RunPageLink = Sales Type=CONST(Customer),
//                                   Sales Code=FIELD(No.);
//                     RunPageView = SORTING(Sales Type,Sales Code);
//                 }
//                 action("Recurring Sales Lines")
//                 {
//                     Caption = 'Recurring Sales Lines';
//                     Ellipsis = true;
//                     Image = CustomerCode;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Category5;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
//                     RunObject = Page 173;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     ToolTip = 'Set up recurring sales lines for the customer, such as a monthly replenishment order, that can quickly be inserted on a sales document for the customer.';
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action(Quotes)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Quotes';
//                     Image = Quote;
//                     RunObject = Page 9300;
//                                     RunPageLink = Sell-to Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Document Type,Sell-to Customer No.);
//                     ToolTip = 'View a list of ongoing sales quotes for the customer.';
//                 }
//                 action(Orders)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Orders';
//                     Image = Document;
//                     RunObject = Page 9305;
//                                     RunPageLink = Sell-to Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Document Type,Sell-to Customer No.);
//                     ToolTip = 'View a list of ongoing sales orders for the customer.';
//                 }
//                 action("Return Orders")
//                 {
//                     Caption = 'Return Orders';
//                     Image = ReturnOrder;
//                     RunObject = Page 9304;
//                                     RunPageLink = Sell-to Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Document Type,Sell-to Customer No.);
//                 }
//                 group("Issued Documents")
//                 {
//                     Caption = 'Issued Documents';
//                     Image = Documents;
//                     action("Issued &Reminders")
//                     {
//                         Caption = 'Issued &Reminders';
//                         Image = OrderReminder;
//                         RunObject = Page 440;
//                                         RunPageLink = Customer No.=FIELD(No.);
//                         RunPageView = SORTING(Customer No.,Posting Date);
//                         ToolTip = 'View the reminders that you have sent to the customer.';
//                     }
//                     action("Issued &Finance Charge Memos")
//                     {
//                         Caption = 'Issued &Finance Charge Memos';
//                         Image = FinChargeMemo;
//                         RunObject = Page 452;
//                                         RunPageLink = Customer No.=FIELD(No.);
//                         RunPageView = SORTING(Customer No.,Posting Date);
//                         ToolTip = 'View the finance charge memos that you have sent to the customer.';
//                     }
//                 }
//                 action("Blanket Orders")
//                 {
//                     Caption = 'Blanket Orders';
//                     Image = BlanketOrder;
//                     RunObject = Page 9303;
//                                     RunPageLink = Sell-to Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Document Type,Sell-to Customer No.);
//                 }
//                 action("&Jobs")
//                 {
//                     Caption = '&Jobs';
//                     Image = Job;
//                     RunObject = Page 89;
//                                     RunPageLink = Bill-to Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Bill-to Customer No.);
//                 }
//             }
//             group(Service)
//             {
//                 Caption = 'Service';
//                 Image = ServiceItem;
//                 action("Service Orders")
//                 {
//                     Caption = 'Service Orders';
//                     Image = Document;
//                     RunObject = Page 9318;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Document Type,Customer No.);
//                 }
//                 action("Ser&vice Contracts")
//                 {
//                     Caption = 'Ser&vice Contracts';
//                     Image = ServiceAgreement;
//                     RunObject = Page 6065;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Customer No.,Ship-to Code);
//                 }
//                 action("Service &Items")
//                 {
//                     Caption = 'Service &Items';
//                     Image = ServiceItem;
//                     RunObject = Page 5988;
//                                     RunPageLink = Customer No.=FIELD(No.);
//                     RunPageView = SORTING(Customer No.,Ship-to Code,Item No.,Serial No.);
//                 }
//             }
//         }
//         area(creation)
//         {
//             action(NewBlanketSalesOrder)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 Caption = 'Blanket Sales Order';
//                 Image = BlanketOrder;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 507;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a blanket sales order for the customer.';
//             }
//             action(NewSalesQuote)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Sales Quote';
//                 Image = NewSalesQuote;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedOnly = true;
//                 RunObject = Page 41;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a new sales quote where you offer items or services to a customer.';
//             }
//             action(NewSalesInvoice)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Sales Invoice';
//                 Image = NewSalesInvoice;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedOnly = true;
//                 RunObject = Page 43;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a sales invoice for the customer.';
//             }
//             action(NewSalesOrder)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Sales Order';
//                 Image = Document;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedOnly = true;
//                 RunObject = Page 42;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a sales order for the customer.';
//             }
//             action(NewSalesCreditMemo)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Sales Credit Memo';
//                 Image = CreditMemo;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedOnly = true;
//                 RunObject = Page 44;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
//             }
//             action(NewSalesReturnOrder)
//             {
//                 AccessByPermission = TableData 36=RIM;
//                 Caption = 'Sales Return Order';
//                 Image = ReturnOrder;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 6630;
//                                 RunPageLink = Sell-to Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a sales return order for the customer.';
//             }
//             action(NewServiceQuote)
//             {
//                 AccessByPermission = TableData 5900=RIM;
//                 Caption = 'Service Quote';
//                 Image = Quote;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 5964;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a service quote for the customer.';
//             }
//             action(NewServiceInvoice)
//             {
//                 AccessByPermission = TableData 5900=RIM;
//                 Caption = 'Service Invoice';
//                 Image = Invoice;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 5933;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a service invoice for the customer.';
//             }
//             action(NewServiceOrder)
//             {
//                 AccessByPermission = TableData 5900=RIM;
//                 Caption = 'Service Order';
//                 Image = Document;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 5900;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a service order for the customer.';
//             }
//             action(NewServiceCreditMemo)
//             {
//                 AccessByPermission = TableData 5900=RIM;
//                 Caption = 'Service Credit Memo';
//                 Image = CreditMemo;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 5935;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a service credit memo for the customer.';
//             }
//             action(NewReminder)
//             {
//                 AccessByPermission = TableData 295=RIM;
//                 Caption = 'Reminder';
//                 Image = Reminder;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 RunObject = Page 434;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a remainder for the customer.';
//             }
//             action(NewFinanceChargeMemo)
//             {
//                 AccessByPermission = TableData 302=RIM;
//                 Caption = 'Finance Charge Memo';
//                 Image = FinChargeMemo;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category4;
//                 RunObject = Page 446;
//                                 RunPageLink = Customer No.=FIELD(No.);
//                 RunPageMode = Create;
//                 ToolTip = 'Create a finance charge memo for the customer.';
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 Visible = OpenApprovalEntriesExistCurrUser;
//                 action(Approve)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     ToolTip = 'Approve the requested changes.';
//                     Visible = OpenApprovalEntriesExistCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     ToolTip = 'Reject the approval request.';
//                     Visible = OpenApprovalEntriesExistCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     ToolTip = 'Delegate the approval to a substitute approver.';
//                     Visible = OpenApprovalEntriesExistCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     ToolTip = 'View or add comments.';
//                     Visible = OpenApprovalEntriesExistCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.GetApprovalComment(Rec);
//                     end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = SendApprovalRequest;
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedOnly = true;
//                     ToolTip = 'Send an approval request.';

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendCustomerForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = CanCancelApprovalForRecord;
//                     Image = CancelApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedOnly = true;
//                     ToolTip = 'Cancel the approval request.';

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group(Workflow)
//             {
//                 Caption = 'Workflow';
//                 action(CreateApprovalWorkflow)
//                 {
//                     Caption = 'Create Approval Workflow';
//                     Enabled = NOT EnabledApprovalWorkflowsExist;
//                     Image = CreateWorkflow;
//                     ToolTip = 'Set up an approval workflow for creating or changing customers, by going through a few pages that will guide you.';

//                     trigger OnAction()
//                     begin
//                         PAGE.RUNMODAL(PAGE::"Cust. Approval WF Setup Wizard");
//                     end;
//                 }
//                 action(ManageApprovalWorkflows)
//                 {
//                     Caption = 'Manage Approval Workflows';
//                     Enabled = EnabledApprovalWorkflowsExist;
//                     Image = WorkflowSetup;
//                     ToolTip = 'View or edit existing approval workflows for creating or changing customers.';

//                     trigger OnAction()
//                     var
//                         WorkflowManagement: Codeunit "1501";
//                     begin
//                         WorkflowManagement.NavigateToWorkflows(DATABASE::Customer,EventFilter);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Get BIR Data")
//                 {
//                     Caption = 'Get BIR Data';
//                     Description = 'NAV2016PL/052';
//                     Image = LaunchWeb;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         BIRData: Record "52063130";
//                     begin
//                         // START/NAV2016PL/052
//                         //BIRData.GetCustomerBIRData(Rec);
//                         // STOP /NAV2016PL/052
//                     end;
//                 }
//                 action(Templates)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Templates';
//                     Image = Template;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
//                     RunObject = Page 1340;
//                                     RunPageLink = Table ID=CONST(18);
//                                     ToolTip = 'View or edit customer templates.';
//                 }
//                 action(ApplyTemplate)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Apply Template';
//                     Ellipsis = true;
//                     Image = ApplyTemplate;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     ToolTip = 'Apply a customer template to quickly register this customer.';

//                     trigger OnAction()
//                     var
//                         MiniCustomerTemplate: Record "1300";
//                     begin
//                         MiniCustomerTemplate.UpdateCustomerFromTemplate(Rec);
//                     end;
//                 }
//                 action(SaveAsTemplate)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Save as Template';
//                     Ellipsis = true;
//                     Image = Save;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
//                     ToolTip = 'Save the customer card as a template that can be reused to create new customer cards. Customer templates contain preset information to help you fill fields on customer cards.';

//                     trigger OnAction()
//                     var
//                         TempMiniCustomerTemplate: Record "1300" temporary;
//                     begin
//                         TempMiniCustomerTemplate.SaveAsTemplate(Rec);
//                     end;
//                 }
//             }
//             action("Post Cash Receipts")
//             {
//                 Caption = 'Post Cash Receipts';
//                 Ellipsis = true;
//                 Image = CashReceiptJournal;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Page 255;
//                                 ToolTip = 'Create a cash receipt journal line for the customer, for example, to post a payment receipt.';
//             }
//             action("Sales Journal")
//             {
//                 Caption = 'Sales Journal';
//                 Image = Journals;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Page 253;
//             }
//         }
//         area(reporting)
//         {
//             action("Report Customer Detailed Aging")
//             {
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Customer Detailed Aging';
//                 Image = "Report";
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = "Report";
//                 ToolTip = 'View a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';

//                 trigger OnAction()
//                 begin
//                     RunReport(REPORT::"Customer Detailed Aging","No.");
//                 end;
//             }
//             action("Report Customer - Labels")
//             {
//                 Caption = 'Customer - Labels';
//                 Image = "Report";
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = "Report";
//                 ToolTip = 'View mailing labels with the customers'' names and addresses.';

//                 trigger OnAction()
//                 begin
//                     RunReport(REPORT::"Customer - Labels","No.");
//                 end;
//             }
//             action("Report Customer - Balance to Date")
//             {
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Customer - Balance to Date';
//                 Image = "Report";
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = "Report";
//                 ToolTip = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';

//                 trigger OnAction()
//                 begin
//                     RunReport(REPORT::"Customer - Balance to Date","No.");
//                 end;
//             }
//             action("Report Statement")
//             {
//                 ApplicationArea = Basic,Suite;
//                 Caption = 'Statement';
//                 Image = "Report";
//                 RunObject = Codeunit 8810;
//                 ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         CRMCouplingManagement: Codeunit "5331";
//         WorkflowManagement: Codeunit "1501";
//         WorkflowEventHandling: Codeunit "1520";
//     begin
//         CreateCustomerFromTemplate;
//         ActivateFields;
//         StyleTxt := SetStyle;

//         // START/NAV2015PL/000
//         CalcBalanceAsVendor;
//         // STOP /NAV2015PL/000

//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//         CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
//         OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//         GetSalesPricesAndSalesLineDisc;
//         DynamicEditable := CurrPage.EDITABLE;

//         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

//         EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
//           WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;

//         EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer,EventFilter);
//     end;

//     trigger OnAfterGetRecord()
//     var
//         AgedAccReceivable: Codeunit "763";
//     begin
//         ActivateFields;
//         StyleTxt := SetStyle;
//         BlockedCustomer := (Blocked = Blocked::All);
//         BalanceExhausted := 10000 <= CalcCreditLimitLCYExpendedPct;
//         DaysPastDueDate := AgedAccReceivable.InvoicePaymentDaysAverage("No.");
//         AttentionToPaidDay := DaysPastDueDate > 0;
//     end;

//     trigger OnInit()
//     var
//         ApplicationAreaSetup: Record "9178";
//     begin
//         FoundationOnly := ApplicationAreaSetup.IsFoundationEnabled;

//         SetCustomerNoVisibilityOnFactBoxes;

//         ContactEditable := TRUE;

//         OpenApprovalEntriesExistCurrUser := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     var
//         DocumentNoVisibility: Codeunit "1400";
//     begin
//         IF GUIALLOWED THEN
//           IF "No." = '' THEN
//             IF DocumentNoVisibility.CustomerNoSeriesIsDefault THEN
//               NewMode := TRUE;
//     end;

//     trigger OnOpenPage()
//     var
//         CRMIntegrationManagement: Codeunit "5330";
//         OfficeManagement: Codeunit "1630";
//     begin
//         ActivateFields;

//         CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
//         SetNoFieldVisible;
//         IsOfficeAddin := OfficeManagement.IsAvailable;

//         CurrPage.PriceAndLineDisc.PAGE.InitPage(FALSE);

//         ShowCharts := "No." <> '';
//         IF ShowCharts THEN BEGIN
//           CurrPage.AgedAccReceivableChart.PAGE.SetPerCustomer;
//           CurrPage.AgedAccReceivableChart2.PAGE.SetPerCustomer;
//         END;
//         SETFILTER("Date Filter",CustomerMgt.GetCurrentYearFilter);
//     end;

//     var
//         CustomizedCalEntry: Record "7603";
//         CustomizedCalendar: Record "7602";
//         CalendarMgmt: Codeunit "7600";
//         ApprovalsMgmt: Codeunit "1535";
//         CustomerMgt: Codeunit "1302";
//         StyleTxt: Text;
//         BlockedCustomer: Boolean;
//         [InDataSet]
//         ContactEditable: Boolean;
//         [InDataSet]
//         SocialListeningSetupVisible: Boolean;
//         [InDataSet]
//         SocialListeningVisible: Boolean;
//         [InDataSet]
//         ShowCharts: Boolean;
//         CRMIntegrationEnabled: Boolean;
//         CRMIsCoupledToRecord: Boolean;
//         OpenApprovalEntriesExistCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         ShowWorkflowStatus: Boolean;
//         NoFieldVisible: Boolean;
//         BalanceExhausted: Boolean;
//         AttentionToPaidDay: Boolean;
//         DynamicEditable: Boolean;
//         IsOfficeAddin: Boolean;
//         NoPostedInvoices: Integer;
//         NoPostedCrMemos: Integer;
//         NoOutstandingInvoices: Integer;
//         NoOutstandingCrMemos: Integer;
//         Totals: Decimal;
//         AmountOnPostedInvoices: Decimal;
//         AmountOnPostedCrMemos: Decimal;
//         AmountOnOutstandingInvoices: Decimal;
//         AmountOnOutstandingCrMemos: Decimal;
//         AdjmtCostLCY: Decimal;
//         AdjCustProfit: Decimal;
//         CustProfit: Decimal;
//         AdjProfitPct: Decimal;
//         CustInvDiscAmountLCY: Decimal;
//         CustPaymentsLCY: Decimal;
//         CustSalesLCY: Decimal;
//         OverduePaymentsMsg: Label 'Overdue Payments as of %1', Comment='Overdue Payments as of 27-02-2012';
//         DaysPastDueDate: Decimal;
//         PostedInvoicesMsg: Label 'Posted Invoices (%1)', Comment='Invoices (5)';
//         CreditMemosMsg: Label 'Posted Credit Memos (%1)', Comment='Credit Memos (3)';
//         OutstandingInvoicesMsg: Label 'Ongoing Invoices (%1)', Comment='Ongoing Invoices (4)';
//         OutstandingCrMemosMsg: Label 'Ongoing Credit Memos (%1)', Comment='Ongoing Credit Memos (4)';
//         ShowMapLbl: Label 'Show on Map';
//         FoundationOnly: Boolean;
//         CanCancelApprovalForRecord: Boolean;
//         EnabledApprovalWorkflowsExist: Boolean;
//         NewMode: Boolean;
//         EventFilter: Text;
//         BalanceAsVendor: Decimal;
//         BalanceAsVendorEnable: Boolean;

//     local procedure GetTotalSales(): Decimal
//     begin
//         NoPostedInvoices := 0;
//         NoPostedCrMemos := 0;
//         NoOutstandingInvoices := 0;
//         NoOutstandingCrMemos := 0;
//         Totals := 0;

//         AmountOnPostedInvoices := CustomerMgt.CalcAmountsOnPostedInvoices("No.",NoPostedInvoices);
//         AmountOnPostedCrMemos := CustomerMgt.CalcAmountsOnPostedCrMemos("No.",NoPostedCrMemos);

//         AmountOnOutstandingInvoices := CustomerMgt.CalculateAmountsOnUnpostedInvoices("No.",NoOutstandingInvoices);
//         AmountOnOutstandingCrMemos := CustomerMgt.CalculateAmountsOnUnpostedCrMemos("No.",NoOutstandingCrMemos);

//         Totals := AmountOnPostedInvoices + AmountOnPostedCrMemos + AmountOnOutstandingInvoices + AmountOnOutstandingCrMemos;

//         CustomerMgt.CalculateStatistic(
//           Rec,
//           AdjmtCostLCY,AdjCustProfit,AdjProfitPct,
//           CustInvDiscAmountLCY,CustPaymentsLCY,CustSalesLCY,
//           CustProfit);
//         EXIT(Totals)
//     end;

//     local procedure GetAmountOnPostedInvoices(): Decimal
//     begin
//         EXIT(AmountOnPostedInvoices)
//     end;

//     local procedure GetAmountOnCrMemo(): Decimal
//     begin
//         EXIT(AmountOnPostedCrMemos)
//     end;

//     local procedure GetAmountOnOutstandingInvoices(): Decimal
//     begin
//         EXIT(AmountOnOutstandingInvoices)
//     end;

//     local procedure GetAmountOnOutstandingCrMemos(): Decimal
//     begin
//         EXIT(AmountOnOutstandingCrMemos)
//     end;

//     local procedure GetMoneyOwedExpected(): Decimal
//     begin
//         EXIT(CustomerMgt.CalculateAmountsWithVATOnUnpostedDocuments("No."))
//     end;

//     local procedure GetSalesPricesAndSalesLineDisc()
//     begin
//         IF "No." <> CurrPage.PriceAndLineDisc.PAGE.GetLoadedCustNo THEN BEGIN
//           CurrPage.PriceAndLineDisc.PAGE.LoadCustomer(Rec);
//           CurrPage.PriceAndLineDisc.PAGE.UPDATE(FALSE);
//         END;
//     end;

//     local procedure ActivateFields()
//     begin
//         SetSocialListeningFactboxVisibility;
//         ContactEditable := "Primary Contact No." = '';
//     end;

//     local procedure ContactOnAfterValidate()
//     begin
//         ActivateFields;
//     end;

//     local procedure SetSocialListeningFactboxVisibility()
//     var
//         SocialListeningMgt: Codeunit "871";
//     begin
//         SocialListeningMgt.GetCustFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
//     end;

//     local procedure SetNoFieldVisible()
//     var
//         DocumentNoVisibility: Codeunit "1400";
//     begin
//         NoFieldVisible := DocumentNoVisibility.CustomerNoIsVisible;
//     end;

//     local procedure SetCustomerNoVisibilityOnFactBoxes()
//     begin
//         CurrPage.SalesHistSelltoFactBox.PAGE.SetCustomerNoVisibility(FALSE);
//         CurrPage.SalesHistBilltoFactBox.PAGE.SetCustomerNoVisibility(FALSE);
//         CurrPage.CustomerStatisticsFactBox.PAGE.SetCustomerNoVisibility(FALSE);
//     end;

//     [Scope('Internal')]
//     procedure RunReport(ReportNumber: Integer;CustomerNumber: Code[20])
//     var
//         Customer: Record "18";
//     begin
//         Customer.SETRANGE("No.",CustomerNumber);
//         REPORT.RUNMODAL(ReportNumber,TRUE,TRUE,Customer);
//     end;

//     local procedure CreateCustomerFromTemplate()
//     var
//         MiniCustomerTemplate: Record "1300";
//         Customer: Record "18";
//     begin
//         IF NewMode THEN BEGIN
//           IF MiniCustomerTemplate.NewCustomerFromTemplate(Customer) THEN BEGIN
//             COPY(Customer);
//             CurrPage.UPDATE;
//           END;
//           NewMode := FALSE;
//         END;
//     end;

//     local procedure CalcBalanceAsVendor()
//     var
//         Vendor: Record "23";
//     begin
//         // START/NAV2015PL/000
//         IF Vendor.GET(GetLinkedVendor) THEN BEGIN
//           COPYFILTER("Global Dimension 1 Filter",Vendor."Global Dimension 1 Filter");
//           COPYFILTER("Global Dimension 2 Filter",Vendor."Global Dimension 2 Filter");
//           COPYFILTER("Currency Filter",Vendor."Currency Filter");
//           Vendor.CALCFIELDS("Balance (LCY)");
//           BalanceAsVendor := Vendor."Balance (LCY)";
//           BalanceAsVendorEnable := TRUE;
//         END ELSE BEGIN
//           BalanceAsVendor := 0;
//           BalanceAsVendorEnable := FALSE;
//         END;
//         // STOP /NAV2015PL/000
//     end;

//     local procedure OnBalanceLCYAsVendorDrillDown()
//     var
//         DtldVendLedgEntry: Record "380";
//         Vendor: Record "23";
//         VendLedgEntry: Record "25";
//     begin
//         // START/NAV2017PL/000
//         IF Vendor.GET(GetLinkedVendor) THEN BEGIN
//           DtldVendLedgEntry.SETRANGE("Vendor No.",Vendor."No.");
//           COPYFILTER("Global Dimension 1 Filter",DtldVendLedgEntry."Initial Entry Global Dim. 1");
//           COPYFILTER("Global Dimension 2 Filter",DtldVendLedgEntry."Initial Entry Global Dim. 2");
//           COPYFILTER("Currency Filter",DtldVendLedgEntry."Currency Code");
//           VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
//         END;
//         // STOP /NAV2017PL/000
//     end;
// }

