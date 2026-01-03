program Project1;

uses
  Forms,
  windows,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {config},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.RES}

begin
  SetLastError(NO_ERROR);
  CreateMutex (nil, False, 'MonMutexProject1');
  if GetLastError<>ERROR_ALREADY_EXISTS then
  begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tconfig, config);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
  end;
end.
