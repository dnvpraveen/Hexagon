tableextension 57026 "Hex Purchase Header" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Job No."; Code[20])
        {
            Description = 'Job No.';

        }
        field(55001; "Cancel Short Close"; Option)
        {
            OptionCaption = ' ,Cancelled,Short Closed';
            OptionMembers = " ",Cancelled,"Short Closed";
            Description = 'Cancel Short Close';
        }
    }


}