tableextension 57053 "Treasury Payments" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50092; "Sent To Approval"; Boolean)
        {
            Caption = 'Sent To Approval';
            DataClassification = ToBeClassified;
        }
        field(50093; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = ToBeClassified;
        }
        field(50094; "Date Sent To Approval"; DateTime)
        {
            Caption = 'Date Sent To Approval';
            DataClassification = ToBeClassified;
        }
        field(50095; "Date Approved"; DateTime)
        {
            Caption = 'Date Approved';
            DataClassification = ToBeClassified;
        }
        field(50096; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = ToBeClassified;
        }
        field(50097; "Date Paid"; DateTime)
        {
            Caption = 'Date Paid';
            DataClassification = ToBeClassified;
        }
        field(50098; "Approved by"; Code[100])
        {
            Caption = 'Approved by';
            DataClassification = ToBeClassified;
        }
        field(50099; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
        field(50100; "Sent to Appoval By"; Code[100])
        {
            Caption = 'Sent to Appoval By';
            DataClassification = ToBeClassified;
        }
        field(50101; "Bank for Payment"; Code[100])
        {
            Caption = 'Bank for Payment';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50102; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Paid By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50104; "Paid Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

    }
}
