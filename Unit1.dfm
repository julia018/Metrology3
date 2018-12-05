object Form1: TForm1
  Left = 246
  Top = 30
  Width = 1064
  Height = 662
  Caption = #1052#1077#1090#1088#1080#1082#1080' '#1089#1083#1086#1078#1085#1086#1089#1090#1080' '#1087#1086#1090#1086#1082#1072' '#1076#1072#1085#1085#1099#1093
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 0
    Top = 0
    Width = 1056
    Height = 32
    Align = alTop
    Alignment = taCenter
    Caption = #1052#1077#1090#1088#1080#1082#1080'  '#1089#1083#1086#1078#1085#1086#1089#1090#1080' '#1087#1086#1090#1086#1082#1072' '#1076#1072#1085#1085#1099#1093' JavaScript'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 725
    Top = 45
    Width = 133
    Height = 25
    Caption = #1050#1086#1076' JavaScript'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object vouge: TLabel
    Left = 544
    Top = 576
    Width = 3
    Height = 13
  end
  object gucci: TLabel
    Left = 632
    Top = 576
    Width = 3
    Height = 13
  end
  object cosmos: TLabel
    Left = 720
    Top = 576
    Width = 3
    Height = 13
  end
  object lblSpen: TLabel
    Left = 736
    Top = 80
    Width = 43
    Height = 20
    Caption = #1057#1087#1077#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSumSpen: TLabel
    Left = 584
    Top = 288
    Width = 5
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblChep: TLabel
    Left = 672
    Top = 304
    Width = 142
    Height = 20
    Caption = #1052#1077#1090#1088#1080#1082#1072' '#1063#1077#1087#1080#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 526
    Top = 326
    Width = 141
    Height = 20
    Caption = #1055#1086#1083#1085#1072#1103' '#1084#1077#1090#1088#1080#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 790
    Top = 326
    Width = 201
    Height = 20
    Caption = #1052#1077#1090#1088#1080#1082#1072' '#1074#1074#1086#1076#1072'-'#1074#1099#1074#1086#1076#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 510
    Top = 603
    Width = 5
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 793
    Top = 603
    Width = 5
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnopen: TButton
    Left = 897
    Top = 41
    Width = 145
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100'..'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnopenClick
  end
  object strngrd1: TStringGrid
    Left = 584
    Top = 105
    Width = 365
    Height = 176
    ColCount = 2
    Ctl3D = False
    DefaultColWidth = 180
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 7
    Top = 49
    Width = 442
    Height = 545
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btn1: TButton
    Left = 456
    Top = 64
    Width = 121
    Height = 33
    Caption = '<-'#1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 608
    Top = 40
    Width = 113
    Height = 33
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn2Click
  end
  object strngrd2: TStringGrid
    Left = 456
    Top = 352
    Width = 597
    Height = 246
    ColCount = 9
    Ctl3D = False
    DefaultColWidth = 65
    DefaultRowHeight = 80
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 5
    OnDrawCell = strngrd2DrawCell
  end
  object dlgOpen: TOpenDialog
    Filter = #1076#1086#1082'|*.txt'
    Left = 864
    Top = 39
  end
end
