object Form3: TForm3
  Left = 548
  Top = 150
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Edit Highlight Keywords'
  ClientHeight = 305
  ClientWidth = 259
  Color = clBtnFace
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
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 241
    Height = 233
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 88
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    TabStop = False
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 286
    Width = 259
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end
