
codeunit 50001 UpdateExchangeRate
{
    trigger OnRun()

    begin
        GetRateforDateBanxico('USD', 'SF43718');
        GetRateforDateBanxico('EUR', 'SF46410');

    end;

    procedure GetRateforDateBanxico(Divisa: Code[20]; Codigo: Code[20])
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        ContentTxt: Text;
        Content: HttpContent;
        Root: JsonObject;
        CurRate: Decimal;
        CurRateTxt: text;
        CurDateTxT: Text;
        ExchangeRate: Record "Currency Exchange Rate";
        Pos: Integer;
        PosD: Integer;
        Jobject: JsonObject;
        Jtoken: JsonToken;
        TestFile: File;
        FileName: Text;
        tamano: BigInteger;
        Fecha: Date;
        MyWeekDay: Integer;
        FechaInicial: Date;
    begin
        Fecha := Today;
        FechaInicial := Fecha;
        MyWeekDay := DATE2DWY(Fecha, 1);
        if (MyWeekDay = 1) then begin
            Fecha := Fecha - 4
        end else
            if (MyWeekDay = 2) then
                Fecha := Fecha - 4 else
                Fecha := Fecha - 2;

        if Client.Get('https://www.banxico.org.mx/SieAPIRest/service/v1/series/' + Codigo + '/datos/' + FORMAT(Fecha, 0, 9) + '/' + FORMAT(Fecha, 0, 9) + '?mediaType=json&token=9246e2cdf744fdbe339c1e9c574e9aed2c6e84c60300055bd8724e40eb684657', Response) then begin
            if Response.IsSuccessStatusCode() then begin
                if Response.Content().ReadAs(ContentTxt) then begin
                    tamano := 0;
                    tamano := StrLen(ContentTxt);
                    ContentTxt := CopyStr(ContentTxt, tamano - 43, tamano - 10);
                    if ContentTxt.Contains('dato":"') then begin
                        Pos := StrPos(ContentTxt, 'dato":"');
                        CurRateTxt := CopyStr(ContentTxt, Pos + 7, 14);
                        PosD := StrPos(ContentTxt, 'fecha":"');
                        CurDateTxT := CopyStr(ContentTxt, PosD + 8, 20);
                        CurRateTxt := DelChr(CurRateTxt, '=', '}"]');
                        CurDateTxT := DelChr(CurDateTxT, '=', '}",:;dato]');
                        if Evaluate(CurRate, CurRateTxt) then begin
                            if CurRate > 100 then
                                CurRate := CurRate / 10000;
                            ExchangeRate.Reset();
                            ExchangeRate.SetRange("Currency Code", Divisa);
                            if Divisa = 'USD' THEN
                                ExchangeRate.SetRange("Starting Date", FechaInicial) ELSE
                                ExchangeRate.SetRange("Starting Date", ConvDate(CurDateTxT));
                            IF ExchangeRate.FindSet() THEN begin
                                ExchangeRate.Validate("Exchange Rate Amount", 1);
                                ExchangeRate.Validate("Relational Exch. Rate Amount", CurRate);
                                ExchangeRate.Validate("Adjustment Exch. Rate Amount", 1);
                                ExchangeRate.Validate("Relational Adjmt Exch Rate Amt", CurRate);
                                ExchangeRate.Modify(true);
                            end else begin
                                ExchangeRate.Init();
                                ExchangeRate."Currency Code" := Divisa;
                                IF Divisa = 'USD' THEN
                                    ExchangeRate."Starting Date" := FechaInicial ELSE
                                    ExchangeRate."Starting Date" := ConvDate(CurDateTxT);
                                ExchangeRate.Validate("Exchange Rate Amount", 1);
                                ExchangeRate.Validate("Relational Exch. Rate Amount", CurRate);
                                ExchangeRate.Validate("Adjustment Exch. Rate Amount", 1);
                                ExchangeRate.Validate("Relational Adjmt Exch Rate Amt", CurRate);
                                ExchangeRate.Insert();
                            end;
                        end else
                            message('There´s no data to read');
                    end;
                end;
            end;
        END;
    END;



    local procedure ConvDate(curdatetxt: text): Date
    var
        finaldate: Date;
    begin
        if Evaluate(finaldate, curdatetxt) then
            exit(finaldate);
    end;

}