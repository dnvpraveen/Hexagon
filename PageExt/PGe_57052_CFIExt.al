pageextension 50088 CFIExt extends "AkkOn-Documento CFDI"
{
    actions
    {
        addlast(Import)
        {
            action("Create Document")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempXMLBuffer: Record "XML Buffer";
                    xlInStrem: InStream;
                    xmlFile: XmlDocument;
                    Archivo: Text;
                    tab: XmlElement;
                    nodelist: XmlNodeList;
                    nodee: XmlNode;
                    nodee1: XmlNode;
                    element: XmlElement;
                    nodelistsec: XmlNodeList;
                    Instr: InStream;
                    Pos1: Integer;
                    Pos2: Integer;
                    PosDescription: Integer;
                    PosDescription2: Integer;
                    Header: Record "Purchase Header";
                    Lineas: Record "Purchase Line";
                    PSeutp: Record "Purchases & Payables Setup";
                    Series: Record "No. Series Line";
                    Document: Code[50];
                    Vendor: Record Vendor;
                    LineaTable: Integer;
                    Fecha: DateTime;


                begin
                    rec.CalcFields("AkkOn-XML Invoice");
                    PSeutp.get;
                    Series.Reset();
                    Series.SetRange("Series Code", PSeutp."Invoice Nos.");
                    Series.FindSet();
                    Document := IncStr(Series."Last No. Used");
                    Vendor.Reset();
                    Vendor.SetRange("VAT Registration No.", REC."AkkOn-VAT Registration No.");
                    Vendor.FindSet();
                    Series."Last No. Used" := Document;
                    Series.Modify();

                    Header.Reset;
                    Header.init;
                    Header."Document Type" := Header."Document Type"::Invoice;
                    Header."No." := Document;
                    Header.validate("Buy-from Vendor No.", Vendor."No.");
                    Header.Validate("Posting Date", Today);
                    Evaluate(Fecha, rec."AkkOn-Document Date");
                    Header."Document Date" := DT2Date(Fecha);
                    Header.validate("Document Date");
                    Header.validate("Vendor Invoice No.", rec."AkkOn-Series" + Rec."AkkOn-Folio No.");
                    Header.Insert();

                    rec."AkkOn-XML Invoice".Export('C:\NAV\' + format(rec."AkkOn-Series" + Rec."AkkOn-Folio No.") + '.xml');
                    UploadIntoStream('Escoja el XML', '', '', Archivo, Instr);
                    XmlDocument.ReadFrom(Instr, xmlFile);
                    xmlFile.GetRoot(tab);
                    LineaTable := 1000;
                    nodelist := tab.GetChildElements();
                    foreach nodee in nodelist do begin
                        element := nodee.AsXmlElement();
                        nodelistsec := element.GetChildElements();
                        Message(Format(nodee));
                        foreach nodee1 in nodelistsec do begin
                            if nodee1.AsXmlElement().Name = 'cfdi:Concepto' then begin
                                Lineas.init;
                                Lineas."Document No." := Header."No.";
                                Lineas."Document Type" := Header."Document Type";
                                Lineas."Line No." := LineaTable;
                                Lineas.Type := Lineas.Type::"G/L Account";
                                Lineas.Validate("No.", Vendor."Purchase G/L Account");
                                //DESCRIPCION
                                Pos1 := 0;
                                Pos2 := 0;
                                Pos1 := StrPos(Format(nodee1), 'Descripcion=') + 13;
                                Pos2 := StrPos(CopyStr(Format(nodee1), Pos1, 1000), '"') - 1;
                                Lineas.Description := CopyStr(Format(nodee1), Pos1, Pos2);
                                //VALOR UNITARIO
                                Pos1 := 0;
                                Pos2 := 0;
                                Pos1 := StrPos(Format(nodee1), 'ValorUnitario=') + 15;
                                Pos2 := StrPos(CopyStr(Format(nodee1), Pos1, 1000), '"') - 1;
                                Evaluate(Lineas."Direct Unit Cost", CopyStr(Format(nodee1), Pos1, Pos2));
                                Lineas.Validate("Direct Unit Cost");
                                //CANTIDAD
                                Pos1 := 0;
                                Pos2 := 0;
                                Pos1 := StrPos(Format(nodee1), 'Cantidad=') + 10;
                                Pos2 := StrPos(CopyStr(Format(nodee1), Pos1, 1000), '"') - 1;
                                Evaluate(Lineas.Quantity, CopyStr(Format(nodee1), Pos1, Pos2));
                                Lineas.Validate(Quantity);
                                LineaTable := LineaTable + 1000;

                                Lineas.Insert();
                            end;

                        end;


                    end;

                    Message('Factura Creada');

                end;
            }
        }
    }
}
