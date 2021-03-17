tableextension 57038 "hex Requisition Line" extends "Requisition Line"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Job Task No."; Code[20])
        {
            Description = 'Job Task No.';
        }
        field(50001; "Job Planning Line No."; Integer)
        {
            Description = 'Job Planning Line No.';
        }
    }

    var
}