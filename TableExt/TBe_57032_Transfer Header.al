tableextension 57032 "Hex Transfer Header" extends "Transfer Header"
{
    fields
    {
        // Add changes to table fields here
        field(55000; "Sell-to Customer No."; Code[20])
        {
            Description = 'Sell-to Customer No.';
        }
        field(55001; "Currency Code"; Code[10])
        {

            TableRelation = Currency;
        }
        field(55002; "Order Type"; Code[2])
        {
            Description = 'Order Type';
        }
        field(55003; "Order Class"; Code[3])
        {
            Description = 'Order Class';
        }
        field(55004; "Ship-to Contact"; Text[30])
        {
            Description = 'Ship-to Contact';
        }
        field(55005; "Sell-to Customer Name"; Text[50])
        {
            Description = 'Sell-to Customer Name';
        }
        field(55006; "Sell-to Customer Name 2"; Text[50])
        {
            Description = 'Sell-to Customer Name 2';
        }
        field(55007; "Ship-to Freight"; Text[30])
        {
            Description = 'Ship-to Freight';
        }
        field(55008; "Original Order No."; Text[35])
        {
            Description = 'Original Order No.';
        }
        field(55009; "Serial No."; Code[20])
        {
            Description = 'Serial No.';
        }
        field(55010; "SFDC No"; Text[30])
        {
            Description = 'SFDC No';
        }
        field(55011; "User Email"; Text[50])
        {
            Description = 'User Email';
        }

        field(55012; "Target System"; Text[30])
        {
            Description = 'Target System';
        }
        field(55013; "Smax Order No."; Text[35])
        {
            Description = 'Smax Order No.';
        }
        field(55014; "Action Code"; Integer)
        {
            Description = 'Action Code';
        }
        field(55015; "ERP Company No."; Code[10])
        {
            Description = 'ERP Company No.';
        }
        field(55016; "Parts Order No."; Text[30])
        {
            Description = 'Parts Order No.';
        }
        field(55017; "Freight Terms"; Text[30])
        {
            Description = 'Freight Terms';
        }

        field(55018; "Order Inserted"; Boolean)
        {
            Description = 'Order Inserted';
        }
        field(55019; "Order Disptached"; Boolean)
        {
            Description = 'Order Disptached';
        }
        field(55020; "Order Created"; Boolean)
        {
            Description = 'Order Created';
        }

        field(55021; "Integration Completed"; Boolean)
        {
            Description = 'Integration Completed';
        }
        field(55022; "Header Status"; Option)
        {
            Description = 'Header Status';
            OptionMembers = " ",Closed,Shipped,"Partially Shipped",Completed;
            OptionCaption = '  ,Closed,Shipped,Partially Shipped,Completed';
        }
        field(55023; "Ship-to Address"; Text[50])
        {
            Description = '"Ship-to Address"';
        }
        field(55024; "Ship-to Address2"; Text[50])
        {
            Description = 'Ship-to Address2';
        }
        field(55025; "Ship-to City"; Code[30])
        {
            Description = 'Ship-to City';
        }
        field(55026; "Ship-to Country"; Code[10])
        {
            Description = 'Ship-to Country';
        }
        field(55027; "Ship-to State"; Code[10])
        {
            Description = 'Ship-to State';
        }
        field(55028; "Zip Code"; Code[10])
        {
            Description = 'Zip Code';
            trigger OnValidate()
            begin
                IF "Sell-to Customer No." <> '' THEN BEGIN
                    "Transfer-to Name" := "Sell-to Customer Name";
                    "Transfer-to Name 2" := "Ship-to Contact";
                    "Transfer-to Address" := "Ship-to Address";
                    "Transfer-to Address 2" := "Ship-to Address2";
                    "Transfer-to Post Code" := "Zip Code";
                    "Transfer-to City" := "Ship-to City";
                    "Transfer-to County" := "Ship-to State";
                    "Trsf.-to Country/Region Code" := "Ship-to Country";
                END;
            end;

        }
    }


}