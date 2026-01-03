unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, StdCtrls, ComCtrls, Menus, registry, ScktComp, systray, Unit2,
  ExtCtrls, XPMan, WinInet, WinSock, ImgList, RichEdit;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Connection1: TMenuItem;
    Dconnection1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    Options1: TMenuItem;
    Configuration1: TMenuItem;
    StatusBar1: TStatusBar;
    ClientSocket1: TClientSocket;
    ServerSocket1: TServerSocket;
    PopupMenu1: TPopupMenu;
    OuvrirPompomChat1: TMenuItem;
    N2: TMenuItem;
    Quitter2: TMenuItem;
    RichEdit1: TRichEdit;
    N3: TMenuItem;
    Connection2: TMenuItem;
    Dconnection2: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    text1: TMemo;
    Button1: TButton;
    C1: TMenuItem;
    C2: TMenuItem;
    F1: TMenuItem;
    FontDialog1: TFontDialog;
    N4: TMenuItem;
    R1: TMenuItem;
    N5: TMenuItem;
    S1: TMenuItem;
    S2: TMenuItem;
    SaveDialog1: TSaveDialog;
    T1: TMenuItem;
    H1: TMenuItem;
    ImageList1: TImageList;
    R2: TMenuItem;
    N6: TMenuItem;
    C3: TMenuItem;
    S3: TMenuItem;
    Received1: TMenuItem;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Receivetone1: TMenuItem;
    N7: TMenuItem;
    T2: TMenuItem;
    H2: TMenuItem;
    H3: TMenuItem;
    C4: TMenuItem;
    ColorDialog3: TColorDialog;
    E1: TMenuItem;
    N8: TMenuItem;
    procedure Configuration1Click(Sender: TObject);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Connection1Click(Sender: TObject);
    procedure Dconnection1Click(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OuvrirPompomChat1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Quitter2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure text1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure C2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure T1Click(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure R2Click(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure Received1Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure H3Click(Sender: TObject);
    procedure C4Click(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private-Deklarationen }
    FColorKey: TCOLOR;
    //UserName : string;
  public
     { Public-Deklarationen }
    Showhighlight:boolean;
    highlightcolor:TColor;
    HighLightList:TStringlist;
    OldRichEditWndProc: {integer}pointer;
    PRichEditWndProc:pointer;
    function HighLight:boolean;
    procedure Setcolor(newcolor:TColor);
  end;

function GetIp(const HostName: string): string;

var
  Form1: TForm1;
  user: ShortString;
  adrIP: ShortString;
  winboot : boolean;
  start : boolean ;
  quit : boolean ;

const
  MODEM = 1;
  LAN = 2;
  PROXY = 4;
  BUSY = 8;

const
  NAMEAPPLI = 'Network Chat';

implementation

uses Unit3;

{$R *.DFM}
function TForm1.HighLight:boolean;
var
   UText, WordName : string;
   FoundAt, WordLength : integer;
   I, Line : integer;
   hdc:integer;
   result1 : integer;
   CharPosion:integer;
   FirstVisibleLine, LastVisibleLine : integer;
   FirstCharPosofLine : integer;
   h : hwnd;
   visrect : Trect;
   vispoint : TPoint;
   current : cardinal;
   index : integer;
begin
  If not showhighlight then exit;
  h:=Richedit1.Handle; hdc := getdc(h);
  result:= SendMessage (h, EM_GETRECT, 0, integer(@visrect))=0;
  if result then
  begin
    VisPoint.x       := VisRect.right;
    VisPoint.y       := VisRect.bottom;
    CharPosion       := SendMessage (h, EM_CHARFROMPOS, 0, integer(@VisPoint));
    LASTVISIBLELINE  := SendMessage (h, EM_LINEFROMCHAR, CharPosion, 0);
    FIRSTVISIBLELINE := SendMessage (h, EM_GETFIRSTVISIBLELINE, 0, 0);
    SetBkMode (hDC, TRANSPARENT);
    SelectObject(hdc, richedit1.font.Handle);
    For Line := FIRSTVISIBLELINE to LASTVISIBLELINE  do
    begin
      UText := ' ' + RichEdit1.Lines[Line];
      FirstCharPosofLine := SendMessage (RichEdit1.Handle, EM_LINEINDEX, Line, 0);
      i := 0;

      while i <= LENgth(UText) do  begin
        FoundAt := i -1;
        while utext[i] in ['#','$','A'..'Z','a'..'z','0'..'9'] do inc(i);

        WordLength        := i- FoundAt -1;
        WordName          := copy(UText, i-WordLength, WordLength);
        If HighLightList.find(uppercase(WordName),index) Then
        //if uppercase(wordname)='PLAY' then
        begin
          SendMessage (RichEdit1.Handle, EM_POSFROMCHAR, integer(@VisPoint), FirstCharPosofLine + FoundAt-1);
          SetTextColor(hdc, highlightcolor);
          TextOut(hdc,  VisPoint.x,  VisPoint.y,  pchar(WordName), WordLength);
        End;
        (*
        //=====>> DO PURPLE FOR OPERATORS
        If pos(utext[i],'=+-*/()[]:^<>,:') > 0 Then
        begin
           FoundAt := i;
           WordName    := copy(UText, FoundAt, 1);
           SendMessage (RichEdit1.Handle, EM_POSFROMCHAR, integer(@VisPoint), FirstCharPosofLine + FoundAt-2);
           SetTextColor(hdc, clPurple);
           TextOut(hdc,  VisPoint.x,  VisPoint.y,  @WordName, Length(WordName));
        End;
        *)
        inc(i);
      end;
    end;
  end;
  ReleaseDC(RichEdit1.Handle, hDC);

end;

function RichEditWndProc (handla:HWnd;uMsg,wParam,lParam:longint): longint stdcall;
begin
      Result := CallWindowProc(form1.OldRichEditWndProc, handla, uMsg, wParam, lParam);
      if uMsg=WM_PAINT then form1.HighLight;
end;

procedure TForm1.Setcolor(newcolor:TColor);
begin
    highlightcolor:=newcolor;
    //colorbtn.font.color:=newcolor;
end;

function GetConnectionKind(var strKind: string): Boolean;
var
  flags: DWORD;
begin
  strKind := '';
  Result := InternetGetConnectedState(@flags, 0);
  if Result then
  begin
    if (flags and MODEM) = MODEM then strKind := 'Modem';
    if (flags and LAN) = LAN then strKind := 'LAN';
    if (flags and PROXY) = PROXY then strKind := 'Proxy';
    if (flags and BUSY) = BUSY then strKind := 'Modem Busy';
  end;
end;

function NetServerGetInfo (serverName : PWideChar; level : Integer;
        var bufptr : Pointer) : Cardinal; stdcall; external 'NETAPI32.DLL';
function NetApiBufferFree (buffer : Pointer) : Cardinal;
          stdcall; external 'NETAPI32.DLL';

type
  SERVER_INFO_503 = record
    sv503_sessopens : Integer;
    sv503_sessvcs : Integer;
    sv503_opensearch : Integer;
    sv503_sizreqbuf : Integer;
    sv503_initworkitems : Integer;
    sv503_maxworkitems : Integer;
    sv503_rawworkitems : Integer;
    sv503_irpstacksize : Integer;
    sv503_maxrawbuflen : Integer;
    sv503_sessusers : Integer;
    sv503_sessconns : Integer;
    sv503_maxpagedmemoryusage : Integer;
    sv503_maxnonpagedmemoryusage : Integer;
    sv503_enablesoftcompat :BOOL;
    sv503_enableforcedlogoff :BOOL;
    sv503_timesource :BOOL;
    sv503_acceptdownlevelapis :BOOL;
    sv503_lmannounce :BOOL;
    sv503_domain : PWideChar;
    sv503_maxcopyreadlen : Integer;
    sv503_maxcopywritelen : Integer;
    sv503_minkeepsearch : Integer;
    sv503_maxkeepsearch : Integer;
    sv503_minkeepcomplsearch : Integer;
    sv503_maxkeepcomplsearch : Integer;
    sv503_threadcountadd : Integer;
    sv503_numblockthreads : Integer;
    sv503_scavtimeout : Integer;
    sv503_minrcvqueue : Integer;
    sv503_minfreeworkitems : Integer;
    sv503_xactmemsize : Integer;
    sv503_threadpriority : Integer;
    sv503_maxmpxct : Integer;
    sv503_oplockbreakwait : Integer;
    sv503_oplockbreakresponsewait : Integer;
    sv503_enableoplocks : BOOL;
    sv503_enableoplockforceclose : BOOL;
    sv503_enablefcbopens : BOOL;
    sv503_enableraw : BOOL;
    sv503_enablesharednetdrives : BOOL;
    sv503_minfreeconnections : Integer;
    sv503_maxfreeconnections : Integer;
  end;
  PSERVER_INFO_503 = ^SERVER_INFO_503;


function Get_Computer_Name: string;
var
  dwlen: DWORD;
begin
  dwlen := MAX_COMPUTERNAME_LENGTH + 1;
  Setlength(Result, dwlen);
  GetComputerName(pchar(Result), dwlen);
  Result := StrPas(pchar(Result));
end;

function GetDomainName : string;
var
  err : Integer;
  buf : pointer;
  fDomainName: string;
  wServerName : WideString;
begin
  wServerName := Get_Computer_Name;
  err := NetServerGetInfo (PWideChar (wServerName), 503, buf);
  if err = 0 then
  try
    fDomainName := PSERVER_INFO_503 (buf)^.sv503_domain;
  finally
    NetAPIBufferFree (buf)
  end;
  result := fDomainName;
end;

function GetUsername: String;
var
  Buffer: array[0..255] of Char;
  Size: DWord;
begin
  Size := SizeOf(Buffer);
  if not Windows.GetUserName(Buffer, Size) then
    RaiseLastOSError; //RaiseLastWin32Error; 
  SetString(Result, Buffer, Size - 1);
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
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;
end;

function MakeWindowTransparent(Wnd: HWND; nAlpha: Integer = 10): Boolean;
type
  TSetLayeredWindowAttributes = function(hwnd: HWND; crKey: COLORREF; bAlpha: Byte;
    dwFlags: Longint): Longint;
  stdcall;
const
  LWA_COLORKEY = 1;
  LWA_ALPHA     = 2;
  WS_EX_LAYERED = $80000;
var
  hUser32: HMODULE;
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
  i: Integer;
begin
  Result := False;
  hUser32 := GetModuleHandle('USER32.DLL');
  if hUser32 <> 0 then
  begin @SetLayeredWindowAttributes := GetProcAddress(hUser32,
                                       'SetLayeredWindowAttributes');
    if @SetLayeredWindowAttributes <> nil then
    begin
      SetWindowLong(Wnd, GWL_EXSTYLE, GetWindowLong(Wnd, GWL_EXSTYLE) or WS_EX_LAYERED);
      SetLayeredWindowAttributes(Wnd, 0, Trunc((255 / 100) * (100 - nAlpha)), LWA_ALPHA);
      Result := True;
    end;
  end;
end;

function SetLayeredWindowAttributes(
  Wnd: hwnd;
  crKey: ColorRef;
  Alpha: Byte;
  dwFlags: DWORD): Boolean;
  stdcall; external 'user32.dll';

procedure TForm1.Configuration1Click(Sender: TObject);
begin
     config.Edit2.text := user;
     config.Edit3.text := adrIP;
     config.checkwinboot.Checked  := winboot;

     if ( config.showmodal() = mrOk ) then
     begin
          user := config.Edit2.text ;
          adrIP := config.Edit3.text ;
          winboot := config.checkwinboot.Checked ;
     end;
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
    ErrorCode := 0 ;
    ServerSocket1.Port := 12345 ;
    ServerSocket1.Open() ;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    if (socket.RemoteAddress = socket.LocalAddress) then
    begin
        socket.Close();
    end else begin
        Button1.Enabled := true ;
        text1.enabled := true ;
        dconnection1.Enabled := true ;
        connection1.Enabled := false ;
        dconnection2.Enabled := true ;
        connection2.Enabled := false ;
        //Form1.Caption := NAMEAPPLI + ' - Connect';
        ModifIconTray(NAMEAPPLI+' - Connect', application.Icon.Handle);
        StatusBar1.Panels[2].Text := ' Connect';
        //StatusBar1.Panels[3].Text := config.Edit3.Text;
        StatusBar1.Repaint;
        StatusBar1.Update;
    end;
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    if (serverSocket1.Socket.ActiveConnections <= 1) and not(clientsocket1.Active) then
    begin
        Button1.Enabled := false ;
        text1.enabled := false ;
        dconnection1.Enabled := false ;
        connection1.Enabled := true ;
        dconnection2.Enabled := false ;
        connection2.Enabled := true ;
        ModifIconTray(NAMEAPPLI+' - No Connect', application.Icon.Handle);
        form1.Caption := NAMEAPPLI+' - No Connect';
        StatusBar1.Panels[2].Text := ' No Connect';
        StatusBar1.Repaint;
        StatusBar1.Update;
    end;

end;

procedure TForm1.Connection1Click(Sender: TObject);
begin
  try
    clientsocket1.Port := config.port;
    clientsocket1.Address := adrIP;
    clientsocket1.Open();
    StatusBar1.Panels[2].Text := 'Connect';
    StatusBar1.Panels[3].Text := adrIP;
    StatusBar1.Panels[1].Text := user;
  except
    on E: Exception do
    begin
      Beep;
      ShowMessage('Socket Error or User Offline : ' +  E.Message);
    end;
  end;
end;

procedure TForm1.Dconnection1Click(Sender: TObject);
var
   i : integer ;
begin
    clientsocket1.Close() ;
    clientsocket1.Active := false ;
    for  i := 0 to serversocket1.Socket.ActiveConnections-1 do
    begin
        serversocket1.Socket.Connections[i].Close();
    end;
    StatusBar1.Panels[2].Text := 'No Connect';
    ServerSocket1.close() ;
    serversocket1.Open() ;
end;

// Recieved Message
procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
   letext : string ;
   i : integer ;
begin
  if Receivetone1.Checked = true then Beep;
    letext :=  socket.ReceiveText;
    RichEdit1.SelAttributes.color := Shape2.Brush.Color;

    if T2.Checked = true then
    begin
      RichEdit1.Lines.Add('['+ TimeToStr(Time) + '] | '+   letext ) ;
    end else begin
      RichEdit1.Lines.Add(letext) ;
    end;

    if (serverSocket1.Socket.ActiveConnections > 0) then
    begin
        for i := 0 to serverSocket1.Socket.ActiveConnections-1 do
        begin
            if socket.RemoteAddress <> serverSocket1.Socket.Connections[i].RemoteAddress then
                serverSocket1.Socket.Connections[i].sendtext( letext );
        end;
    end;
    if (clientsocket1.Active) and (clientSocket1.address <> socket.RemoteAddress) then
        clientSocket1.Socket.sendtext( letext );
     form1.Show ;
     beep;
end;

// Send Message
procedure TForm1.Button1Click(Sender: TObject);
var
   i : integer;
begin
    if trim(text1.Lines.Strings[0]) <> '' then
    begin
        if (serverSocket1.Socket.ActiveConnections > 0) then
        begin
            for i := 0 to serverSocket1.Socket.ActiveConnections-1 do
            begin
                serverSocket1.Socket.Connections[i].sendtext(user +' > '+text1.Lines.Strings[0]);
            end;
        end;
        if (clientsocket1.Active) then
            clientSocket1.Socket.sendtext(user +' > '+text1.Lines.Strings[0]);

        // Send Message Color
        RichEdit1.SelAttributes.color := Shape1.Brush.Color;
        // Send Message Text
        RichEdit1.Lines.Add(user +' -> '+text1.Lines.Strings[0] );
        text1.Clear ;
        text1.SetFocus() ;
    end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   Pos:TPoint;
begin
     GetCursorPos(Pos);
     case X of
         WM_LBUTTONDBLCLK:form1.show ;
         WM_LBUTTONDOWN:;
         WM_LBUTTONUP:;
         WM_RBUTTONDBLCLK:;
         WM_RBUTTONDOWN:;
         WM_RBUTTONUP:PopupMenu1.Popup(Pos.X,Pos.Y);
     end;
end;

procedure TForm1.OuvrirPompomChat1Click(Sender: TObject);
begin
     form1.show ;
end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
  quit := true;
  form1.Close;
end;

procedure TForm1.Quitter2Click(Sender: TObject);
begin
  quit := true ;
  Form1.close ;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   i : integer ;
begin
     if (quit) or (visible=false) then
     begin
         RemoveIconTray();
         clientsocket1.Close() ;
         if (serverSocket1.Socket.ActiveConnections > 0) then
             for  i := 0 to serversocket1.Socket.ActiveConnections-1 do
                 serversocket1.Socket.Connections[i].Close() ;
         serversocket1.Close() ;
     end else begin
         CanClose := false;
         form1.hide;
         ShowWindow(Application.Handle, SW_HIDE);
     end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
    if start then
    begin
        if (paramcount > 0) and (Paramstr(1) = 'r') then
        begin
            form1.hide;
            ShowWindow(Application.Handle, SW_HIDE);
            start := false ;
        end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
   reg : TRegistry;
   strKind: string;
   SIcon: TIcon;
begin
  SIcon := TIcon.Create;
  try
   ImageList1.GetIcon(0, SIcon);
   //SendMessage(StatusBar1.Handle, SB_SETICON, 0, SIcon.Handle);
  finally
   SIcon.Free;
  end;

     start := true ;
     quit := false ;
     reg := TRegistry.Create;
     try
          if reg.KeyExists('Software\'+NAMEAPPLI) then
          begin
              if reg.OpenKey('Software\'+NAMEAPPLI, FALSE) then
              begin
                  user := reg.ReadString('User');
                  adrIP := reg.ReadString('ip');
              end
          end else begin
              user := 'User';
              adrIP := '192.168.0.1';
              winboot := false ;
          end;
          reg.RootKey := HKEY_LOCAL_MACHINE;
          if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', False) then
          begin
              if Reg.ValueExists( NAMEAPPLI ) then
                 winboot := true ;
          end;
     finally
         reg.Free;
     end;

     if GetConnectionKind(strKind) then
     begin
      StatusBar1.Panels[9].Text := (strKind);
     end else begin
      StatusBar1.Panels[9].Text := 'no connection';
     end;


  clientsocket1.Port := 12345 ;
  clientsocket1.Address := adrIP ;
  clientsocket1.Open();
  serversocket1.Open() ;
  IconTray(Form1.handle, Application.Icon.Handle,NAMEAPPLI+' - Disconnect');
  StatusBar1.Panels[5].Text := GetIp(GetUsername);
  StatusBar1.Panels[7].Text := GetDomainName;
  StatusBar1.Update;
  StatusBar1.Repaint;


  ShowHighLight:=false;
  HighLightlist:=tStringlist.create;
  setcolor(clblue);
  PRichEditWndProc:=@RichEditWndProc;
  Richedit1.perform(EM_EXLIMITTEXT, 0, 65535*32);
  OldRichEditWndProc := pointer(SetWindowLong(Richedit1.handle,
                                GWL_WNDPROC,
                                longint(@RichEditWndProc)));

end;

procedure TForm1.FormDestroy(Sender: TObject);
var
   reg : TRegistry;
begin
     reg := TRegistry.Create;
     try
              if reg.OpenKey('Software\'+NAMEAPPLI, TRUE) then
              begin
                  reg.WriteString('User', user);
                  reg.WriteString('ip', adrIP);
              end;

          reg.RootKey := HKEY_LOCAL_MACHINE;
          if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', true)then
          begin
              if winboot = true then
              begin
                  reg.WriteString( NAMEAPPLI, application.ExeName+' r' );
              end else begin
                  reg.DeleteValue( NAMEAPPLI );
              end;
          end;

     finally
         reg.Free;
     end
end;

procedure TForm1.text1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key = VK_RETURN then
    begin
        Button1click(sender);
    end;
end;

procedure TForm1.C2Click(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TForm1.F1Click(Sender: TObject);
begin
  if FontDialog1.Execute then RichEdit1.Font := FontDialog1.Font;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
  clientsocket1.Port := config.port;
  clientsocket1.Address := adrIP ;
  clientsocket1.Open();
end;

procedure TForm1.S1Click(Sender: TObject);
begin
  if S1.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.S2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    RichEdit1.PlainText := True ;
    RichEdit1.Lines.SaveToFile(SaveDialog1.FileName + '.txt');
  end;
end;

procedure TForm1.T1Click(Sender: TObject);
begin
  if T1.Checked = true then
  begin
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
                    WS_EX_LAYERED);
    SetLayeredWindowAttributes(Handle, ColorToRGB(FColorKey), 210, LWA_ALPHA);
  end else begin
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
                    WS_EX_LAYERED);
    SetLayeredWindowAttributes(Handle, ColorToRGB(FColorKey), 255, LWA_ALPHA);
  end;
end;

procedure TForm1.H1Click(Sender: TObject);
begin
  if H1.Checked = true then
  begin
    ShowWindow( Application.Handle, SW_HIDE );
  end else begin
    ShowWindow( Application.Handle, SW_SHOW );
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := GetUsername;
  StatusBar1.Update;
  StatusBar1.Repaint;
  config.Show;
  config.Close;
  Form1.Show;
  StatusBar1.Panels[3].Text := adrIP;
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  case Panel.Index of
    0: begin
         ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 0);
         StatusBar.Canvas.TextOut(Rect.Left + ImageList1.Width  , Rect.Top, Panel.Text);
       end;

    2: begin
         ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 1);
         StatusBar.Canvas.TextOut(Rect.Left + ImageList1.Width  , Rect.Top, Panel.Text);
       end;

    3: begin
         //ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 1);
         StatusBar.Canvas.TextOut(Rect.Left-15 + ImageList1.Width  , Rect.Top, Panel.Text);
       end;


    4: begin
       ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 2);
       StatusBar.Canvas.TextOut(Rect.Left + ImageList1.Width  , Rect.Top, Panel.Text);
       end;

    6: begin
       ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 3);
       StatusBar.Canvas.TextOut(Rect.Left + ImageList1.Width  , Rect.Top, Panel.Text);
       end;

    8: begin
       ImageList1.Draw(StatusBar.Canvas, Rect.Left, Rect.Top-1, 4);
       StatusBar.Canvas.TextOut(Rect.Left + ImageList1.Width  , Rect.Top, Panel.Text);
       end;

  end;
end;

procedure TForm1.R2Click(Sender: TObject);
begin
  clientsocket1.Port := config.port;
  clientsocket1.Address := adrIP ;
  clientsocket1.Open();
end;

procedure TForm1.S3Click(Sender: TObject);
begin
  if ColorDialog2.Execute then
    Shape1.Brush.Color := ColorDialog2.Color;
end;

procedure TForm1.Received1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
    Shape2.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  S3.Click;
end;

procedure TForm1.H3Click(Sender: TObject);
var
  i : integer;
  list : TStringList;
begin
  try
  list := TStringList.Create;
  list.LoadFromFile(ExtractFilePath(Application.ExeName) +
                    'Data\Highlight\list.ini');

    if not Showhighlight then
    begin
      Showhighlight:=true;
      highlightlist.assign(list);
      with highlightlist do
      for i:=0 to count-1 do
      strings[i]:=trim(strings[i]);
      highlightlist.sort;
      //ToggleBtn.font.Color:=highlightcolor;
    end
    else
    begin
      showhighlight:=false;
      //togglebtn.Font.Color:=clblack;
    end;
    //togglebtn.invalidate;
    RichEdit1.invalidate;
  finally
    list.Free;
  end;
end;

procedure TForm1.C4Click(Sender: TObject);
begin
  with ColorDialog3 do
  if execute then setcolor(color);
  showhighlight := false;
end;

procedure TForm1.E1Click(Sender: TObject);
begin
  try
    form3 := TForm3.Create(nil);
    form3.ShowModal;
  finally
  end;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Received1.Click;
end;

end.
