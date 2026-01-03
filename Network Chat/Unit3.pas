unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button2Click(Sender: TObject);
begin
  Close();
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Beep;
  if MessageBox(Handle,'This will overwrite Keyword list, are you sure : ','Confirm',MB_YESNO) = IDYES then
    BEGIN
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
                    'Data\Highlight\list.ini');
    END;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
                    'Data\Highlight\list.ini');
  StatusBar1.Panels[0].Text := 'Keywords count : ' +
                                IntToStr(Memo1.Lines.Count);
end;

end.
