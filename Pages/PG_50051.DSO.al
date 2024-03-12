page 50051 DSO
{
    ApplicationArea = All;
    Caption = 'DSO';
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = filter(Invoice));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Customer.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                }
                field("Closed by Amount"; Rec."Closed by Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed by Amount field.';
                }
                field("Closed by Amount (LCY)"; Rec."Closed by Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed by Amount (LCY) field.';
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Payment Date"; Detailed."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Date';

                }
                field(DSO; DSO)
                {
                    ApplicationArea = All;
                    Caption = 'Days Outstanding';
                }
                field("UUID No."; SalesInvoiceHeader."Fiscal Invoice Number PAC")
                {
                    ApplicationArea = All;
                    Caption = 'UUID No.';
                }
                field("# CR Generado"; Detailed."Document No.")
                {
                    ApplicationArea = All;
                    Caption = '# CR generado';
                }
                field("Complement generated"; CustLedger."AkkOn-SAT UUID Stamp")
                {
                    ApplicationArea = All;
                    Caption = 'Complement generated';
                }
            }
        }
    }
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        Detailed: Record "Detailed Cust. Ledg. Entry";
        PayDate: date;
        DSO: Integer;
        CustLedger: Record "Cust. Ledger Entry";

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        DSO := 0;
        clear(Customer);
        Customer.get(rec."Customer No.");
        Clear(SalesInvoiceHeader);
        if SalesInvoiceHeader.get(rec."Document No.") then;
        rec.CalcFields(Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)");
        Clear(Detailed);
        Detailed.SetRange("Cust. Ledger Entry No.", Rec."Entry No.");
        Detailed.SetRange("Entry Type", Detailed."Entry Type"::Application);
        if Detailed.FindSet() then;
        if Detailed."Posting Date" <> 0D THEN
            DSO := Detailed."Posting Date" - REC."Posting Date";
        Clear(CustLedger);
        CustLedger.Reset();
        CustLedger.SetRange("Document No.", Detailed."Document No.");
        if CustLedger.FindSet() then;

    end;

}
