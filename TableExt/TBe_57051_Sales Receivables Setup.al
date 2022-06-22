tableextension 57051 "Hex SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(55019; "Zero Value Account"; Code[20])
        {
            Description = 'Zero Value Account';
        }
        field(55020; "Zero Value No. Series"; Code[10])
        {
            Description = 'Zero Value No. Series';
        }
    }

}