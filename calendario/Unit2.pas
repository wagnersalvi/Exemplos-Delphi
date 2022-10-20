unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TForm2 = class(TForm)
    Reiniciar: TButton;
    botao11: TSpeedButton;
    botao12: TSpeedButton;
    botao13: TSpeedButton;
    botao21: TSpeedButton;
    botao22: TSpeedButton;
    botao23: TSpeedButton;
    botao31: TSpeedButton;
    botao32: TSpeedButton;
    botao33: TSpeedButton;
    procedure ReiniciarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure botaoClick(Sender: TObject);
    procedure JogadaMaquina;
    procedure AvaliaGanhador(xValorConsiderado: String);
  private
    { Private declarations }
  public
    { Public declarations }
    xJogada: Integer;
    Jogadas: Array of String;
    FimJogo: boolean;

  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.ReiniciarClick(Sender: TObject);
var i: integer;
begin
  for i := 0 to ComponentCount -1 do
   begin
     if Components[I].ClassType = TSpeedButton then
       begin
         TSpeedButton(Components[i]).Caption := '';
       end;
   end;
   xJogada := 0;
   SetLength(Jogadas,0);
   SetLength(Jogadas,9);
   FimJogo:= False;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  ReiniciarClick(Sender);
end;

procedure TForm2.botaoClick(Sender: TObject);
begin
  if FimJogo = false then
   begin
      if TSpeedButton(Sender).Caption <> '' then
        begin
          ShowMessage('Posição já escolhida');
          abort;
        end;

      TSpeedButton(Sender).Caption := 'X';
      Jogadas[TSpeedButton(Sender).Tag] := 'X';
      xJogada := xJogada +1;
      JogadaMaquina;
      AvaliaGanhador('X');
      AvaliaGanhador('0');
   end;
end;

procedure TForm2.JogadaMaquina;
var AchouVago: Boolean;
xPosicaoJogar, i : Integer;
begin
  if xJogada <9 then
    begin
      AchouVago := False;
      while AchouVago  = false do
        begin
          xPosicaoJogar := Random(9);
          for i := 0 to ComponentCount -1 do
           begin
             if Components[I].ClassType = TSpeedButton then
               begin
                 if (TSpeedButton(Components[i]).Tag = xPosicaoJogar + 1) and
                    (TSpeedButton(Components[i]).Caption = '') then
                   begin
                       TSpeedButton(Components[i]).Caption := '0';
                       Jogadas[TSpeedButton(Components[i]).Tag] := '0';
                       AchouVago:= true;
                       xJogada := xJogada +1;
                   end;
               end;
           end;
        end;
    end;
end;

procedure TForm2.AvaliaGanhador(xValorConsiderado: String);
var Mensagem: String;
begin
  if FimJogo = false then
    begin
      if xValorConsiderado = 'X' then
        Mensagem := 'Você Ganhou!'
      else
        Mensagem := 'Você Perdeu!';
         // horizontal
      if ((Jogadas[0] = Jogadas[1]) and (Jogadas[1] = Jogadas[2]) and (Jogadas[2] = xValorConsiderado)) or
         ((Jogadas[3] = Jogadas[4]) and (Jogadas[4] = Jogadas[5]) and (Jogadas[5] = xValorConsiderado)) or
         ((Jogadas[6] = Jogadas[7]) and (Jogadas[7] = Jogadas[8]) and (Jogadas[8] = xValorConsiderado)) or
         // vertical
         ((Jogadas[0] = Jogadas[3]) and (Jogadas[3] = Jogadas[6]) and (Jogadas[6] = xValorConsiderado)) or
         ((Jogadas[1] = Jogadas[4]) and (Jogadas[4] = Jogadas[7]) and (Jogadas[7] = xValorConsiderado)) or
         ((Jogadas[2] = Jogadas[5]) and (Jogadas[5] = Jogadas[8]) and (Jogadas[8] = xValorConsiderado)) or
         // Diagonal
         ((Jogadas[0] = Jogadas[4]) and (Jogadas[4] = Jogadas[8]) and (Jogadas[8] = xValorConsiderado)) or
         ((Jogadas[2] = Jogadas[4]) and (Jogadas[4] = Jogadas[6]) and (Jogadas[6] = xValorConsiderado)) then
        begin
          ShowMessage(Mensagem);
          FimJogo:= True;
        end
      else
        begin
          if xJogada = 9 then
            begin
              ShowMessage('Empate');
              FimJogo:= True;
            end;
        end;
    end;
end;

end.
