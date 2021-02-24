
tableextension 57005 DeferralHeader extends "Deferral Header"
{
    fields
    {
        field(87000; "End Date"; Date)
        {
            Description = 'End Date';

        }
        field(87001; "No. of Days"; Integer)
        {
            Description = 'No. of Days';

        }
        field(87002; "Daily Deferral"; Decimal)
        {
            Description = 'Daily Deferral';

        }
        field(87003; "Processed"; Boolean)
        {
            Description = 'Processed';

        }

    }

}