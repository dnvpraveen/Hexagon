page 50091 "Inventario Fisico Hexagon"
{
    ApplicationArea = All;
    Caption = 'Inventario Fisico Hexagon';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;

    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Inventory = filter(<> 0));

    layout
    {
        area(content)
        {
            group("Bodega")
            {
                Caption = 'Bodega Ajuste';
                field("Bodega Ajuste"; BodegaAjuste)
                {
                    ApplicationArea = all;

                }
                field("Ubicacion"; UbicacionDestino)
                {
                    ApplicationArea = all;

                }
            }
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("Inventario Fisico"; Rec."Cantidad a Ajustar")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        REC.Diferencia := REC.Inventory - REC."Cantidad a Ajustar";
                    end;

                }
                field("Diferencia"; rec.Diferencia)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bodega Destino field.';
                    ;
                }
                field("Bodega Destino"; Rec."Bodega Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bodega Destino field.';
                }
                field("Ubicacion Destino"; Rec."Ubicacion Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ubicacion Destino field.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Inventory")
            {
                Caption = '&Inventario';
                action("Registrar Inventario")
                {
                    Caption = 'Registrar Inventario';
                    Image = Post;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()


                    var
                        SalesHeader: Record "Sales Header";
                        SalesOrder: Page "Sales Order";
                        ItemJnl: Record "Item Journal Line";
                        PageItemJnl: Page "Item Journal";
                        Item: Record Item;
                        Linea: Integer;
                        BinConten: Record "Bin Content";
                        ItemLedger: Record "Item Ledger Entry";
                        NoSeries: Record "No. Series Line";
                        Document: Code[50];
                        Bodegas: Record Location;
                        Bins: Record Bin;
                    begin
                        if Confirm('Desea registrar el inventrio de los productos seleccionados?') then begin
                            Document := '';
                            NoSeries.FindSet();
                            NoSeries.SetRange("Series Code", 'ITEM-JNL');
                            NoSeries.FindSet();
                            Document := IncStr(NoSeries."Last No. Used");

                            ItemJnl.Reset();
                            ItemJnl.SetRange("Journal Batch Name", 'DEFAULT');
                            ItemJnl.SetRange("Journal Template Name", 'ITEM');
                            IF ItemJnl.FindSet() then
                                repeat
                                    ItemJnl.Delete();
                                UNTIL ItemJnl.Next() = 0;
                            Commit();
                            Linea := 1000;


                            Item.Reset();
                            Item.SetFilter("Cantidad a Ajustar", '<>0');
                            //item.SetFilter(Diferencia, '<>0');
                            Item.FindSet();
                            repeat
                                if Item."Bodega Destino" = '' then
                                    Error('Falta bodega destino en el producto ' + Item."No.");
                                // if Item."Ubicacion Destino" = '' then
                                //   Error('Falta ubicacion en el producto ' + Item."No.");
                                ItemLedger.RESET;
                                ItemLedger.SetRange("Item No.", Item."No.");
                                ItemLedger.SetFilter("AkkOn-Entry/Exit No.", '<>''''');
                                IF ItemLedger.FindLast() then;
                                IF Item.Diferencia <= 0 THEN begin
                                    ItemJnl.Init();
                                    ItemJnl."Journal Batch Name" := 'DEFAULT';
                                    ItemJnl."Journal Template Name" := 'ITEM';
                                    ItemJnl."Posting Date" := Today;
                                    ItemJnl.Validate("Posting Date");
                                    ItemJnl."Line No." := Linea;
                                    ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Positive Adjmt.";
                                    ItemJnl.Validate("Item No.", Item."No.");
                                    ItemJnl.Validate(Quantity, Abs(item."Cantidad a Ajustar"));
                                    ItemJnl."Document No." := Document;
                                    ItemJnl."Location Code" := Item."Bodega Destino";
                                    ItemJnl."Bin Code" := Item."Ubicacion Destino";
                                    ItemJnl."AkkOn-Entry/Exit No." := ItemLedger."AkkOn-Entry/Exit No.";
                                    ItemJnl."AkkOn-Entry/Exit Date" := ItemLedger."AkkOn-Entry/Exit Date";
                                    ItemJnl."Entry/Exit Point" := ItemLedger."Entry/Exit Point";
                                    ItemJnl.Insert();
                                    Linea += 1000;

                                END ELSE begin
                                    BinConten.Reset();
                                    BinConten.SetRange("Item No.", Item."No.");
                                    BinConten.SetFilter("Quantity (Base)", '>0');
                                    if BinConten.FindSet() then
                                        repeat
                                            ItemJnl.Init();
                                            ItemJnl."Journal Batch Name" := 'DEFAULT';
                                            ItemJnl."Journal Template Name" := 'ITEM';
                                            ItemJnl."Posting Date" := Today;
                                            ItemJnl."Line No." := Linea;
                                            ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Negative Adjmt.";
                                            ItemJnl.Validate("Item No.", Item."No.");
                                            BinConten.CalcFields("Quantity (Base)");
                                            ItemJnl.Validate(Quantity, BinConten."Quantity (Base)");
                                            ItemJnl."Document No." := Document;
                                            ItemJnl."Location Code" := BinConten."Location Code";
                                            ItemJnl."Bin Code" := BinConten."Bin Code";
                                            ItemJnl.Insert();
                                            Linea += 1000;
                                        until BinConten.Next() = 0;

                                    ItemJnl.Init();
                                    ItemJnl."Journal Batch Name" := 'DEFAULT';
                                    ItemJnl."Journal Template Name" := 'ITEM';
                                    ItemJnl."Posting Date" := Today;
                                    ItemJnl.Validate("Posting Date");
                                    ItemJnl."Line No." := Linea;
                                    ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Positive Adjmt.";
                                    ItemJnl.Validate("Item No.", Item."No.");
                                    ItemJnl.Validate(Quantity, Abs(Item."Cantidad a Ajustar"));
                                    ItemJnl."Document No." := Document;
                                    ItemJnl."Location Code" := Item."Bodega Destino";
                                    ItemJnl."Bin Code" := Item."Ubicacion Destino";
                                    ItemJnl."AkkOn-Entry/Exit No." := ItemLedger."AkkOn-Entry/Exit No.";
                                    ItemJnl."AkkOn-Entry/Exit Date" := ItemLedger."AkkOn-Entry/Exit Date";
                                    ItemJnl."Entry/Exit Point" := ItemLedger."Entry/Exit Point";
                                    ItemJnl.Insert();
                                    Linea += 1000;

                                end;

                                if Item.Diferencia <= 0 then begin
                                    BinConten.Reset();
                                    BinConten.SetRange("Item No.", Item."No.");
                                    BinConten.SetFilter("Quantity (Base)", '>0');
                                    if BinConten.FindSet() then
                                        repeat
                                            ItemJnl.Init();
                                            ItemJnl."Journal Batch Name" := 'DEFAULT';
                                            ItemJnl."Journal Template Name" := 'ITEM';
                                            ItemJnl."Posting Date" := Today;
                                            ItemJnl."Line No." := Linea;
                                            ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Negative Adjmt.";
                                            ItemJnl.Validate("Item No.", Item."No.");
                                            BinConten.CalcFields("Quantity (Base)");
                                            ItemJnl.Validate(Quantity, BinConten."Quantity (Base)");
                                            ItemJnl."Document No." := Document;
                                            ItemJnl."Location Code" := BinConten."Location Code";
                                            ItemJnl."Bin Code" := BinConten."Bin Code";
                                            ItemJnl.Insert();
                                            Linea += 1000;
                                        until BinConten.Next() = 0;
                                end else begin
                                    ItemJnl.Init();
                                    ItemJnl."Journal Batch Name" := 'DEFAULT';
                                    ItemJnl."Journal Template Name" := 'ITEM';
                                    ItemJnl."Posting Date" := Today;
                                    ItemJnl."Line No." := Linea;
                                    ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Positive Adjmt.";
                                    ItemJnl.Validate("Item No.", Item."No.");
                                    ItemJnl.Validate(Quantity, Item.Diferencia);
                                    ItemJnl."Document No." := Document;
                                    if BodegaAjuste = '' then
                                        Error('La bodega de ajuste esta vacia');
                                    if UbicacionDestino = '' then
                                        Error('La Ubicacion de ajuste esta vacia');
                                    Bodegas.get(BodegaAjuste);
                                    bins.get(Bodegas.Code, UbicacionDestino);
                                    ItemJnl."Location Code" := BodegaAjuste;
                                    ItemJnl."Bin Code" := UbicacionDestino;
                                    ItemJnl.Insert();
                                    Linea += 1000;
                                end;
                            until Item.Next() = 0;
                            PageItemJnl.Run();


                            Message('Inventario Insertado');
                        end;

                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        REC.SetFilter("Cantidad a Ajustar", '<>0');
        IF rec.FindSet() then
            REPEAT
                rec.Diferencia := REC.Inventory - rec."Cantidad a Ajustar";
                if rec."Cantidad a Ajustar" = 0 then
                    rec.Diferencia := 0;
                REC.Modify();
            UNTIL REC.Next() = 0;
        REC.Reset();

    end;

    var
        BodegaAjuste: code[50];
        UbicacionDestino: Code[50];

}
