page 50000 "Job Order Link List"
{
    Editable = false;
    PageType = List;
    SourceTable = 50000;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; "Job No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field("Sales Doc. Type"; "Sales Doc. Type")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field("Invoice Doc. Type"; "Invoice Doc. Type")
                {
                }
                field("Purch Doc. Type"; "Purch Doc. Type")
                {
                }
                field("Purch Order No."; "Purch Order No.")
                {
                }
                field("Purch Invoice Doc. Type"; "Purch Invoice Doc. Type")
                {
                }
                field("Purch Invoice No."; "Purch Invoice No.")
                {
                }
                field("Invoice No."; "Invoice No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Open Order / Invoice")
                {
                    Caption = 'Open Order / Invoice';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesHeader: Record "36";
                        SalesInvHeader: Record "112";
                        SalesCrMemoHeader: Record "114";
                        PurchInvHeader: Record "122";
                        PurchCrMemoHeader: Record "124";
                        PurchHeader: Record "38";
                    begin
                        IF "Invoice No." <> '' THEN BEGIN
                            CASE "Invoice Doc. Type" OF
                                "Invoice Doc. Type"::Invoice:
                                    BEGIN
                                        IF NOT SalesInvHeader.GET("Invoice No.") THEN
                                            ERROR(Text50000, SalesInvHeader.TABLECAPTION, "Invoice No.");
                                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", SalesInvHeader);
                                    END;
                                "Invoice Doc. Type"::"Credit Memo":
                                    BEGIN
                                        IF NOT SalesCrMemoHeader.GET("Invoice No.") THEN
                                            ERROR(Text50000, SalesCrMemoHeader.TABLECAPTION, "Invoice No.");
                                        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
                                    END;
                            END;
                        END ELSE BEGIN
                            CASE "Sales Doc. Type" OF
                                "Sales Doc. Type"::Order:
                                    BEGIN
                                        SalesHeader.GET(SalesHeader."Document Type"::Order, "Order No.");
                                        PAGE.RUNMODAL(PAGE::"Sales Order", SalesHeader);
                                    END;
                                "Sales Doc. Type"::"Credit Memo":
                                    BEGIN
                                        SalesHeader.GET(SalesHeader."Document Type"::"Credit Memo", "Order No.");
                                        PAGE.RUNMODAL(PAGE::"Sales Credit Memo", SalesHeader);
                                    END;
                            END;
                        END;
                        //gk
                        IF "Purch Invoice No." <> '' THEN BEGIN
                            CASE "Purch Invoice Doc. Type" OF
                                "Purch Invoice Doc. Type"::Invoice:
                                    BEGIN
                                        IF NOT PurchInvHeader.GET("Purch Invoice No.") THEN
                                            ERROR(Text50000, PurchInvHeader.TABLECAPTION, "Purch Invoice No.");
                                        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice", PurchInvHeader);
                                    END;
                                "Purch Invoice Doc. Type"::"Credit Memo":
                                    BEGIN
                                        IF NOT PurchCrMemoHeader.GET("Purch Invoice No.") THEN
                                            ERROR(Text50000, PurchCrMemoHeader.TABLECAPTION, "Purch Invoice No.");
                                        PAGE.RUNMODAL(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHeader);
                                    END;
                            END;
                        END ELSE BEGIN
                            CASE "Purch Doc. Type" OF
                                "Purch Doc. Type"::Order:
                                    BEGIN
                                        PurchHeader.GET(PurchHeader."Document Type"::Order, "Purch Order No.");
                                        PAGE.RUNMODAL(PAGE::"Purchase Order", PurchHeader);
                                    END;
                            END;
                        END;
                        //gk
                    end;
                }
            }
        }
    }

    var
        Text50000: Label 'The %1 %2 does not exist anymore.', Comment = 'The Sales Invoice Header 103001 does not exist in the system anymore. A printed copy of the document was created before deletion.';
}

