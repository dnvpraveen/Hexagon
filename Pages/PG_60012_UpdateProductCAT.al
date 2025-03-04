page 60012 "Update Product CAT"
{
    ApplicationArea = All;
    Caption = 'Update Product CAT';
    PageType = List;
    SourceTable = "Update Product CAT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Codigo de Producto"; Rec."Codigo de Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo Producto field.';
                }
                field("Product CAT Code"; Rec."Product CAT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo Product CAT field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UpdateProductCAT)
            {
                Caption = 'Actualizar Product CAT';
                Image = UpdateShipment;
                trigger OnAction()
                var
                    DefaultDimension: record "Default Dimension";
                begin
                    rec.FindSet();
                    repeat
                        DefaultDimension.Reset();
                        DefaultDimension.SetRange("Table ID", 27);
                        DefaultDimension.SetRange("No.", rec."Codigo de Producto");
                        DefaultDimension.SetRange("Dimension Code", 'PRODUCT CAT');
                        if DefaultDimension.FindSet() then begin
                            DefaultDimension."Dimension Value Code" := rec."Product CAT Code";
                            DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Code Mandatory";
                            DefaultDimension.Modify()
                        end else begin
                            DefaultDimension.Init();
                            DefaultDimension."Table ID" := 27;
                            DefaultDimension."No." := rec."Codigo de Producto";
                            DefaultDimension."Dimension Code" := 'PRODUCT CAT';
                            DefaultDimension.Validate("Dimension Value Code", REC."Product CAT Code");
                            DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Code Mandatory";
                            DefaultDimension.Insert();
                        end;
                    until rec.Next() = 0;
                    rec.FindSet();
                    Message('Productos actualizados correctamente');
                end;
            }
        }
    }
}
