tableextension 57021 "Hex Customer" extends Customer
{
    fields
    {
        //Customer integration
        field(50001; "PO Box"; Text[50])
        {
            // Add changes to table fields here
            Description = 'PO Box';
        }
        field(52001; "SFDC Active"; Option)
        {
            OptionCaption = 'In Draft,InActive,Active';
            OptionMembers = "In Draft",InActive,Active;
            Description = 'SFDC Active';
        }
        field(52002; HEXCountry; Code[10])
        {
            trigger OnValidate()
            var
                HEXFindcode: record "Country/Region";
            begin
                HEXFindcode.INIT;
                HEXFindcode.SetRange("ISO Code", HEXCountry);
                IF HEXFindcode.FindFirst() then
                    "Country/Region Code" := HEXFindcode.Code;
            end;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                IF NOT SFDCflag THEN
                    IF Blocked = Blocked::" " THEN
                        "SFDC Active" := "SFDC Active"::Active
                    ELSE
                        "SFDC Active" := "SFDC Active"::Inactive;
                SFDCflag := FALSE;
            end;

        }

    }
    var
        SFDCflag: Boolean;

    trigger OnInsert()
    begin
        SFDCflag := TRUE;
    end;

    trigger OnModify()
    var
        HexInventorySmax: Codeunit HexInventorySmax;
    begin
        HexInventorySmax.HexCustomerCreditCheck(Rec);//HEXSmax1
    end;
}