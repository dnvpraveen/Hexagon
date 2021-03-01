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
                    Page.Run(50111);
                end;


            }

        }



    }


}

