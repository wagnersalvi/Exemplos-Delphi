object Form1: TForm1
  Left = 192
  Top = 124
  Width = 762
  Height = 588
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Inicial: TLabel
    Left = 16
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Inicial'
  end
  object Label2: TLabel
    Left = 152
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Final'
  end
  object PaginaControle: TPageControl
    Left = 16
    Top = 56
    Width = 723
    Height = 488
    TabOrder = 0
  end
  object dataInicial: TDateTimePicker
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    CalAlignment = dtaLeft
    Date = 42535.5754141667
    Time = 42535.5754141667
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
  end
  object dataFinal: TDateTimePicker
    Left = 152
    Top = 24
    Width = 121
    Height = 21
    CalAlignment = dtaLeft
    Date = 42535.5754141667
    Time = 42535.5754141667
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object BitBtn3: TBitBtn
    Left = 296
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Criar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 376
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Limpar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BitBtn4Click
  end
end
