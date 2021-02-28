tableextension 57024 "Hex Jobs Setup" extends "Jobs Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Dimension for Sales Link"; Code[20])
        {
            Description = 'Dimension for Sales Link';

        }
        field(60000; "Auto Consume"; Boolean)
        {
            Description = 'Auto Consume';
        }
    }




}