page 55031 HexCustomerCreditCheck
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = HexCustomerCreditCheck;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field(ERPCompanyNo; ERPCompanyNo)
                {
                }
                field("No."; "No.")
                {
                }
                field("Our Account No."; "Our Account No.")
                {
                }
                field("Credit Limit (LCY)"; "Credit Limit (LCY)")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(Name; Name)
                {
                }
                field("Name 2"; "Name 2")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(CustomerOverDue; CustomerOverDue)
                {
                }
                field(BypassCreditCheck; BypassCreditCheck)
                {
                }
                field(CustomerAvailableCredit; CustomerAvailableCredit)
                {
                }
                field(Status; Status)
                {
                }
                field(Message; Message)
                {
                }
                field(ModifyDate; ModifyDate)
                {
                }
                field(TargetSystem; TargetSystem)
                {
                }
            }
        }
    }

    actions
    {
    }
}

