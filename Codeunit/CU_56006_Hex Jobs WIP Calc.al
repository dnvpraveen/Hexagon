codeunit 56006 "Hex Jobs WIP Calc"
{
    trigger OnRun()
    begin

    end;

    procedure UpdateGLAnalysisRecords();
    //18052016 GMP Start
    var
        GLEntry: Record "G/L Entry";
        GLAnalysis: Record "GL Analysis";
        DimensionEntry: record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        LCnt: Integer;
    begin
        GLSetup.GET;
        LCnt := GLAnalysis.COUNT;

        IF LCnt = 0 THEN
            GLEntry.SETFILTER(GLEntry."Entry No.", '>%1', LCnt)
        ELSE BEGIN
            GLAnalysis.FINDLAST;
            GLEntry.SETFILTER(GLEntry."Entry No.", '>%1', GLAnalysis."Entry No");
        END;



        IF GLEntry.FINDSET THEN BEGIN
            //Window.OPEN('#1#################################\\' + LText001 + FORMAT( GLEntry."Entry No." ));
            REPEAT
                GLAnalysis.INIT;
                GLAnalysis."Entry No" := GLEntry."Entry No.";
                GLAnalysis."G/L Account No." := GLEntry."G/L Account No.";
                GLEntry.CALCFIELDS("G/L Account Name");
                GLAnalysis."G/L Account Name" := GLEntry."G/L Account Name";
                GLAnalysis."Posting Date" := GLEntry."Posting Date";
                GLAnalysis.Amount := GLEntry.Amount;
                GLAnalysis."Document Type" := GLEntry."Document Type";
                GLAnalysis."Document No." := GLEntry."Document No.";
                GLAnalysis.Description := GLEntry.Description;
                GLAnalysis."Source Code" := GLEntry."Source Code";
                GLAnalysis."Source No." := GLEntry."Source No.";
                GLAnalysis."External Document No." := GLEntry."External Document No.";
                GLAnalysis."User ID" := GLEntry."User ID";
                GLAnalysis."Gen. Posting Type" := GLEntry."Gen. Posting Type";
                GLAnalysis."Gen. Bus. Posting Group" := GLEntry."Gen. Bus. Posting Group";
                GLAnalysis."Gen. Prod. Posting Group" := GLEntry."Gen. Prod. Posting Group";
                GLAnalysis."VAT Bus. Posting Group" := GLEntry."VAT Bus. Posting Group";
                GLAnalysis."VAT Prod. Posting Group" := GLEntry."VAT Prod. Posting Group";

                DimensionEntry.RESET;
                DimensionEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                IF DimensionEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        DimensionEntry.CALCFIELDS("Dimension Value Name");
                        IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN BEGIN
                            GLAnalysis."Dimension 1" := DimensionEntry."Dimension Value Code";
                            GLAnalysis."Dimension 1 Name" := DimensionEntry."Dimension Value Name";
                        END
                        ELSE
                            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN BEGIN
                                GLAnalysis."Dimension 2" := DimensionEntry."Dimension Value Code";
                                GLAnalysis."Dimension 2 Name" := DimensionEntry."Dimension Value Name";
                            END
                            ELSE
                                IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN BEGIN
                                    GLAnalysis."Dimension 3" := DimensionEntry."Dimension Value Code";
                                    GLAnalysis."Dimension 3 Name" := DimensionEntry."Dimension Value Name";
                                END
                                ELSE
                                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN BEGIN
                                        GLAnalysis."Dimension 4" := DimensionEntry."Dimension Value Code";
                                        GLAnalysis."Dimension 4 Name" := DimensionEntry."Dimension Value Name";
                                    END
                                    ELSE
                                        IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 5 Code" THEN BEGIN
                                            GLAnalysis."Dimension 5" := DimensionEntry."Dimension Value Code";
                                            GLAnalysis."Dimension 5 Name" := DimensionEntry."Dimension Value Name";
                                        END
                                        ELSE
                                            IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 6 Code" THEN BEGIN
                                                GLAnalysis."Dimension 6" := DimensionEntry."Dimension Value Code";
                                                GLAnalysis."Dimension 6 Name" := DimensionEntry."Dimension Value Name";
                                            END
                                            ELSE
                                                IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 7 Code" THEN BEGIN
                                                    GLAnalysis."Dimension 7" := DimensionEntry."Dimension Value Code";
                                                    GLAnalysis."Dimension 7 Name" := DimensionEntry."Dimension Value Name";
                                                END
                                                ELSE
                                                    IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 8 Code" THEN BEGIN
                                                        GLAnalysis."Dimension 8" := DimensionEntry."Dimension Value Code";
                                                        GLAnalysis."Dimension 8 Name" := DimensionEntry."Dimension Value Name";
                                                    END

                    UNTIL DimensionEntry.NEXT = 0;
                END;
                //Window.UPDATE(1, FORMAT( GLEntry."Entry No." ));
                GLAnalysis.INSERT;
            UNTIL GLEntry.NEXT = 0;
            //Window.CLOSE;
        END

        //18052016 GMP END
        //var
    end;

    [EventSubscriber(ObjectType::Table, 123, 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure MyProcedure(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")
    var
        myInt: Integer;
    begin
        //gk
        PurchInvLine."Job Planning Line No." := PurchLine."Job Planning Line No.";
        //gk
    end;

    [EventSubscriber(ObjectType::table, 123, 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure MyProcedure2(var Rec: Record "Purch. Inv. Line"; var xRec: Record "Purch. Inv. Line"; CurrFieldNo: Integer)
    var
        myInt: Integer;
    begin

    end;
}