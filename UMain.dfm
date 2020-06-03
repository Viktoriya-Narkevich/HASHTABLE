object Form1: TForm1
  Left = 623
  Top = 210
  Width = 622
  Height = 445
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 329
    Height = 129
    TabOrder = 0
  end
  object OpenDialog1: TOpenDialog
    Left = 184
    Top = 328
  end
  object SaveDialog1: TSaveDialog
    Left = 280
    Top = 336
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 224
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object NNew: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        OnClick = NNewClick
      end
      object NOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = NOpenClick
      end
      object NSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = NSaveClick
      end
      object NSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        OnClick = NSaveAsClick
      end
      object NClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = NCloseClick
      end
      object NExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N7: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      object NAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = NAddClick
      end
      object NDelete: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = NDeleteClick
      end
      object NClear: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        OnClick = NClearClick
      end
    end
    object NFind: TMenuItem
      Caption = #1053#1072#1081#1090#1080
      OnClick = NFindClick
    end
  end
end
