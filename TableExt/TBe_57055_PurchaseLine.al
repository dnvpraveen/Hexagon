tableextension 50002 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50000; "Sales Order"; Code[50])
        {
            Caption = 'Sales Order';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = filter(Order));
            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                if "Sales Order" <> '' then begin
                    SalesLine.reset;
                    SalesLine.SetRange("Document No.", "Sales Order");
                    SalesLine.SetRange("No.", "No.");
                    if not SalesLine.FindSet() then
                        Message('No hay ninguna parte con la referencia No. ' + "No." + ' en la Sales Order ' + "Sales Order");
                    if SalesLine.FindSet() then begin
                        "Quantity in SO" := SalesLine.Quantity;
                        if "Quantity in SO" <> Quantity then
                            Message('La cantidad de la SO es diferente a la cantidad de esta PO');
                    end;
                end;

            end;
        }
        field(50001; "To Stock"; Boolean)
        {
            Caption = 'To Stock';
            DataClassification = ToBeClassified;
        }
        field(50002; "Quantity in SO"; Decimal)
        {
            Caption = 'Quantity in SO';
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Shipment No."; Code[35])
        {
            Caption = 'Vendor Shipment No.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Vendor Invoice No.';
            DataClassification = ToBeClassified;
        }
    }
}
