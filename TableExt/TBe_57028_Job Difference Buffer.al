tableextension 57028 "Hex Job Difference Buffer" extends "Job Difference Buffer"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Original Quantity"; Decimal)
        {
            Description = 'Original Quantity';
        }
        Field(50001; "Original Total Cost"; Decimal)
        {
            Description = 'Original Total Cost';
        }
        Field(50002; "Original Line Amount"; Decimal)
        {
            Description = 'Original Line Amount';
        }
        Field(50003; "Original Purchase Unit Cost"; Decimal)
        {
            Description = 'Original Purchase Unit Cost';
        }
        Field(50105; "IFRS15 Line Amount (LCY)"; Decimal)
        {
            Description = 'IFRS15 Line Amount (LCY)';
        }
        Field(50107; "Original IFRS15 Line Amt (LCY)"; Decimal)
        {
            Description = 'Original IFRS15 Line Amt (LCY)';
        }
    }

}