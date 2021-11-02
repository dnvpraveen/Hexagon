tableextension 57004 deferralTemplate extends "Deferral Template"
{
    fields
    {
        field(87000; "P&L Deferral Account"; Code[20])
        {
            //DataClassification = ToBeClassified;
            Description = 'P&L Deferral Account';
            TableRelation = "G/L Account" WHERE("Account Type" = const(Posting), Blocked = filter(false));
            //"G/L Account" WHERE (Account Type=CONST(Posting),Blocked=CONST(No))
        }
    }
}
