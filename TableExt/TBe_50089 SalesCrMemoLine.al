tableextension 50089 SalesCrMemoLineExt extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50007; "Doc. Line Discount %_HGN"; Decimal)
        {
            CaptionML = ENU = 'Doc. Line Discount %';
        }
        field(50008; "Doc. Line Amount_HGN"; Decimal)
        {
            CaptionML = ENU = 'Doc. Line Discount %';
        }
        field(50011; "Doc. Unit Price_HGN"; Decimal)
        {
            Caption = 'Doc. Unit Price_HGN';
            DataClassification = CustomerContent;
        }
        field(50012; "Doc. Qty_HGN"; Decimal)
        {
            Caption = 'Doc. Qty_HGN';
            DataClassification = CustomerContent;
        }
        field(50013; "Doc. VAT %_HGN"; Decimal)
        {
            Caption = 'Doc. VAT %_HGN';
            DataClassification = CustomerContent;
        }
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
