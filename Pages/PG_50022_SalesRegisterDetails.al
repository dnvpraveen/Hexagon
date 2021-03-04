page 50022 "Sales Register Details"
{
    Editable = false;
    PageType = List;
    SourceTable = 56006;
    SourceTableView = WHERE(Filter = FILTER(1 | 2 | 3 | 4 | 5 | 6));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Order No."; "Sales Order No.")
                {
                }
                field(Filter; Filter)
                {
                    Visible = false;
                }
                field("Sales Order Line No."; "Sales Order Line No.")
                {
                }
                field("Sales Order Date"; "Sales Order Date")
                {
                }
                field("Request Delivery Date"; "Request Delivery Date")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Document Line No."; "Document Line No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Customer No."; "Customer No.")
                {
                }
                field("Customer Name"; "Customer Name")
                {
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Currency Factor"; "Currency Factor")
                {
                }
                field("Job No."; "Job No.")
                {
                }
                field(Type; Type)
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Item Description"; "Item Description")
                {
                }
                field("Amount Excl Tax"; "Amount Excl Tax")
                {
                }
                field(AmountExcTaxInLCY; AmountExcTaxInLCY)
                {
                    Caption = '<Amount Exc Tax LCY>';
                }
                field("Tax Amount"; "Tax Amount")
                {
                }
                field(TaxLCY; TaxLCY)
                {
                    Caption = '<Tax LCY>';
                }
                field("Amount Incl Tax"; "Amount Incl Tax")
                {
                }
                field(TotalLCY; TotalLCY)
                {
                    Caption = '<Total LCY>';
                }
                field("VAT %"; "VAT %")
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
                field("Cost Centre"; "Cost Centre")
                {
                }
                field("Product Cat"; "Product Cat")
                {
                }
                field("HM Location"; "HM Location")
                {
                }
                field("Inter Company"; "Inter Company")
                {
                }
                field("G/L Account No."; "G/L Account No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Sales Log Records")
            {
                Caption = 'Update Sales Log Records';
                Ellipsis = true;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GLEntry: Record 17;
                    DimensionEntry: Record 480;
                    GLSetup: Record 98;
                    LCnt: Integer;
                begin
                    UpdateSalesLog;
                end;
            }
            action("Update Filter For BI")
            {
                RunObject = Report 50003;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "Currency Factor" <> 0 THEN BEGIN
            AmountExcTaxInLCY := "Amount Excl Tax" / "Currency Factor";
            TaxLCY := "Tax Amount" / "Currency Factor";
            TotalLCY := "Amount Incl Tax" / "Currency Factor";
        END ELSE BEGIN
            AmountExcTaxInLCY := "Amount Excl Tax";
            TaxLCY := "Tax Amount";
            TotalLCY := "Amount Incl Tax";
        END;
    end;

    trigger OnOpenPage()
    begin
        AmountExcTaxInLCY := 0;
        TaxLCY := 0;
        TotalLCY := 0;
    end;

    var
        GLSetup: Record 98;
        DimensionEntry: Record 480;
        LCnt: Integer;
        JapanSalesLog: Record 50019;
        JapanSalesLog2: Record 50019;
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine: Record 113;
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine: Record 115;
        SalesHeader: Record 36;
        SalesHeaderArchive: Record 5107;
        Saleslog: Record 50001;
        SalesLine: Record 37;
        SalesLineArchive: Record 5108;
        LText001: Label 'Updating Records - ';
        Window: Dialog;
        LineNo: Integer;
        AmountExcTaxInLCY: Decimal;
        TaxLCY: Decimal;
        TotalLCY: Decimal;

    local procedure UpdateSalesLog()
    begin

        GLSetup.GET;

        IF SalesInvoiceLine.FINDSET THEN BEGIN

            IF NOT JapanSalesLog.FINDLAST THEN
                LCnt := 1
            ELSE
                LCnt := JapanSalesLog."Entry No." + 1;

            Window.OPEN('#1#################################\\');

            REPEAT
                Window.UPDATE(1, FORMAT(LText001 + SalesInvoiceLine."Document No."));
                JapanSalesLog2.RESET;
                JapanSalesLog2.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                JapanSalesLog2.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
                IF NOT JapanSalesLog2.FINDFIRST THEN BEGIN
                    JapanSalesLog2.INIT;
                    JapanSalesLog2."Entry No." := LCnt;
                    JapanSalesLog2."Document Type" := JapanSalesLog2."Document Type"::Invoice;
                    JapanSalesLog2."Document Line No." := SalesInvoiceLine."Line No.";
                    JapanSalesLog2."Sales Order Line No." := SalesInvoiceLine."Line No.";
                    JapanSalesLog2.Type := SalesInvoiceLine.Type;
                    IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::" " THEN
                        JapanSalesLog2.Filter := '1'
                    ELSE
                        IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::"Charge (Item)" THEN
                            JapanSalesLog2.Filter := '2'
                        ELSE
                            IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::"Fixed Asset" THEN
                                JapanSalesLog2.Filter := '3'
                            ELSE
                                IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item THEN
                                    JapanSalesLog2.Filter := '4'
                                ELSE
                                    IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::Resource THEN
                                        JapanSalesLog2.Filter := '5'
                                    ELSE
                                        IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::"G/L Account" THEN
                                            IF (SalesInvoiceLine."No." < '400000') OR (SalesInvoiceLine."No." >= '500000') THEN
                                                JapanSalesLog2.Filter := '7'
                                            ELSE
                                                IF (SalesInvoiceLine."No." >= '400000') AND (SalesInvoiceLine."No." < '500000') THEN
                                                    JapanSalesLog2.Filter := '6';

                    JapanSalesLog2."Item No." := SalesInvoiceLine."No.";
                    JapanSalesLog2."Item Description" := SalesInvoiceLine.Description;
                    JapanSalesLog2."Dimension Set ID" := SalesInvoiceLine."Dimension Set ID";
                    JapanSalesLog2."VAT %" := SalesInvoiceLine."VAT %";
                    JapanSalesLog2."Location Code" := SalesInvoiceLine."Location Code";
                    JapanSalesLog2."Customer No." := SalesInvoiceLine."Sell-to Customer No.";
                    JapanSalesLog2."Amount Excl Tax" := SalesInvoiceLine."Line Amount";
                    JapanSalesLog2."Amount Incl Tax" := SalesInvoiceLine."Amount Including VAT";
                    JapanSalesLog2."Tax Amount" := SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine."Line Amount";
                    IF SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.") THEN BEGIN
                        JapanSalesLog2."Document No." := SalesInvoiceHeader."No.";
                        JapanSalesLog2."Posting Date" := SalesInvoiceHeader."Posting Date";
                        JapanSalesLog2."Currency Code" := SalesInvoiceHeader."Currency Code";
                        JapanSalesLog2."Currency Factor" := SalesInvoiceHeader."Currency Factor";
                        JapanSalesLog2."Sell-to Country/Region Code" := SalesInvoiceHeader."Ship-to Country/Region Code";
                        JapanSalesLog2."Ship-to Name" := SalesInvoiceHeader."Ship-to Name";
                        JapanSalesLog2."Sales Order No." := SalesInvoiceHeader."Order No.";
                        JapanSalesLog2."Sales Order Date" := SalesInvoiceHeader."Order Date";
                        JapanSalesLog2."Customer Name" := SalesInvoiceHeader."Sell-to Customer Name";
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("No.", SalesInvoiceHeader."Order No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            //JapanSalesLog2."Job No." := SalesHeader."Job No.";
                            JapanSalesLog2."Request Delivery Date" := SalesHeader."Requested Delivery Date";
                        END;
                        SalesHeaderArchive.RESET;
                        SalesHeaderArchive.SETRANGE("No.", SalesInvoiceHeader."Order No.");
                        IF SalesHeaderArchive.FINDLAST THEN BEGIN
                            JapanSalesLog2."Request Delivery Date" := SalesHeaderArchive."Requested Delivery Date";
                            //JapanSalesLog2."Job No." := SalesHeaderArchive."Job No.";
                        END;
                    END;
                    DimensionEntry.RESET;
                    DimensionEntry.SETRANGE("Dimension Set ID", SalesInvoiceLine."Dimension Set ID");
                    IF DimensionEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                                JapanSalesLog2."Cost Centre" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                                JapanSalesLog2."Product Cat" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
                                JapanSalesLog2."Inter Company" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
                                JapanSalesLog2."HM Location" := DimensionEntry."Dimension Value Code";
                        UNTIL DimensionEntry.NEXT = 0;
                    END;
                    JapanSalesLog2.INSERT;
                    LCnt += 1;
                END;
            UNTIL SalesInvoiceLine.NEXT = 0;

        END;
        Window.CLOSE;

        SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
        IF SalesCrMemoLine.FINDSET THEN BEGIN

            IF NOT JapanSalesLog.FINDLAST THEN
                LCnt := 1
            ELSE
                LCnt := JapanSalesLog."Entry No." + 1;

            Window.OPEN('#1#################################\\' + LText001 + FORMAT(SalesCrMemoLine."Document No."));

            REPEAT
                JapanSalesLog2.RESET;
                JapanSalesLog2.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                JapanSalesLog2.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
                IF NOT JapanSalesLog2.FINDFIRST THEN BEGIN
                    JapanSalesLog2.INIT;
                    JapanSalesLog2."Entry No." := LCnt;
                    JapanSalesLog2."Document Type" := JapanSalesLog2."Document Type"::CreditMemo;
                    JapanSalesLog2."Document Line No." := SalesCrMemoLine."Line No.";
                    JapanSalesLog2.Type := SalesCrMemoLine.Type;
                    //HEX ++
                    IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::" " THEN
                        JapanSalesLog2.Filter := '1'
                    ELSE
                        IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::"Charge (Item)" THEN
                            JapanSalesLog2.Filter := '2'
                        ELSE
                            IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::"Fixed Asset" THEN
                                JapanSalesLog2.Filter := '3'
                            ELSE
                                IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item THEN
                                    JapanSalesLog2.Filter := '4'
                                ELSE
                                    IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::Resource THEN
                                        JapanSalesLog2.Filter := '5'
                                    ELSE
                                        IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::"G/L Account" THEN
                                            IF (SalesCrMemoLine."No." < '400000') OR (SalesCrMemoLine."No." >= '500000') THEN
                                                JapanSalesLog2.Filter := '7'
                                            ELSE
                                                IF (SalesCrMemoLine."No." >= '400000') AND (SalesCrMemoLine."No." < '500000') THEN
                                                    JapanSalesLog2.Filter := '6';
                    //HEX --
                    JapanSalesLog2."Item No." := SalesCrMemoLine."No.";
                    JapanSalesLog2."Item Description" := SalesCrMemoLine.Description;
                    JapanSalesLog2."Dimension Set ID" := SalesCrMemoLine."Dimension Set ID";
                    JapanSalesLog2."VAT %" := SalesCrMemoLine."VAT %";
                    JapanSalesLog2."Location Code" := SalesCrMemoLine."Location Code";
                    JapanSalesLog2."Customer No." := SalesCrMemoLine."Sell-to Customer No.";
                    JapanSalesLog2."Amount Excl Tax" := -SalesCrMemoLine."Line Amount";
                    JapanSalesLog2."Amount Incl Tax" := -SalesCrMemoLine."Amount Including VAT";
                    JapanSalesLog2."Tax Amount" := JapanSalesLog2."Amount Incl Tax" - JapanSalesLog2."Amount Excl Tax";
                    IF SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.") THEN BEGIN
                        JapanSalesLog2."Document No." := SalesCrMemoHeader."No.";
                        JapanSalesLog2."Posting Date" := SalesCrMemoHeader."Posting Date";
                        JapanSalesLog2."Currency Code" := SalesCrMemoHeader."Currency Code";
                        JapanSalesLog2."Currency Factor" := SalesCrMemoHeader."Currency Factor";
                        JapanSalesLog2."Sell-to Country/Region Code" := SalesCrMemoHeader."Ship-to Country/Region Code";
                        JapanSalesLog2."Ship-to Name" := SalesCrMemoHeader."Ship-to Name";
                        JapanSalesLog2."Customer Name" := SalesCrMemoHeader."Sell-to Customer Name";
                        SalesInvoiceHeader.RESET;
                        SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
                        SalesInvoiceHeader.SETRANGE("No.", SalesCrMemoHeader."Applies-to Doc. No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            SalesInvoiceLine.SETRANGE("No.", SalesCrMemoLine."No.");
                            SalesInvoiceLine.SETRANGE(Amount, SalesCrMemoLine.Amount);
                            IF SalesInvoiceLine.FINDFIRST THEN
                                JapanSalesLog2."Sales Order Line No." := SalesInvoiceLine."Line No.";
                            JapanSalesLog2."Sales Order No." := SalesInvoiceHeader."Order No.";
                            JapanSalesLog2."Sales Order Date" := SalesInvoiceHeader."Order Date";
                            SalesHeader.RESET;
                            SalesHeader.SETRANGE("No.", SalesInvoiceHeader."Order No.");
                            IF SalesHeader.FINDFIRST THEN BEGIN
                                //JapanSalesLog2."Job No." := SalesHeader."Job No.";
                                JapanSalesLog2."Request Delivery Date" := SalesHeader."Requested Delivery Date";
                            END;
                            SalesHeaderArchive.RESET;
                            SalesHeaderArchive.SETRANGE("No.", SalesInvoiceHeader."Order No.");
                            IF SalesHeaderArchive.FINDLAST THEN BEGIN
                                JapanSalesLog2."Request Delivery Date" := SalesHeaderArchive."Requested Delivery Date";
                                //JapanSalesLog2."Job No." := SalesHeaderArchive."Job No.";
                            END;
                        END;
                    END;
                    DimensionEntry.RESET;
                    DimensionEntry.SETRANGE("Dimension Set ID", SalesCrMemoLine."Dimension Set ID");
                    IF DimensionEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                                JapanSalesLog2."Cost Centre" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                                JapanSalesLog2."Product Cat" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
                                JapanSalesLog2."Inter Company" := DimensionEntry."Dimension Value Code";
                            IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
                                JapanSalesLog2."HM Location" := DimensionEntry."Dimension Value Code";
                        UNTIL DimensionEntry.NEXT = 0;
                    END;
                    JapanSalesLog2.INSERT;
                    LCnt += 1;
                END;
                Window.UPDATE(1, FORMAT(SalesCrMemoLine."Document No."));
            UNTIL SalesCrMemoLine.NEXT = 0;

        END;
        Window.CLOSE;
    end;
}

