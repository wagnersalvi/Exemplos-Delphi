unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PaginaControle: TPageControl;
    Inicial: TLabel;
    Label2: TLabel;
    dataInicial: TDateTimePicker;
    dataFinal: TDateTimePicker;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure DiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    botaoCal: array of TSpeedButton;
    meses: array of TGroupBox;
    abas: array of TTabSheet;
    ControlePagina: TPageControl;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  dataInicial.Date := StrToDate('01/01/2016');
  dataFinal.Date :=  StrToDate('31/12/2016');
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  i: Integer;
begin
  if botaoCal <> nil then
    begin
      for i := low(botaoCal) to high(botaoCal) do
      begin
        botaoCal[i].Destroy;

      end;
  end;
  SetLength(botaoCal, 0);
  if meses <> nil then
    begin
      for i := low(meses) to high(meses) do
      begin
        meses[i].Destroy;

      end;
  end;
  SetLength(meses, 0);
  if abas <> nil then
    begin
      for i := low(abas) to high(abas) do
      begin
        abas[i].Destroy;

      end;
  end;
  SetLength(abas, 0);
  botaoCal := nil;
  meses := nil;
  abas := nil;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  periodo: Integer;
  iano,imes, idia: Integer;
  posicao, altura: Integer;
  posicaoini, alturaini: Integer;
  posicaomesini, alturamesini: Integer;
  mes:string;
  mesdia, mesdiaanterior: Integer;
  rotulo: TLabel;
  DiferencaAno: Integer;
  xDataInicial, xDataFInal: Tdate;
  fundo: TShape;

begin
  if DataInicial.Date > dataFinal.Date then
    begin
      ShowMessage('Periodo Inválido!');
      abort;
    end;

  BitBtn4Click(sender);

  DiferencaAno:= StrToInt(FormatDateTime('yyyy',dataFinal.Date)) - StrToInt(FormatDateTime('yyyy',dataInicial.Date));

  // avaliando ano a no e criando abas
  SetLength(abas, DiferencaAno+1);
  for iano := low(abas) to high(abas) do
    begin
      abas[iano] := TTabSheet.Create(nil);
      abas[iano].Caption := IntToStr(StrToInt(FormatDateTime('yyyy',DataInicial.Date))+iano);
      abas[iano].PageControl := PaginaControle;
      abas[iano].PageIndex := iano;
      abas[iano].Tag := StrToInt(FormatDateTime('yyyy',DataInicial.Date))+iano;
      abas[iano].TabVisible := true;
      // avaliando mes a mes
      // avaliando mes a mes e criando os grupos
      posicao := 0;
      altura := 0;
      posicaoini := 0;
      alturaini := 0;
      SetLength(meses, 12);
      for imes := low(meses) to high(meses) do
        begin
          if posicao >= 4 then
            begin
              posicao := 0;
              altura := altura + 1;
            end;
            if imes =0 then
              mes := 'Janeiro';
            if imes =1 then
              mes := 'Fevereiro';
            if imes =2 then
              mes := 'Março';
            if imes =3 then
              mes := 'Abril';
            if imes =4 then
              mes := 'Maio';
            if imes =5 then
              mes := 'Junho';
            if imes =6 then
              mes := 'Julho';
            if imes =7 then
              mes := 'Agosto';
            if imes =8 then
              mes := 'Setembro';
            if imes =9 then
              mes := 'Outubro';
            if imes =10 then
              mes := 'Novembro';
            if imes =11 then
              mes := 'Dezembro';

            meses[imes] := TGroupBox.Create(nil);
            meses[imes].Parent :=  abas[iano];
            meses[imes].Width := 178 ;
            meses[imes].Height := 151;
            meses[imes].Left := posicaoini + (posicao * meses[imes].Width);
            meses[imes].top := alturaini + (altura * meses[imes].Height);
            meses[imes].Name := 'group'+IntToStr(imes)+IntToStr(iano);
            meses[imes].Caption := mes;
            meses[imes].Font.Style := [fsBold];
            rotulo := Tlabel.Create(nil);
            rotulo.Caption:= ' D    S    T    Q    Q    S    S';
            rotulo.Top := 15;
            rotulo.Left := 7;
            rotulo.Parent :=  meses[imes];
            rotulo.Font.Style := [fsBold];
            if (IntToStr(abas[iano].Tag) = FormatDateTime('yyyy',date))  then
              begin
                if imes+1 = StrToInt(FormatDateTime('mm',date)) then
                  begin
                    meses[imes].Font.Color := clNavy;
                    meses[imes].Font.Style := [fsBold];
                    rotulo.Font.Color := clNavy;
                    meses[imes].Color := clInactiveCaption;
                  end;
              end;

            posicao := posicao +1;
        end;
      //
      // avaliando dia a dia, dentro do grupo correto e da aba correta
      if iano = low(abas) then
        xDataInicial:= DataInicial.date
      else
        xDataInicial := StrTODate('01/01/'+IntToStr(abas[iano].Tag));

      if iano = high(abas) then
        xDataFinal:= DataFinal.date
      else
        xDataFinal := StrTODate('01/01/'+IntToStr(StrToInt(FormatDateTime('yyyy',DataInicial.Date))+iano+1));

      periodo := StrToInt(FloatToStr(trunc(xDataFinal - xDataInicial)+1));
      posicao := 0;
      altura := 0;
      posicaoini := 1;
      alturaini := 30;

      SetLength(botaoCal, periodo);
      mesdiaanterior := StrToInt(FormatDateTime('mm',xDataInicial));
      for idia := low(botaoCal) to high(botaoCal) do
        begin
          mesdia := StrToInt(FormatDateTime('mm',xDataInicial+idia));
          if (mesdia <> mesdiaanterior) then
            altura := 0;

          if idia = 0 then
            begin
              posicao := dayofweek(xDataInicial)-1;
            end;
          if (posicao >= 7)  then
            begin
              posicao := 0;
              altura := altura + 1;
            end;

          botaoCal[idia] := TSpeedButton.Create(nil);
          botaoCal[idia].Width := 25 ;
          botaoCal[idia].Height := 20;
          botaoCal[idia].Left := posicaoini + (posicao * botaoCal[idia].Width);
          botaoCal[idia].top := alturaini + (altura * botaoCal[idia].Height);
          botaoCal[idia].Name := 'btnCal'+IntToStr(idia)+IntToStr(imes)+IntToStr(iano);
          botaoCal[idia].Caption := FormatDateTime('dd',xDataInicial+idia);
          botaoCal[idia].Parent :=  meses[StrToInt(FormatDateTime('mm',xDataInicial+idia))-1];
          botaoCal[idia].Tag :=  StrToInt(FormatDateTime('yyyymmdd',xDataInicial+idia));
          botaoCal[idia].OnClick := diaClick;
          botaoCal[idia].Font.Style := [];
          botaoCal[idia].Font.Color := clBlack;
          botaoCal[idia].Transparent := true;
          botaoCal[idia].Flat := true;
          if (dayofweek(xdataInicial+idia) = 1) or (dayofweek(xdataInicial+idia) = 7) then
             botaoCal[idia].Font.Color := clRed;
          if (StrToDate(DateToStr(xdataInicial+idia)) = date)  then
            begin
              botaoCal[idia].Font.Style := [fsBold];
              botaoCal[idia].Font.Color := clNavy;
              fundo := TShape.Create(nil);
              fundo.Left := botaoCal[idia].Left;
              fundo.top := botaoCal[idia].top;
              fundo.Width := botaoCal[idia].Width;
              fundo.Height := botaoCal[idia].Height;
              fundo.Brush.Color := clActiveCaption ;
              fundo.Parent :=  meses[StrToInt(FormatDateTime('mm',xDataInicial+idia))-1];
              botaoCal[idia].BringToFront;
            end;

          posicao := posicao +1;
          mesdiaanterior := mesdia;
        end;

    end;
end;

Procedure TForm1.DiaClick(Sender: TObject);
var
  data: string;
begin
  data := IntToStr((Sender as TSpeedButton).Tag);
  ShowMessage('A data clicada é '+copy(data,7,2)+'/'+copy(data,5,2)+'/'+copy(data,1,4));
end;


end.

