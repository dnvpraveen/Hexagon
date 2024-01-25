tableextension 57011 "Hex Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        //Description=IFRS15
        field(55000; "Smax Line No."; Text[30])
        {
            Description = 'Smax Line No.';

        }
        field(55001; "Action Code"; Integer)
        {
            Description = 'Action Code';

        }
        field(55005; "Order Created"; Boolean)
        {
            Description = 'Order Created';

        }
        field(55006; "Order Type"; Code[10])
        {
            Description = 'Order Type';

        }
        field(55007; "Work Order No."; Text[30])
        {
            Description = 'Work Order No.';

        }
        field(55008; "Ready to Invoice"; Boolean)
        {
            Description = 'Ready to Invoice';
        }
        field(55011; "Line Status"; Text[30])
        {
            Description = 'Line Status';
        }
        field(55102; "Orden de Venta"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE("No." = FIELD("Document No.")));
        }
        field(55101; "No. Orden de Compra"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."External Document No." WHERE("No." = FIELD("Document No.")));
        }
        field(55103; "Fecha de Registro"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
        }

    }


}
