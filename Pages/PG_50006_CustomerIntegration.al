page 50006 CustomerIntegration
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.") { }
                field(Name; Name) { }
                field("Name 2"; "Name 2") { }
                field("Our Account No."; "Our Account No.") { }
                field(Address; Address) { }
                field("Address 2"; "Address 2") { }
                field(City; City) { }
                field(County; County) { }
                field("Country/Region Code"; "Country/Region Code") { }
                field("Post Code"; "Post Code") { }
                field("Currency Code"; "Currency Code") { }
                field("Phone No."; "Phone No.") { }
                field("PO Box"; "PO Box") { }
                field("E-Mail"; "E-Mail") { }
                field("VAT Registration No."; "VAT Registration No.") { }
                field("Fax No."; "Fax No.") { }
                field("SFDC Active"; "SFDC Active") { }
                field(Blocked; Blocked) { }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}