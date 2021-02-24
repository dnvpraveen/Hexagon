tableextension 57004 deferralTemplate extends "Deferral Template"
{
    fields
    {
        field(87000; "P&L Deferral Account"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'P&L Deferral Account';
            TableRelation = "G/L Account" WHERE("Income/Balance" = CONST("Income Statement"), Blocked = filter(false));
        }
    }
}
