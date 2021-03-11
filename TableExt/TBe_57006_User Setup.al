tableextension 57006 "Hex User Setup" extends "User Setup"
{
    fields
    {


        field(50000; "Change Job Status"; Boolean)
        {
            Description = '=Change Job Status';

        }

        field(50001; "PO Posting Rights"; Option)
        {
            OptionCaption = ' ,Receive,Invoice,Both';
            OptionMembers = ,Receive,Invoice,Both;
            Description = 'PO Posting Rights';
        }
        field(50002; "SO Posting Rights"; Option)
        {
            OptionCaption = '  ,Ship,Invoice,Both';
            OptionMembers = ,Ship,Invoice,Both;
            Description = 'SO Posting Rights';
        }
        //Description=IFRS15
        field(50100; "Allowed to Recognise Revenue"; Boolean)
        {
            Description = 'Allowed to Recognise Revenue';

        }


    }


}