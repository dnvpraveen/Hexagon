tableextension 50089 SalesCrMemoLineExt extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50002; "Orden de Venta"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Cr.Memo Header"."External Document No." WHERE("No." = FIELD("Document No.")));
        }
        field(50001; "No. Orden de Compra"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Cr.Memo Header"."External Document No." WHERE("No." = FIELD("Document No.")));
        }
        field(50003; "Fecha de Registro"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Cr.Memo Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
        }
    }
}
