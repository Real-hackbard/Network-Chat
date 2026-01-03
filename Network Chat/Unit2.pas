unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WinInet, WinSock, ComCtrls, ShlObj, ActiveX;

type
  Tconfig = class(TForm)
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    checkwinboot: TCheckBox;
    Edit1: TEdit;
    Label3: TLabel;
    Button3: TButton;
    StatusBar1: TStatusBar;
    Button4: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
     { Public-Deklarationen }
    port : integer;
  end;

function GetIp(const HostName: string): string;

var
  config: Tconfig;

implementation

uses Unit1;

{$R *.DFM}
function BrowseComputer(DialogTitle: string; var CompName: string;
  bNewStyle: Boolean): Boolean;
  // bNewStyle: If True, this code will try to use the "new"
  // BrowseForFolders UI on Windows 2000/XP
const
  BIF_USENEWUI = 28;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  ComputerName: array[0..MAX_PATH] of Char;
  Title: string;
  WindowList: Pointer;
  ShellMalloc: IMalloc;
begin
  if Failed(SHGetSpecialFolderLocation(Application.Handle, CSIDL_NETWORK, ItemIDList)) then
    raise Exception.Create('Unable open browse computer dialog');
  try
    FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
    BrowseInfo.hwndOwner := Application.Handle;
    BrowseInfo.pidlRoot := ItemIDList;
    BrowseInfo.pszDisplayName := ComputerName;
    Title := DialogTitle;
    BrowseInfo.lpszTitle := PChar(Pointer(Title));
    if bNewStyle then
      BrowseInfo.ulFlags := BIF_BROWSEFORCOMPUTER or BIF_USENEWUI
    else
      BrowseInfo.ulFlags := BIF_BROWSEFORCOMPUTER;
    WindowList := DisableTaskWindows(0);
    try
      Result := SHBrowseForFolder(BrowseInfo) <> nil;
    finally
      EnableTaskWindows(WindowList);
    end;
    if Result then CompName := ComputerName;
  finally
    if Succeeded(SHGetMalloc(ShellMalloc)) then
      ShellMalloc.Free(ItemIDList);
  end;
end;

function GetIp(const HostName: string): string;
type
    TaPInAddr = array[0..10] of PInAddr;
    PaPInAddr = ^TaPInAddr;
var
    phe: PHostEnt;
    pptr: PaPInAddr;
    i: Integer;
    GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PChar(HostName));

  if phe = nil then
  begin
    Screen.Cursor := crDefault;
    config.StatusBar1.Panels[0].Text := 'User not found or unknown';
    Exit;
  end;

  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  Application.ProcessMessages;
  while pPtr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;
  config.StatusBar1.Panels[0].Text := 'User found IP';
  Screen.Cursor := crDefault;
  config.StatusBar1.SetFocus;
end;

procedure Tconfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  port := StrToInt(Edit1.Text);
  //Form1.StatusBar1.Panels[3].Text := Edit3.Text;
end;

procedure Tconfig.Button3Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Edit3.Text := GetIp(PChar(Edit2.Text));
  Form1.StatusBar1.Panels[3].Text := Edit3.Text;
end;

procedure Tconfig.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#08, '0'..'9']) then 
    Key := #0; 
end;

procedure Tconfig.Button2Click(Sender: TObject);
begin
  Close();
end;

procedure Tconfig.Button4Click(Sender: TObject);
var
  Computer: string;
begin
  BrowseComputer('...', Computer, True);
  Edit2.Text := Computer;
end;

procedure Tconfig.FormCreate(Sender: TObject);
begin
  if GetSystemMetrics(SM_NETWORK) and $01 = $01 then
    StatusBar1.Panels[1].Text := 'Computer is attached to a network!'
  else
    StatusBar1.Panels[1].Text := 'Computer is not attached to a network!';
end;

end.
