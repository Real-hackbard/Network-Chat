object config: Tconfig
  Left = 578
  Top = 151
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configuration'
  ClientHeight = 205
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 71
    Height = 13
    Caption = 'Network User :'
  end
  object Label2: TLabel
    Left = 27
    Top = 45
    Width = 57
    Height = 13
    Caption = 'Adresse IP :'
  end
  object Label3: TLabel
    Left = 59
    Top = 76
    Width = 25
    Height = 13
    Caption = 'Port :'
  end
  object Edit2: TEdit
    Left = 88
    Top = 8
    Width = 185
    Height = 21
    Hint = 'Votre pseudo sur le chat'
    MaxLength = 25
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object Edit3: TEdit
    Left = 88
    Top = 40
    Width = 185
    Height = 21
    Hint = 'Adresse IP d'#39'une personne ayant Pompom Chat'
    TabStop = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 152
    Width = 81
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 2
    TabStop = False
  end
  object Button2: TButton
    Left = 176
    Top = 152
    Width = 81
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
    TabStop = False
    OnClick = Button2Click
  end
  object checkwinboot: TCheckBox
    Left = 88
    Top = 112
    Width = 153
    Height = 17
    Hint = 
      'Si vous voulez que Pompom Chat se lance automatiquement au d'#233'mar' +
      'rage de Windows'
    TabStop = False
    Caption = 'Launch at Windows startup'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 88
    Top = 72
    Width = 73
    Height = 21
    TabStop = False
    TabOrder = 5
    Text = '12345'
    OnKeyPress = Edit1KeyPress
  end
  object Button3: TButton
    Left = 280
    Top = 8
    Width = 57
    Height = 20
    Caption = 'Look IP'
    TabOrder = 6
    TabStop = False
    OnClick = Button3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 186
    Width = 412
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object Button4: TButton
    Left = 344
    Top = 8
    Width = 57
    Height = 20
    Caption = 'Select'
    TabOrder = 8
    OnClick = Button4Click
  end
end
