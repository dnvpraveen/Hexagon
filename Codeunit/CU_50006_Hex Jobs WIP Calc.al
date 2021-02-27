codeunit 50006 "Hex Jobs WIP Calc"
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


}





OBJECT Codeunit 50006 Hex Jobs WIP Calc
{
  OBJECT-PROPERTIES
  {
    Date=08-12-20;
    Time=12:25:05 PM;
    Modified=Yes;
    Version List=WIP0.2;
  }
  PROPERTIES
  {
    OnRun=BEGIN
          END;

  }
  CODE
  {
    VAR
      JobOrderLink@1000000000 : Record 50000;
      SalesHeader@1000000001 : Record 36;
      HexTotalRecogSales@1000000002 : Decimal;
      SalesInvHeader@1000000003 : Record 112;
      JobDiffBuffer@1000000004 : ARRAY [2] OF TEMPORARY Record 1019 SECURITYFILTERING(Validated);
      JobDimValue@1000000005 : Decimal;

    PROCEDURE HexRecogSalesCalc@1000000000(JobNo@1000000000 : Record 167);
    VAR
      TotalRecogSales2@1000000001 : Decimal;
      WIPSalesAmt2@1000000002 : Decimal;
      HexTotalWIPSalesAmt@1000000003 : Decimal;
      HexTotalWIPSlaesGLAmt@1000000004 : Decimal;
      WIPsalesGLAmt2@1000000005 : Decimal;
      TotalRecogSalesGL2@1000000006 : Decimal;
      HexTotalRecogSalesGl@1000000008 : Decimal;
    BEGIN
      JobOrderLink.INIT;
      SalesHeader.INIT;
      HexTotalRecogSales :=0;
      TotalRecogSales2 := 0;
      WIPSalesAmt2 := 0;
      HexTotalWIPSalesAmt := 0;
      TotalRecogSalesGL2 := 0;
      JobOrderLink.SETRANGE("Job No.",JobNo."No.");
      JobOrderLink.SETRANGE("Sales Doc. Type",JobOrderLink."Sales Doc. Type"::Order);
      IF JobOrderLink.FIND('-') THEN
       REPEAT
        IF JobOrderLink."Invoice No." = '' THEN BEGIN
          IF SalesHeader.GET(SalesHeader."Document Type"::Order,JobOrderLink."Order No.") THEN BEGIN
             HexSalesLineCalc(SalesHeader."Document Type",SalesHeader."No.",TotalRecogSales2,WIPSalesAmt2,WIPsalesGLAmt2);
             HexTotalRecogSales += TotalRecogSales2;
             HexTotalWIPSalesAmt += WIPSalesAmt2;
             HexTotalWIPSlaesGLAmt += WIPsalesGLAmt2;
          END;
        END;
        IF SalesInvHeader.GET(JobOrderLink."Invoice No.") THEN BEGIN
           HexSalesLineINVCalc(SalesInvHeader."No.",TotalRecogSalesGL2);
           HexTotalRecogSalesGl += TotalRecogSalesGL2;
        END;
       UNTIL JobOrderLink.NEXT = 0;

      IF HexTotalRecogSales <> 0 THEN
        JobNo."Hex Recog. Sales Amount" := HexTotalRecogSales
      ELSE
        JobNo."Hex Recog. Sales Amount" := HexTotalRecogSalesGl;

      JobNo."Hex WIP Total Sale Amount" := HexTotalWIPSalesAmt;
      JobNo."Hex WIP Total Sales G/L Amount" := HexTotalWIPSlaesGLAmt;
      JobNo.MODIFY;
    END;

    PROCEDURE HexRecogSalesGLCalc@1000000001(JobNo@1000000000 : Record 167);
    VAR
      TotalRecogSalesGL2@1000000001 : Decimal;
      HexTotalRecogSalesGL@1000000002 : Decimal;
    BEGIN
      //Posted GL Sales orders
      JobOrderLink.INIT;
      SalesInvHeader.INIT;
      HexTotalRecogSalesGL :=0;
      TotalRecogSalesGL2 := 0;
      JobOrderLink.SETRANGE("Job No.",JobNo."No.");
      JobOrderLink.SETRANGE("Sales Doc. Type",JobOrderLink."Sales Doc. Type"::Order);
      IF JobOrderLink.FIND('-') THEN
       REPEAT
       IF JobOrderLink."Invoice Doc. Type" = JobOrderLink."Invoice Doc. Type"::Invoice THEN
         IF SalesInvHeader.GET(JobOrderLink."Invoice No.") THEN BEGIN
            HexSalesLineINVCalc(SalesInvHeader."No.",TotalRecogSalesGL2);
            HexTotalRecogSalesGL += TotalRecogSalesGL2;
         END;
       UNTIL JobOrderLink.NEXT = 0;

      JobNo."Hex Recog. Sales G/L Amount" := HexTotalRecogSalesGL;
      JobNo.MODIFY;
      //MESSAGE(FORMAT(HexTotalRecogSales));
    END;

    PROCEDURE HexSalesLineCalc@1000000002(DocumentType@1000000000 : 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';OrderNo@1000000001 : Code[20];VAR TotalRecogSales@1000000003 : Decimal;VAR WIPSalesAmt@1000000004 : Decimal;VAR WIPsalesGLAmt@1000000005 : Decimal);
    VAR
      SalesLine@1000000002 : Record 37;
    BEGIN
      // Document Type,Document No.,Line No.
      SalesLine.INIT;
      TotalRecogSales := 0;
      WIPSalesAmt := 0;
      WIPsalesGLAmt := 0;
      SalesLine.SETRANGE("Document Type",DocumentType);
      SalesLine.SETRANGE("Document No.",OrderNo);
      IF SalesLine.FIND('-') THEN
      REPEAT
        IF (SalesLine.Quantity <> 0) AND (SalesLine."Document Type" <> SalesLine.Type::" ") THEN
           TotalRecogSales += SalesLine."Line Amount";
           WIPSalesAmt += SalesLine."Prepmt. Line Amount";
           WIPsalesGLAmt += SalesLine."Prepmt. Amt. Inv.";
      UNTIL SalesLine.NEXT =0;
      // MESSAGE(FORMAT(TotalRecogSales));
    END;

    PROCEDURE HexSalesLineINVCalc@1000000006(OrderNo@1000000001 : Code[20];VAR TotalRecogSalesGL@1000000003 : Decimal);
    VAR
      SalesInvLine@1000000002 : Record 113;
    BEGIN
      //Posted GL Sales orders
      SalesInvLine.INIT;
      TotalRecogSalesGL := 0;
      SalesInvLine.SETRANGE("Document No.",OrderNo);
      IF SalesInvLine.FIND('-') THEN
      REPEAT
        IF SalesInvLine.Quantity <> 0 THEN
           TotalRecogSalesGL += SalesInvLine.Amount;
      UNTIL SalesInvLine.NEXT =0;
    END;

    PROCEDURE JobWipCalc@1000000003();
    VAR
      CalcWIPRpt@1000000000 : Report 1086;
                                  JobCal@1000000001 : Record 167;
    BEGIN
      JobCal.INIT;
      JobCal.SETRANGE("Hex Project Status",JobCal."Hex Project Status"::WIP,JobCal."Hex Project Status"::Closed);
      CalcWIPRpt.SETTABLEVIEW(JobCal);
      CalcWIPRpt.RUNMODAL;
    END;

    PROCEDURE PostJobWipCalc@1000000004();
    VAR
      CalcPostWIPRpt@1000000000 : Report 1085;
                                      JobCal@1000000001 : Record 167;
    BEGIN
      JobCal.INIT;
      JobCal.SETRANGE("Hex Project Status",JobCal."Hex Project Status"::WIP,JobCal."Hex Project Status"::Closed);
      CalcPostWIPRpt.SETTABLEVIEW(JobCal);
      CalcPostWIPRpt.RUNMODAL;
      HexJobStatus;
    END;

    PROCEDURE HexJobStatus@1000000005();
    VAR
      JobCal@1000000000 : Record 167;
    BEGIN
      JobCal.INIT;
      JobCal.SETRANGE("Hex Project Status",JobCal."Hex Project Status"::Closed);
      JobCal.SETRANGE(Status,JobCal.Status::Completed);
      IF JobCal.FIND('-') THEN
        REPEAT
        JobCal."Hex Project Status" := JobCal."Hex Project Status"::Archived;
        JobCal.MODIFY;
        UNTIL JobCal.NEXT =0;
      MESSAGE('Job Hex Project Status is changed');
    END;

    PROCEDURE HexCalculateActualToBudget@10(VAR Job@1005 : Record 167;JT@1001 : Record 1001;VAR JobDiffBuffer2@1000 : Record 1019;VAR JobDiffBuffer3@1006 : Record 1019;CurrencyType@1002 : 'LCY,FCY');
    VAR
      JobPlanningLine@1003 : Record 1003;
      JobLedgEntry@1004 : Record 169;
    BEGIN
      CLEARALL;
      CLEAR(JobDiffBuffer);
      CLEAR(JobDiffBuffer2);
      CLEAR(JobDiffBuffer3);

      JobDiffBuffer[1].DELETEALL;
      JobDiffBuffer2.DELETEALL;
      JobDiffBuffer3.DELETEALL;

      JT.FIND;
      JobPlanningLine.SETRANGE("Job No.",JT."Job No.");
      JobPlanningLine.SETRANGE("Job Task No.",JT."Job Task No.");
      JobPlanningLine.SETFILTER("Planning Date",Job.GETFILTER("Planning Date Filter"));

      JobLedgEntry.SETRANGE("Job No.",JT."Job No.");
      JobLedgEntry.SETRANGE("Job Task No.",JT."Job Task No.");
      JobLedgEntry.SETFILTER("Posting Date",Job.GETFILTER("Posting Date Filter"));

      IF JobPlanningLine.FIND('-') THEN
        REPEAT
          HexInsertDiffBuffer(JobLedgEntry,JobPlanningLine,0,CurrencyType);
        UNTIL JobPlanningLine.NEXT = 0;

      IF JobLedgEntry.FIND('-') THEN
        REPEAT
          HexInsertDiffBuffer(JobLedgEntry,JobPlanningLine,1,CurrencyType);
        UNTIL JobLedgEntry.NEXT = 0;

      IF JobDiffBuffer[1].FIND('-') THEN
        REPEAT
          IF JobDiffBuffer[1]."Entry type" = JobDiffBuffer[1]."Entry type"::Budget THEN BEGIN
            JobDiffBuffer2 := JobDiffBuffer[1];
            JobDiffBuffer2.INSERT;
          END ELSE BEGIN
            JobDiffBuffer3 := JobDiffBuffer[1];
            JobDiffBuffer3."Entry type" := JobDiffBuffer3."Entry type"::Budget;
            JobDiffBuffer3.INSERT;
          END;
        UNTIL JobDiffBuffer[1].NEXT = 0;
    END;

    PROCEDURE HexInsertDiffBuffer@13(VAR JobLedgEntry@1003 : Record 169;VAR JobPlanningLine@1000 : Record 1003;LineType@1002 : 'Schedule,Usage';CurrencyType@1001 : 'LCY,FCY');
    BEGIN
      IF LineType = LineType::Schedule THEN
        WITH JobPlanningLine DO BEGIN
          IF Type = Type::Text THEN
            EXIT;
          IF NOT "Schedule Line" THEN
            EXIT;
          JobDiffBuffer[1].Type := Type;
          JobDiffBuffer[1]."No." := "No.";
          JobDiffBuffer[1]."Entry type" := JobDiffBuffer[1]."Entry type"::Budget;
          JobDiffBuffer[1]."Unit of Measure code" := "Unit of Measure Code";
          JobDiffBuffer[1]."Work Type Code" := "Work Type Code";
          //JobDiffBuffer[1].Quantity := Quantity; HEXGBJOB.01
          JobDiffBuffer[1].Quantity := "Qty. Posted";  //HEXGBJOB.01
          JobDiffBuffer[1]."Original Quantity" := "Original Quantity"; // HEXGBJOB.01
          JobDiffBuffer[1]."Original Purchase Unit Cost" := JobPlanningLine."Original Purchase Unit Cost";
              JobDiffBuffer[1]."Original IFRS15 Line Amt (LCY)" := JobPlanningLine."Original IFRS15 Line Amt (LCY)";
              JobDiffBuffer[1]."IFRS15 Line Amount (LCY)" := JobPlanningLine."IFRS15 Line Amount (LCY)";
          //MESSAGE('Job Planning Line Item %1, Quantity Poated %2',"No.", "Qty. Posted");
          IF CurrencyType = CurrencyType::LCY THEN BEGIN
            JobDiffBuffer[1]."Total Cost" := "Posted Total Cost (LCY)"; //HEXGBJOB.01 "Total Cost(LCY);
            JobDiffBuffer[1]."Line Amount" := "Posted Line Amount (LCY)"; // HEXGBJOB.01 "Line Amount (LCY)";
            JobDiffBuffer[1]."Original Total Cost" := "Original Total Cost (LCY)"; //HEXGBJOB.01
          END ELSE BEGIN
            JobDiffBuffer[1]."Total Cost" := "Posted Total Cost";   // HEXGBJOB.01 "Total Cost";
            JobDiffBuffer[1]."Line Amount" := "Posted Line Amount"; //HEXGBJOB.01 "Line Amount";
            JobDiffBuffer[1]."Original Total Cost" := "Original Total Cost"; //HEXGBJOB.01
          END;
          JobDiffBuffer[2] := JobDiffBuffer[1];
          IF JobDiffBuffer[2].FIND THEN BEGIN
            JobDiffBuffer[2].Quantity :=
              JobDiffBuffer[2].Quantity + JobDiffBuffer[1].Quantity;
            JobDiffBuffer[2]."Original Quantity" :=
              JobDiffBuffer[2]."Original Quantity" + JobDiffBuffer[1]."Original Quantity"; //HEXGBJOB.01
            JobDiffBuffer[2]."Total Cost" :=
              JobDiffBuffer[2]."Total Cost" + JobDiffBuffer[1]."Total Cost"; //HEXGBJOB.01
            JobDiffBuffer[2]."Original Total Cost" :=
              JobDiffBuffer[2]."Original Total Cost" + JobDiffBuffer[1]."Original Total Cost"; //HEXGBJOB.01
            JobDiffBuffer[2]."Line Amount" :=
              JobDiffBuffer[2]."Line Amount" + JobDiffBuffer[1]."Line Amount";
            JobDiffBuffer[2]."Original IFRS15 Line Amt (LCY)" := JobDiffBuffer[2]."Original IFRS15 Line Amt (LCY)" + JobDiffBuffer[1]."Original IFRS15 Line Amt (LCY)"; //HEX
            JobDiffBuffer[2]."IFRS15 Line Amount (LCY)" := JobDiffBuffer[2]."IFRS15 Line Amount (LCY)" + JobDiffBuffer[1]."IFRS15 Line Amount (LCY)";
            JobDiffBuffer[2].MODIFY;
          END ELSE
            JobDiffBuffer[1].INSERT;
        END;

      IF LineType = LineType::Usage THEN
        WITH JobLedgEntry DO BEGIN
          IF "Entry Type" <> "Entry Type"::Usage THEN
            EXIT;
          JobDiffBuffer[1].Type := Type;
          JobDiffBuffer[1]."No." := "No.";
          JobDiffBuffer[1]."Entry type" := JobDiffBuffer[1]."Entry type"::Usage;
          JobDiffBuffer[1]."Unit of Measure code" := "Unit of Measure Code";
          JobDiffBuffer[1]."Work Type Code" := "Work Type Code";
          JobDiffBuffer[1].Quantity := Quantity;
          JobDiffBuffer[1]."Original Quantity" := Quantity; //HEXGBJOB.01
          //MESSAGE('Item %1, Quantity Poated %2',"No.",Quantity);
          IF CurrencyType = CurrencyType::LCY THEN BEGIN
            JobDiffBuffer[1]."Total Cost" := "Total Cost (LCY)";
            JobDiffBuffer[1]."Line Amount" := "Line Amount (LCY)";
            JobDiffBuffer[1]."Original Total Cost" := "Original Total Cost (LCY)"; //HEXGBJOB.01
          END ELSE BEGIN
            JobDiffBuffer[1]."Total Cost" := "Original Total Cost";
            JobDiffBuffer[1]."Line Amount" := "Line Amount";
            // HEXGBJOB.01 >>
            JobDiffBuffer[1]."Original Total Cost" := "Original Total Cost";
            JobDiffBuffer[1]."Original Line Amount" := "Line Amount";
            // HEXGBJOB.01 <<
          END;
          JobDiffBuffer[2] := JobDiffBuffer[1];
          IF JobDiffBuffer[2].FIND THEN BEGIN
            JobDiffBuffer[2].Quantity :=
              JobDiffBuffer[2].Quantity + JobDiffBuffer[1].Quantity;
            // HEXGBJOB.01 >>
            JobDiffBuffer[2]."Original Quantity" :=
              JobDiffBuffer[2]."Original Quantity" + JobDiffBuffer[1]."Original Quantity";
            // HEXGBJOB.013 <<
            JobDiffBuffer[2]."Total Cost" :=
              JobDiffBuffer[2]."Total Cost" + JobDiffBuffer[1]."Total Cost";
            // HEXGBJOB.01 >>
            JobDiffBuffer[2]."Original Total Cost" :=
              JobDiffBuffer[2]."Original Total Cost" + JobDiffBuffer[1]."Original Total Cost";
            // HEXGBJOB.01 <<
            JobDiffBuffer[2]."Line Amount" :=
              JobDiffBuffer[2]."Line Amount" + JobDiffBuffer[1]."Line Amount";
            JobDiffBuffer[2].MODIFY;
          END ELSE
            JobDiffBuffer[1].INSERT;
        END;
    END;

    PROCEDURE UpdateGLAnalysisRecords@1000000007();
    VAR
      GLEntry@1000000004 : Record 17;
      GLAnalysis@1000000003 : Record 50007;
      DimensionEntry@1000000002 : Record 480;
      GLSetup@1000000001 : Record 98;
      LCnt@1000000000 : Integer;
    BEGIN
      //18052016 GMP Start

      GLSetup.GET;
      LCnt := GLAnalysis.COUNT;

      IF LCnt = 0  THEN
        GLEntry.SETFILTER(GLEntry."Entry No.", '>%1',  LCnt)
      ELSE
      BEGIN
        GLAnalysis.FINDLAST;
        GLEntry.SETFILTER(GLEntry."Entry No.", '>%1', GLAnalysis."Entry No");
      END;



        IF GLEntry.FINDSET THEN
        BEGIN
          //Window.OPEN('#1#################################\\' + LText001 + FORMAT( GLEntry."Entry No." ));
          REPEAT
          GLAnalysis.INIT;
          GLAnalysis."Entry No" := GLEntry."Entry No.";
          GLAnalysis."G/L Account No." := GLEntry."G/L Account No.";
          GLEntry.CALCFIELDS("G/L Account Name");
          GLAnalysis."G/L Account Name" := GLEntry."G/L Account Name";
          GLAnalysis."Posting Date" := GLEntry."Posting Date";
          GLAnalysis.Amount:=GLEntry.Amount;
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
          GLAnalysis."VAT Prod. Posting Group":= GLEntry."VAT Prod. Posting Group";

          DimensionEntry.RESET;
          DimensionEntry.SETRANGE("Dimension Set ID",GLEntry."Dimension Set ID");
          IF DimensionEntry.FINDFIRST THEN
          BEGIN
          REPEAT
            DimensionEntry.CALCFIELDS("Dimension Value Name");
            IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
            BEGIN
                GLAnalysis."Dimension 1" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 1 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
            BEGIN
                GLAnalysis."Dimension 2" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 2 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
            BEGIN
                GLAnalysis."Dimension 3" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 3 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
            BEGIN
                GLAnalysis."Dimension 4" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 4 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 5 Code" THEN
        BEGIN
                GLAnalysis."Dimension 5" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 5 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 6 Code" THEN
            BEGIN
                GLAnalysis."Dimension 6" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 6 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 7 Code" THEN
            BEGIN
                GLAnalysis."Dimension 7" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 7 Name" := DimensionEntry."Dimension Value Name";
            END
            ELSE IF DimensionEntry."Dimension Code" = GLSetup."Shortcut Dimension 8 Code" THEN
            BEGIN
                GLAnalysis."Dimension 8" := DimensionEntry."Dimension Value Code";
                GLAnalysis."Dimension 8 Name" := DimensionEntry."Dimension Value Name";
            END

          UNTIL DimensionEntry.NEXT = 0;
          END;
          //Window.UPDATE(1, FORMAT( GLEntry."Entry No." ));
          GLAnalysis.INSERT;
          UNTIL GLEntry.NEXT =0;
          //Window.CLOSE;
      END

      //18052016 GMP END
    END;

    PROCEDURE CalJobDimValue@1000000008(JobNo@1000000000 : Code[20]) : Decimal;
    VAR
      GLAnalysis2@1000000003 : Record 50007;
    BEGIN
      GLAnalysis2.INIT;
      GLAnalysis2.SETRANGE("Dimension 5",JobNo);
      GLAnalysis2.SETFILTER("G/L Account No.",'>%1','399999');
      IF GLAnalysis2.FIND('-') THEN
        BEGIN
        REPEAT
          JobDimValue += GLAnalysis2.Amount;
        UNTIL GLAnalysis2.NEXT = 0;
        END;
      EXIT(JobDimValue);
    END;

    PROCEDURE CalJobDimValueSales@1000000009(JobNo@1000000000 : Code[20]) : Decimal;
    VAR
      GLAnalysis2@1000000003 : Record 50007;
    BEGIN
      GLAnalysis2.INIT;
      GLAnalysis2.SETRANGE("Dimension 5",JobNo);
      //GLAnalysis2.SETFILTER("G/L Account No.",'%1..%2','400000','499999');
      GLAnalysis2.SETFILTER("G/L Account No.",'400000..499999');
      IF GLAnalysis2.FIND('-') THEN
        BEGIN
        REPEAT
          JobDimValue += GLAnalysis2.Amount;
        UNTIL GLAnalysis2.NEXT = 0;
        END;
      EXIT(JobDimValue);
    END;

    BEGIN
    END.
  }
}
