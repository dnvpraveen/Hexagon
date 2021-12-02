pageextension 57003 "hex Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addlast(Control1)
        {
            field("GMDD Name"; "GMDD Name")
            {
                Caption = 'GMDD Name';

            }
            // field(HexSeqID; HexSeqID)
            // {
            //     Caption = 'HexSeqID';
            // }
            // field(Indentation; Indentation)
            //{
            //  Caption = 'Indentation';
            //}
        }
    }
    actions
    {
        addbefore("&Balance")
        {
            action("GL Analysis")
            {
                ApplicationArea = All;
                Caption = 'GL Analysis';
                Image = Approve;
                InFooterBar = true;

                trigger OnAction();
                var
                    HexAnalysis: codeunit "Hex Jobs WIP Calc";
                begin
                    Message('Please wait for GL Analysis records to update');
                    HexAnalysis.UpdateGLAnalysisRecords();
                    Page.Run(50010);
                end;


            }

        }



    }
    trigger OnOpenPage()
    begin
        rec.SetCurrentKey(HexSeqID);
        rec.SetAscending(HexSeqID, false);
        //rec.SetFilter("Balance (LCY)", '> 50000');
    end;


}

