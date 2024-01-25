page 56007 "Treasury Payments"
{
    ApplicationArea = All;
    CaptionML = ESP = 'Pagos Tesoreria', ENG = 'Treasury Payments';
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
    UsageCategory = Lists;
    Permissions = TableData 25 = rim;

    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE(Open = CONST(true), "Document Type" = const(Invoice));
    layout
    {

        area(content)
        {
            repeater(General)
            {
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;

                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Editable = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                    Editable = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                    Editable = false;
                }
                field("Remaining Amount LCY"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Bank for Payment"; Rec."Bank for Payment")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Sent To Approval"; Rec."Sent To Approval")
                {
                    ApplicationArea = All;
                }
                field("Sent To Approval By"; Rec."Sent to Appoval By")
                {
                    ApplicationArea = All;
                }
                field("Date Sent To Approval"; Rec."Date Sent To Approval")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved by"; Rec."Approved by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Paid"; Rec."Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Paid By"; Rec."Paid By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Paid Date"; Rec."Paid Date")
                {
                    ApplicationArea = All;

                }

            }
            group(Totales)
            {
                field("Selected Amount (LCY)"; SelectedAmount)
                {
                    CaptionML = ENU = 'Selected Amount (LCY)', ESP = 'Valor Seleccionado (MXM)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount to Approval (LCY)"; SelectToApproval)
                {
                    CaptionML = ENU = 'Amount to Approval (LCY)', ESP = 'Valor para Aprobar (MXM)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Amount"; AmountApproved)
                {
                    CaptionML = ENU = 'Approved Amount (LCY)', ESP = 'Valor Aprobado (MXM)';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Selected Amount"; SelectedAmountUSD)
                {
                    CaptionML = ENU = 'Selected Amount (USD)', ESP = 'Valor Seleccionado (USD)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount to Approval"; SelelectToApprovalUSD)
                {
                    CaptionML = ENU = 'Amount to Approval (USD)', ESP = 'Valor para Aprobar (USD)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Amount (LCY)"; AmountApprovedUSD)
                {
                    CaptionML = ENU = 'Approved Amount (LCY)', ESP = 'Valor Aprobado (USD)';
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }


    actions
    {
        area(processing)
        {
            group("&Approvals")
            {
                Caption = '&Approvals';
                action("SentToApproval")
                {
                    CaptionML = ENU = 'Sent to Approval', ESP = 'Enviar a Aprobacion';
                    Image = SendApprovalRequest;

                    trigger OnAction()


                    var
                        VendorLedger: Record "Vendor Ledger Entry";
                        Text01: TextConst ENU = 'There is nothing to send for approval', ESP = 'No hay nada para enviar a aprobacion';
                        Text02: TextConst ENU = 'Sent to Approval', ESP = 'Enviado a Aprobacion';
                        SMAIL: Codeunit "SMTP Mail";
                        Mensaje: Text;
                        ValorAprobar: Decimal;
                    begin
                        Clear(VendorLedger);
                        VendorLedger.Reset();
                        VendorLedger.SetRange(Selected, true);
                        if VendorLedger.FindSet() then begin
                            repeat
                                VendorLedger.Selected := false;
                                VendorLedger."Sent To Approval" := true;
                                VendorLedger."Date Sent To Approval" := CurrentDateTime;
                                VendorLedger."Sent to Appoval By" := UserId;
                                VendorLedger.CalcFields("Remaining Amt. (LCY)");
                                ValorAprobar := ValorAprobar + VendorLedger."Remaining Amt. (LCY)";
                                VendorLedger.Modify()
                            until VendorLedger.Next() = 0;
                            SMAIL.CreateMessage('Notificaciones ERP NAV', 'notificaciones@byjsoluciones.com', 'jcamargo@byjsoluciones.com;pedro.miranda@hexagon.com', 'SOLICITUD APROBACION PAGOS ' + Format(CurrentDateTime), '', TRUE);
                            SMAIL.AppendBody('<h3>' + 'Buen dia Pedro Miranda </h3>');
                            Mensaje := 'En el presente correo le informamos que tiene unos pagos pendientes por aprobar por valor de ' + Format(ValorAprobar) + ' pesos Mexicanos';
                            SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                            Mensaje := '';
                            SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                            Mensaje := 'Muchas gracias por su atencion,';
                            SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                            SMAIL.Send();
                            Message(Text02);


                        end else
                            Error(Text01);


                    end;
                }
                action(ActionName)
                {
                    CaptionML = ENU = 'Approve', ESP = 'Aprobar';
                    ;
                    Image = Approve;

                    trigger OnAction()
                    var
                        VendorLedger: Record "Vendor Ledger Entry";
                        Text01: TextConst ENU = 'Do you want to approve the records sent approval?', ESP = 'Desea aprobar los registros enviados aprobacion?';
                        Text02: TextConst ENU = 'There is nothing to approve', ESP = 'No hay nada para aprobar';
                        Text03: TextConst ENU = 'Documents successfully approved', ESP = 'Documentos aprobados correctamente';
                        SMAIL: Codeunit "SMTP Mail";
                        Mensaje: Text;
                        ValorAprobar: Decimal;
                    begin
                        if Confirm(Text01) then begin
                            Clear(VendorLedger);
                            VendorLedger.Reset();
                            VendorLedger.SetRange("Sent To Approval", true);
                            if VendorLedger.FindSet() then begin
                                repeat
                                    VendorLedger."Sent To Approval" := false;
                                    VendorLedger.Approved := true;
                                    VendorLedger."Approved by" := UserId;
                                    VendorLedger."Date Approved" := CurrentDateTime;
                                    VendorLedger.CalcFields("Remaining Amt. (LCY)");
                                    ValorAprobar := ValorAprobar + VendorLedger."Remaining Amt. (LCY)";
                                    VendorLedger.Modify();
                                until VendorLedger.Next() = 0;
                                SMAIL.CreateMessage('Notificaciones ERP NAV', 'notificaciones@byjsoluciones.com', 'jcamargo@byjsoluciones.com', 'PAGOS APROBADOS PARA REGISTRAR ' + Format(CurrentDateTime), '', TRUE);
                                SMAIL.AppendBody('<h3>' + 'Buen dia Patricia </h3>');
                                Mensaje := 'En el presente correo le informamos que Pedro Miranda aprobo los pagos enviados por un valor de ' + Format(ValorAprobar) + ' pesos Mexicanos';
                                SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                                Mensaje := '';
                                SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                                Mensaje := 'Muchas gracias por su atencion,';
                                SMAIL.AppendBody('<p>' + Mensaje + '</p>');
                                SMAIL.Send();
                                Message(Text03);
                            end else
                                Error(Text02);
                        end;
                    end;
                }
                action(Pay)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Pay', ESP = 'Pagar';
                    Image = Payment;
                    trigger OnAction()
                    var
                        Text01: TextConst ENU = 'Do you want to pay the records approved?', ESP = 'Desea pagar los registros aprobados?';
                        Text02: TextConst ENU = 'There is nothing to pay.', ESP = 'No hay nada para pagar.';
                        Text03: TextConst ENU = 'Payment registered successfully.', ESP = 'Pago Registrado Existosamente.';
                        VendorLedger: Record "Vendor Ledger Entry";
                        ValorAprobar: Decimal;
                        GenJnl: Record "Gen. Journal Line";
                        linea: Integer;
                        Series: Record "No. Series Line";
                    begin

                        GenJnl.Reset();
                        GenJnl.SetRange("Journal Batch Name", 'PAGOS');
                        GenJnl.SetRange("Journal Template Name", 'PAYMENTS');
                        IF GenJnl.FindSet() THEN
                            repeat
                                GenJnl.Delete();
                            UNTIL GenJnl.Next() = 0;
                        linea := 0;
                        Clear(VendorLedger);
                        VendorLedger.Reset();
                        VendorLedger.SetRange("Approved", true);
                        VendorLedger.SetFilter("Bank for Payment", '<>''''');
                        if VendorLedger.FindSet() then begin
                            repeat
                                VendorLedger.CalcFields("Remaining Amount");
                                if VendorLedger."Remaining Amount" <> 0 then begin
                                    linea := linea + 1000;
                                    GenJnl.init;
                                    GenJnl.VALIDATE("Journal Template Name", 'PAYMENTS');
                                    GenJnl.VALIDATE("Journal Batch Name", 'PAGOS');
                                    GenJnl."Line No." := linea;
                                    if VendorLedger."Payment Date" = 0D THEN
                                        VendorLedger."Payment Date" := Today;
                                    GenJnl.VALIDATE("Posting Date", VendorLedger."Payment Date");
                                    Series.Reset();
                                    Series.SetRange("Series Code", 'GJNL-PMT');
                                    Series.FindSet();
                                    GenJnl."Document Type" := GenJnl."Document Type"::Payment;
                                    GenJnl.validate("Document Type");
                                    GenJnl.VALIDATE("Document No.", IncStr(Series."Last No. Used"));
                                    Series."Last No. Used" := GenJnl."Document No.";
                                    Series.Modify();
                                    GenJnl."External Document No." := VendorLedger."External Document No.";
                                    GenJnl."Account Type" := GenJnl."Account Type"::Vendor;
                                    GenJnl.Validate("Account No.", VendorLedger."Vendor No.");
                                    GenJnl.Description := VendorLedger.Description;
                                    GenJnl.Amount := Abs(VendorLedger."Remaining Amount");
                                    GenJnl.VALIDATE(Amount);
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                    GenJnl."Bal. Account No." := VendorLedger."Bank for Payment";
                                    GenJnl.VALIDATE("Bal. Account No.");
                                    GenJnl."Applies-to Doc. Type" := VendorLedgerEntry."Document Type";
                                    GenJnl."Applies-to Doc. No." := VendorLedger."Document No.";
                                    GenJnl.VALIDATE("Shortcut Dimension 1 Code", VendorLedger."Global Dimension 1 Code");
                                    GenJnl.VALIDATE("Shortcut Dimension 2 Code", VendorLedger."Global Dimension 2 Code");
                                    GenJnl."Currency Code" := VendorLedger."Currency Code";
                                    GenJnl."Payment Method Code" := VendorLedgerEntry."Payment Method Code";
                                    GenJnl.Insert();
                                    VendorLedger."Paid By" := UserId;
                                    VendorLedger."Paid Date" := CurrentDateTime;
                                    VendorLedger.Paid := true;
                                    VendorLedger.Approved := false;
                                    VendorLedger.Modify();
                                end;
                            until VendorLedger.Next() = 0;
                            GenJnl.RESET;
                            GenJnl.SETRANGE("Journal Batch Name", 'PAGOS');
                            GenJnl.SETRANGE("Journal Template Name", 'PAYMENTS');
                            GenJnl.FINDSET;
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);
                            COMMIT;
                        end else
                            Error(Text02);

                    END;
                }
                action(Reject)
                {
                    CaptionML = ENU = 'Declaine', ESP = 'Rechazar';
                    Image = Reject;

                    trigger OnAction()
                    var
                        Text01: TextConst ENU = 'Do you want to reject payment for ', ESP = 'Desea rechazar el pago por ';
                    begin
                        IF Confirm(Text01 + Format(Rec."Remaining Amount") + ' ' + Rec."Currency Code") then begin
                            Rec."Sent To Approval" := false;
                            Rec."Date Sent To Approval" := 0DT;
                            REC.Modify()
                        end;
                    end;
                }

            }
        }
    }
    var
        SelectToApproval: Decimal;
        SelectedAmount: Decimal;
        AmountApproved: Decimal;
        AmountApprovedUSD: Decimal;
        SelectedAmountUSD: Decimal;
        SelelectToApprovalUSD: Decimal;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Windows: Dialog;

    trigger OnAfterGetCurrRecord()


    begin
        SelectToApproval := 0;
        AmountApproved := 0;
        SelectedAmount := 0;
        SelelectToApprovalUSD := 0;
        AmountApprovedUSD := 0;
        SelectedAmountUSD := 0;
        Clear(VendorLedgerEntry);
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Selected, true);
        if VendorLedgerEntry.FindSet() then
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                if VendorLedgerEntry."Currency Code" = 'USD' THEN begin
                    VendorLedgerEntry.CalcFields("Remaining Amount");
                    SelectedAmountUSD := SelectedAmountUSD + VendorLedgerEntry."Remaining Amount";
                end;
                SelectedAmount := SelectedAmount + VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;
        Clear(VendorLedgerEntry);
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Sent To Approval", true);
        if VendorLedgerEntry.FindSet() then
            repeat
                IF VendorLedgerEntry."Currency Code" = 'USD' THEN begin
                    VendorLedgerEntry.CalcFields("Remaining Amount");
                    SelelectToApprovalUSD := SelelectToApprovalUSD + VendorLedgerEntry."Remaining Amount";
                end;
                VendorLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                SelectToApproval := SelectToApproval + VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;
        Clear(VendorLedgerEntry);
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Approved, true);
        if VendorLedgerEntry.FindSet() then
            repeat
                IF VendorLedgerEntry."Currency Code" = 'USD' THEN begin
                    VendorLedgerEntry.CalcFields("Remaining Amount");
                    AmountApprovedUSD := AmountApprovedUSD + VendorLedgerEntry."Remaining Amount";
                end;
                VendorLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                AmountApproved := AmountApproved + VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;
    end;



}

