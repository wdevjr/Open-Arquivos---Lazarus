unit UnPrinc;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGrids, DB,
  DBCtrls,ZDataset,
  ImgList, ToolWin,
  Menus, DateUtils;

type

  { TFrPrincipal }

  TFrPrincipal = class(TForm)
    BitBtn1: TBitBtn;
    DtscLog: TDataSource;
    Label13: TLabel;
    ProgressBar1: TProgressBar;
    relatorio: TBitBtn;
    BitBtn2: TBitBtn;
    cancelar: TBitBtn;
    carregar: TSpeedButton;
    cbconsulta: TSpeedButton;
    CheckBox1: TCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    Edit1: TEdit;
    excluir: TBitBtn;
    editar: TBitBtn;
    gravar: TBitBtn;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    ImageList1: TImageList;
    inserir: TBitBtn;
    Dtsrc: TDataSource;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Autor: TLabel;
    codigo13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListView1: TListView;
    lookUser: TSpeedButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelAutor: TPanel;
    SaveDialog1: TSaveDialog;
    cbtconsulta: TSpeedButton;
    autores: TSpeedButton;
    log: TSpeedButton;
    btntrazer: TSpeedButton;
    btnvisualizar: TSpeedButton;
    btnextrair: TSpeedButton;
    sair: TSpeedButton;
    ExcluirTemp: TSpeedButton;
    Timer1: TTimer;
    usuarios: TSpeedButton;
    relatorios: TSpeedButton;
    BtnLoc01: TSpeedButton;
    Assuntos: TSpeedButton;
    BtnLoc02: TSpeedButton;
    excluiAssunto: TSpeedButton;
    excluiAutor: TSpeedButton;
    StatusBar1: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BtnLoc01Click(Sender: TObject);
    procedure BtnLoc02Click(Sender: TObject);
    procedure btnvisualizarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure cbconsultaClick(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure DtsrcStateChange(Sender: TObject);
    procedure editarClick(Sender: TObject);
    procedure excluiAssuntoClick(Sender: TObject);
    procedure excluiAutorClick(Sender: TObject);
    procedure excluirClick(Sender: TObject);
    procedure ExcluirTempClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure gravarClick(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure inserirClick(Sender: TObject);
    procedure carregarClick(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btntrazerClick(Sender: TObject);
    procedure btnextrairClick(Sender: TObject);
    procedure lookUserClick(Sender: TObject);
    procedure sairClick(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure Timer1Timer(Sender: TObject);
  private
    buffer: array [0 .. 255] of Char;
    Temp, tempNome: String;
    procedure ConfigInserir;
    procedure ConfigGravar;
    procedure ConfigExcluir;
    procedure ConfigCancelar;
    procedure ConfigInicial;
    function Verifica_Campos_Em_Branco: Boolean;
    Function numLogados: Integer;
    procedure IniciaAdministracao;
    procedure InicializarComponentes;

  public
    CodigoAssuntoTemp,CodigoAutorTemp : Integer;
    Label15Temp,Label16Temp : String;
    ext, nomeUser: string;
    numCodigoII: Integer;
    codigo, codigoII, UserTemp, RegistroTemp, RegistroMoment: Integer;
    condNivelForm: Integer;
    figTipo, codigoArqu, codigoArquSolteiro: Integer;
    procedure MostrarEstatistica;
    procedure MostrarIcon;

  end;

var
  FrPrincipal: TFrPrincipal;
    respArquivos, respUsuarios, respAssuntos, respAutores, respLog, spAutores,
    respLogar : Integer;
    respQtd : Integer = 0;
    respLogados : Integer = 0;
    NumLogados : Integer = 0;


implementation

{$R *.lfm}

uses UnDM,unDlgPesquisaArquivo,UnLogin, UnDlgDialogAssunto,
 UnDlgpesquisautores,UnProcessindefinido,UnatribuiUsuariosPorArquivos,UnConsultaEspecial;

{ TFrPrincipal }

function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  //Lista de Caracteres Extras
  xCarExt: array[1..48] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := aTexto;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   //De acordo com o parâmetro aLimExt, elimina caracteres extras.
   if (aLimExt) then
     for i:=1 to 48 do
       xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
   Result := xTexto;
end;

Function RemoveCaracteresEspeciais(s: String) : String;
var i, pos: Integer;
const undesiredchars : String = '/ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÜÚÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùüúþÿ';
const replaces : String = 'AAAAAAACEEEEIIIIDNOOOOOxOUUUbBaaaaaaaceeeeiiiionooooo ouuuby';
Begin
  SetLength(Result, Length(s));
  for i := 1 to Length(s) do
    begin
      pos := ord(s[i]);
      if (s[i] in [#32, #48..#57, #65..#90, #97..#122]) then
        Result[i] := s[i]
      else
        begin
          pos := AnsiPos(s[i], undesiredchars);
          Result[i] := replaces[pos + 1];
        end;
    end;

end;

function TFrPrincipal.Verifica_Campos_Em_Branco: Boolean;
var cont : integer;
begin
Result:=True; //assume que estão todos preenchidos
  for cont:= 0 to DtSrc.DataSet.FieldCount - 1 do
    if DtSrc.DataSet.Fields[cont].Required then
      if (DtSrc.DataSet.Fields[cont].IsNull) or
         (DtSrc.DataSet.Fields[cont].AsString='') then
      begin
        MessageDlg('Preencha o campo "'+DtSrc.DataSet.Fields[cont].DisplayLabel+'"',
                   mtWarning,[mbOk],0,mbOk);
        Result:=False;
        Break;
      end;

end;

Function TFrPrincipal.numLogados: Integer;
var
  numCount: Integer;
  respNumLogados: string;
begin
  //Result := 0;
  //respQtd := 0;
  try
    DM.sds_Cont_Logar.Close;
    //DM.sds_Cont_Logar.Params.Clear;
   // DM.sds_Cont_Logar.SQL.Clear;
    //DM.sds_Cont_Logar.SQL.Add('select * from NUM_LOGADOS');
    //DM.sds_Cont_Logar.SQL.Add('select ORDEM as NUM from NUM_LOGADOS where ORDEM = (select max(ORDEM) from NUM_LOGADOS)');
    DM.sds_Cont_Logar.Open;
    DM.sds_Cont_Logar.Refresh;
    //DM.ZUpdateSQL5.RefreshSQL;
    //DM.sds_Cont_Logar.Next;
   // respQtd := DM.sds_Cont_Logar.FieldByName('NUM').AsInteger;
   respQtd:= DM.sds_Cont_Logar.RecordCount;
  except
    on E: Exception do
    begin
      MessageDlg('Algum Erro ou ao tentando montar a instrução SQL[LOGADOS]!' +
        #13 + 'Mensagem Original: ' + E.Message, mtError, [mbOK], 0);
      Abort;
    end;
  end;
  Result := respQtd;
end;

procedure TFrPrincipal.MostrarIcon;
begin
  Edit1.Text := DBText4.Caption;
  if (DM.ZQArquivoEXTENCAO.AsString = '.pdf  ') or (Edit1.Text = '.pdf') then
  begin
    // Image2.Picture.LoadFromFile('C:/OpenArquivos/Icon/pdfarqu.bmp');
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/pdfarqu.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.ps   ') or (Edit1.Text = '.ps')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/ps.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.doc  ') or (Edit1.Text = '.doc')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/doc972003.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.docx ') or (Edit1.Text = '.docx')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/word2007.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.xls  ') or (Edit1.Text = '.xls')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/excel972003.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.xlsx ') or (Edit1.Text = '.xlsx')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/xls.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.accdb') or (Edit1.Text = '.accdb')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/access.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.mdb  ') or (Edit1.Text = '.mdb')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/access972003.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.pps  ') or (Edit1.Text = '.pps')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/pps972003.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.ppt  ') or (Edit1.Text = '.ppt')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/ppt.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.ppsx ') or (Edit1.Text = '.ppsx')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/pps.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.pptx  ') or (Edit1.Text = '.ppt')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/ppt.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.mpg  ') or (Edit1.Text = '.mpg')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/avimpeg.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.avi  ') or (Edit1.Text = '.avi')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/avimpeg.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.mp3  ') or (Edit1.Text = '.mp3')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/mp3.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.wma  ') or (Edit1.Text = '.wma')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/mp3.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.wav  ') or (Edit1.Text = '.wav')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/mp3.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.ogg  ') or (Edit1.Text = '.ogg')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/mp3.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.bmp  ') or (Edit1.Text = '.bmp')
  then
  begin
   Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/bmp.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.jpg  ') or (Edit1.Text = '.jpg')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/jpg.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.png  ') or (Edit1.Text = '.png')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/png.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.gif  ') or (Edit1.Text = '.gif')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/gif.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.tiff ') or (Edit1.Text = '.tiff')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/tiff.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.html ') or (Edit1.Text = '.html')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/html.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.htm  ') or (Edit1.Text = '.htm')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/html.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.mht  ') or (Edit1.Text = '.mht')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/mht.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.exe  ') or (Edit1.Text = '.exe')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/exe.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.java ') or (Edit1.Text = '.java')
  then
  begin
   Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/java.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.txt  ') or (Edit1.Text = '.txt')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/notpad.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.rtf  ') or (Edit1.Text = '.rtf')
  then
  begin
   Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/doc972003.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.zip  ') or (Edit1.Text = '.zip')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/zip.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '.rar  ') or (Edit1.Text = '.rar')
  then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/rar.bmp');
  end
  else if (DM.ZQArquivoEXTENCAO.AsString = '      ') or (Edit1.Text = '') then
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Icon/nada.bmp');
  end
  else
  begin
    Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      'Icon/Default.bmp');
  end;

end;



procedure TFrPrincipal.ConfigInserir;
begin
  carregar.Enabled := True;
  gravar.Enabled := True;
  cancelar.Enabled := True;
  inserir.Enabled := False;
  excluir.Enabled := False;
  btntrazer.Enabled := False;
  btnvisualizar.Enabled := False;
  btnextrair.Enabled := False;
  ExcluirTemp.Enabled := False;
 // Image6.Visible := False;
end;

procedure TFrPrincipal.ConfigGravar;
begin
  inserir.Enabled := True;
  btnvisualizar.Enabled := True;
  btnextrair.Enabled := True;
  gravar.Enabled := False;
  excluir.Enabled := True;
  cancelar.Enabled := False;
end;

procedure TFrPrincipal.ConfigExcluir;
begin
  carregar.Enabled := False;
  inserir.Enabled := True;
  gravar.Enabled := False;
  excluir.Enabled := False;
  cancelar.Enabled := False;
  btnvisualizar.Enabled := False;
  btntrazer.Enabled := True;
  // DM.cds_arqu.Close;
  ExcluirTemp.Enabled := False;
  //Image6.Visible := False;
end;

procedure TFrPrincipal.ConfigInicial;
begin
  inserir.Enabled := True;
  gravar.Enabled := False;
  editar.Enabled := False;
  excluir.Enabled := False;
  cancelar.Enabled := False;
  btnvisualizar.Enabled := False;
  btnextrair.Enabled := False;
  carregar.Enabled := False;
  ExcluirTemp.Enabled := False;
 // Image6.Visible := False;
  excluiAssunto.Enabled := False;
  excluiAutor.Enabled := False;

end;

procedure TFrPrincipal.ConfigCancelar;
begin

  inserir.Enabled := True;
  gravar.Enabled := False;
  excluir.Enabled := False;
  cancelar.Enabled := False;
  btnvisualizar.Enabled:=false;
  btnextrair.Enabled:=false;
  // DM.cds_arquivo.Close;
  ExcluirTemp.Enabled := False;
  excluiAssunto.Enabled := False;
  excluiAutor.Enabled := False;
end;




procedure TFrPrincipal.MostrarEstatistica;
begin
  //codigo13.Caption:='0';
  ListView1.Clear;
  DM.sds_cont.Close;
  DM.sds_cont.SQL.Clear;
  DM.sds_cont.SQL.Add('select COUNT(*)contArqu from ARQUIVOLIST');
  DM.sds_cont.Open;
  respArquivos := DM.sds_cont.FieldByName('contArqu').AsInteger;
  DM.sds_cont.Close;
  DM.sds_cont.SQL.Clear;
  DM.sds_cont.SQL.Add('select COUNT(*)contUser from USUARIO');
  DM.sds_cont.Open;
  respUsuarios := DM.sds_cont.FieldByName('contUser').AsInteger;
  DM.sds_cont.Close;
  DM.sds_cont.SQL.Clear;
  DM.sds_cont.SQL.Add('select COUNT(*)contAssunt from ASSUNTO');
  DM.sds_cont.Open;
  respAssuntos := DM.sds_cont.FieldByName('contAssunt').AsInteger;
  DM.sds_cont.Close;
  DM.sds_cont.SQL.Clear;
  DM.sds_cont.SQL.Add('select COUNT(*)contLog from LOG');
  DM.sds_cont.Open;
  respLog := DM.sds_cont.FieldByName('contLog').AsInteger;
  DM.sds_cont.Close;
  DM.sds_cont.SQL.Clear;
  DM.sds_cont.SQL.Add('select COUNT(*)contAut from AUTORES');
  DM.sds_cont.Open;
  respAutores := DM.sds_cont.FieldByName('contAut').AsInteger;
  respLogados := numLogados;
  ListView1.Items.Add.Caption := 'Arquivos:                      ' +
    IntToStr(respArquivos);
  ListView1.Items.Add.Caption := 'Usuários:                      ' +
    IntToStr(respUsuarios);
  ListView1.Items.Add.Caption := 'Assuntos:                     ' +
    IntToStr(respAssuntos);
  ListView1.Items.Add.Caption := 'Autores :                      ' +
    IntToStr(respAutores);
  ListView1.Items.Add.Caption := 'Logs    :                        ' +
    IntToStr(respLog);
  codigo13.Caption := IntToStr(numLogados);
  codigo13.Visible := True;
  // ListView1.Items.Add.Caption := 'Logados :                     ' +IntToStr(respLogados);
end;


procedure TFrPrincipal.cancelarClick(Sender: TObject);
begin
   Dtsrc.DataSet.Cancel;
  if Dtsrc.DataSet.State = dsBrowse then
    begin
     if  Label15Temp  <> '' then
      begin
       Label15.Caption := Label15Temp;
       DBEdit1.Text:= IntToStr(CodigoAssuntoTemp);
       end;
     if  Label16Temp <> '' then
      begin
      Label16.Caption := Label16Temp;
      DBEdit2.Text:= IntToStr(CodigoAutorTemp);
      end;

    end;

    with Dtsrc.DataSet do
  begin
    excluir.Enabled := not IsEmpty;
    btnextrair.Enabled := not IsEmpty;
    btnvisualizar.Enabled := not IsEmpty;
    BtnLoc01.Enabled := not IsEmpty;
    BtnLoc02.Enabled := not IsEmpty;
    excluiAssunto.Enabled := not IsEmpty;
    excluiAutor.Enabled := not IsEmpty;
    lookUser.Enabled := not IsEmpty;
    relatorios.Enabled := not IsEmpty;
    //btntrazer.Enabled:= not IsEmpty;

    // exclusão de campos recebendo 0
  end;
   // ConfigCancelar;
end;

procedure TFrPrincipal.cbconsultaClick(Sender: TObject);
begin
  FrmConsultaEspecial:=TFrmConsultaEspecial.Create(self);
  try
   FrmConsultaEspecial.ShowModal;
  finally
     FrmConsultaEspecial.Free;
  end;
end;

procedure TFrPrincipal.Button1Click(Sender: TObject);
begin
   MostrarEstatistica;
   //Timer1.Enabled:= true;
end;

procedure TFrPrincipal.btnvisualizarClick(Sender: TObject);
var
  x, y: PChar;
  Flag: LONG;
begin
  if DM.ZQArquivo.IsEmpty then
  begin
    MessageDlg('Não ha Arquivo no cadastro, consulte ou localize primeiro !',
      mtWarning, [mbOK], 0);
  end
  else
  begin
    DM.ZQArquivoDADOS.SaveToFile
      (Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true));
    x := nil;
    y := nil;
    Flag := ShellExecute(Application.Handle, 'OPEN',
      PChar(Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true)), x, y, SW_SHOW);
    if Flag <= 32 then
    begin
      ShowMessage('Erro ao Abrir ' + Temp + '\' +
        TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true));
    end;
    if FileExists(Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true)) then
    begin
      ExcluirTemp.Enabled := True;
      Image3.Visible := True;
    end
    else
    begin
      ExcluirTemp.Enabled := False;
      Image3.Visible := False;
      SysUtils.Abort;
    end;
  end;

end;

procedure TFrPrincipal.BtnLoc01Click(Sender: TObject);
begin
  FrmPesquisaAssunto := TFrmPesquisaAssunto.Create(self);
  try
    if FrmPesquisaAssunto.ShowModal = mrOk then
    begin
      if (Dtsrc.State = dsbrowse) or (Dtsrc.State = dsInsert) then
      DM.ZQArquivo.Edit;
      DM.ZQArquivoCOD_ASSUNTO.AsInteger := DM.sds_AssuntCODIGO.AsInteger;
      Label15.Caption:=DM.sds_AssuntTITULOASSUN.AsString;
    end;
  finally
    DM.sds_assunt.Close;
    FrmPesquisaAssunto.Free;
    end;

        //DM.ZQArquivoTITULOASSUN.AsString := DM.sds_AssuntTITULOASSUN.AsString;
end;

procedure TFrPrincipal.BitBtn1Click(Sender: TObject);
var i,cont:Integer;
begin
  ProgressBar1.Min:=1;
  DM.ZQuery1.Open;
  DM.ZQuery2.Open;
  //cont:=DM.ZQuery1.RecordCount;
  ProgressBar1.Max:=244;
        DM.ZQuery1.First;
        DM.ZQuery2.First;
  For i:=1 to 244 do
    begin
      DM.ZQuery2.Edit;
    //if  (DM.ZQuery2NOME_ARQUIVO_ESPECIAL.AsString = '') then
      DM.ZQuery2NOME_ARQUIVO_ESPECIAL.Value:=DM.ZQuery1NOME_ARQUIVO.AsString;
      DM.ZQuery2.ApplyUpdates;
      DM.ZQuery2.CommitUpdates;
      ProgressBar1.Position:=ProgressBar1.Position + 1;
      DM.ZQuery1.next;
      DM.ZQuery2.Next;
      //Sleep(700);

      //Label13.Caption := IntToStr(ProgressBar1.Position);
    end;
   Label13.Caption:='Pronto!';
   Label13.Visible:=true;
end;

procedure TFrPrincipal.BtnLoc02Click(Sender: TObject);
begin
  FrmPesquisaAutor := TFrmPesquisaAutor.Create(self);
  try
  if (FrmPesquisaAutor.ShowModal = mrOK) then
  begin
        if Dtsrc.State = dsbrowse then
        DM.ZQArquivo.Edit;
        DM.ZQArquivoCOD_AUTOR.AsInteger:=DM.sds_AutoresCODIGO.AsInteger;
        Label16.Caption:=DM.sds_AutoresNOME.AsString;
  end;
     finally
         DM.sds_Autores.Close;
         FrmPesquisaAutor.Free;

  end;
end;

procedure TFrPrincipal.Button2Click(Sender: TObject);
begin
 // Timer1.Enabled:= false;
  MostrarEstatistica;
end;

procedure TFrPrincipal.InicializarComponentes;
begin
  StatusBar1.Panels[1].Text := 'Nome: ' + FrmLogin.NOME;
  StatusBar1.Panels[2].Text := 'Login: ' + FrmLogin.LOGIN;
  nomeUser := FrmLogin.NOME;
  UserTemp := FrmLogin.COD_USUARIO;
  codigo := FrmLogin.COD_USUARIO;
  codigoII := FrmLogin.COD_USUARIO;
  condNivelForm := FrmLogin.NIVEL;
  figTipo := FrmLogin.ADMIN;
  // Height:=590;
  ConfigInicial;
  MostrarEstatistica;
  with Dtsrc.DataSet do
  begin
    btnextrair.Enabled := not IsEmpty;
    btnvisualizar.Enabled := not IsEmpty;
    BtnLoc01.Enabled := not IsEmpty;
    BtnLoc02.Enabled := not IsEmpty;
  end;
  GetTempPath(SizeOf(buffer), buffer);
  Temp := StrPas(buffer) + '\OpenArquivos';
  if not DirectoryExists(Temp) then
  begin
    if not ForceDirectories(Temp) then
    begin
      MessageDlg('Não foi possivel criar o Diretorio Temporario !', mtError,
        [mbOK], 0);
      SysUtils.Abort;
    end;
  end;

end;

procedure TFrPrincipal.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked = True then
  begin
    PanelAutor.Visible := True;
    //Height := 610;
  end
  else
  begin
    PanelAutor.Visible := False;
  //  Height := 568;
  end;
end;

procedure TFrPrincipal.DtsrcStateChange(Sender: TObject);
begin
    with Dtsrc.DataSet do
    begin

      excluir.Enabled := not IsEmpty;
      inserir.Enabled := Dtsrc.State in [dsbrowse, dsInactive];
      btnvisualizar.Enabled := Dtsrc.State in [dsbrowse];
      btnextrair.Enabled := Dtsrc.State in [dsbrowse];
      gravar.Enabled := Dtsrc.State in [dsInsert];
      editar.Enabled := Dtsrc.State in [dsEdit];
      cancelar.Enabled := Dtsrc.State in [dsInsert, dsEdit];
      excluir.Enabled := Dtsrc.State in [dsbrowse];
      btntrazer.Enabled := Dtsrc.State in [dsbrowse, dsInactive];
      carregar.Enabled := Dtsrc.State in [dsInsert, dsEdit, dsbrowse];
      BtnLoc01.Enabled := Dtsrc.State in [dsInsert, dsEdit, dsbrowse];
      BtnLoc02.Enabled := Dtsrc.State in [dsInsert, dsEdit, dsbrowse];
      excluiAssunto.Enabled := Dtsrc.State in [dsInsert,dsEdit, dsbrowse, dsInactive];
      excluiAutor.Enabled := Dtsrc.State in [dsInsert,dsEdit, dsbrowse, dsInactive];
      lookUser.Enabled := Dtsrc.State in [dsbrowse, dsEdit];
      relatorio.Enabled := Dtsrc.State in [dsbrowse, dsInactive];
      relatorios.Enabled := Dtsrc.State in [dsbrowse, dsInactive];

    end;

end;

procedure TFrPrincipal.editarClick(Sender: TObject);
begin
  if (Label15.Caption = '') then
  begin
   ShowMessage('Preencha o Assunto!');
   Abort;
   end else
  begin
  if (Verifica_Campos_Em_Branco)  then
  begin
    frmSplash := TfrmSplash.Create(Self);
    frmSplash.Show;
    frmSplash.Refresh;
    frmSplash.ProgressBar1.Position := 1;
    // espera...
    Sleep(100);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 8;
    // espera...
    Sleep(700);
    //
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 34;
    // espera...
    Sleep(300);
    Screen.Cursor := crHourGlass;
     try
      begin
        Dtsrc.DataSet.Edit;
        (Dtsrc.DataSet as TZQuery).ApplyUpdates;
        (Dtsrc.DataSet as TZQuery).CommitUpdates;
       end;
       except
         on E:Exception do
         begin
           MessageDlg('Erro ao Editar o Arquivo!',E.Message,mtError,[mbOK], 0);
           Abort;
         end;
    end;
  MostrarEstatistica;
    // DM.sds_cont.Close;
    //RegistroTemp := StrToInt(DBText2.Caption);
    Screen.Cursor := crDefault;
    ConfigGravar;
    MostrarIcon;
     // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 51;
    // espera...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 73;
    // espera...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 85;
    // espera ...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 99;
    // espera ...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 100;
    // espera...
    Sleep(500);
    if frmSplash.ProgressBar1.Position = 100 then
    begin
      frmSplash.Hide;
      frmSplash.Free;
     end;
    end else Abort;
  end;
end;

procedure TFrPrincipal.excluiAssuntoClick(Sender: TObject);
begin
   if Dtsrc.State = dsbrowse then
   begin
    DM.ZQArquivo.Edit;
   CodigoAssuntoTemp:=DM.ZQArquivoCOD_ASSUNTO.Value;
   Label15Temp:=Label15.Caption;
   DBEdit1.Text:='';
   Label15.Caption:='';
    FrPrincipal.MostrarIcon;
   end;
end;

procedure TFrPrincipal.excluiAutorClick(Sender: TObject);
begin
   if Dtsrc.State = dsbrowse then
    DM.ZQArquivo.Edit;
   CodigoAutorTemp:=DM.ZQArquivoCOD_AUTOR.AsInteger;
   Label16Temp:=Label16.Caption;
   DBEdit2.Text:='';
   //DM.ZQArquivoCOD_AUTOR.Value := 0;
   Label16.Caption:='';


end;

procedure TFrPrincipal.excluirClick(Sender: TObject);
begin
 if (MessageDlg('Deseja excluir este Arquivo e Informações?', mtConfirmation,[mbYes, mbNo], 0) = mrYes) then
  begin
   try
     begin
      Dtsrc.DataSet.Delete;
      (Dtsrc.DataSet as TZQuery).ApplyUpdates;
      (Dtsrc.DataSet as TZQuery).CommitUpdates;
     end;
    except
      on E:Exception do
      begin
       MessageDlg('Erro ao Excluir o Arquivo!',E.Message,mtError,[mbOK],0);
       Abort;
       end;
    end;

    try
       begin
        DtscLog.DataSet.Open;
        DtscLog.DataSet.Append;
        DM.cds_LogCOD_USUARIO.Value := FrmLogin.COD_USUARIO;
        DM.cds_LogINSERDATA.Value := Date;
        DM.cds_LogHORA.Value := Time;
        DM.cds_LogCOD_ACAO.Value := 2;
        DM.cds_LogACAO.Value := 'EXCLUIU';
        DM.cds_LogAPLICATIVO.Value := 'CADASTRO DE ARQUIVOS';
        DM.cds_LogCOD_REGISTRO.Value := DM.ZQArquivoID.AsInteger;
        DM.cds_LogDISCRIMINACAO.Value := tempNome;
          DtscLog.DataSet.Post;
          (DtscLog.DataSet as TZQuery).ApplyUpdates;
          (DtscLog.DataSet as TZQuery).CommitUpdates;
      end;
     Except
       on E:Exception do
       begin
         MessageDlg('Erro ao gravar Log!',e.Message,mtError,[mbOk],0);
         Abort;
       end;
    end;
   Label15.Caption:='';
   Label16.Caption:='';
  // DM.ZQArquivo.Refresh;
   ConfigExcluir;
   MostrarEstatistica;
   MostrarIcon;
  CheckBox1.Checked := False;

  with Dtsrc.DataSet do
  begin
    excluir.Enabled := not IsEmpty;
    btnvisualizar.Enabled := not IsEmpty;
    btnextrair.Enabled := not IsEmpty;
    BtnLoc01.Enabled := not IsEmpty;
    BtnLoc02.Enabled := not IsEmpty;
    excluiAssunto.Enabled := not IsEmpty;
    excluiAutor.Enabled := not IsEmpty;
  end;
  if (FrmLogin.TODOS = 0) then
  begin
    lookUser.Visible := False;
  end
  else
  begin
    lookUser.Visible := True;
  end;

  end else Abort;

end;

procedure TFrPrincipal.ExcluirTempClick(Sender: TObject);
begin
  DeleteFile(Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true));
  ExcluirTemp.Enabled := False;
end;

Function Saudacao: string;
begin
  Result := ' Boa-Noite!';
  if (Time >= 0.25) and (Time < 0.5) then
    Result := ' Bom-Dia!';
  if (Time >= 0.5) and (Time < 0.80) then
    Result := ' Boa-Tarde!';
end;


procedure TFrPrincipal.FormActivate(Sender: TObject);
begin
    StatusBar1.Panels[0].Text := Saudacao + ' Hoje é ' +
    formatdatetime('dddddd', Date);
 if (FrmLogin.TODOS = 0) then
  begin
    lookUser.Visible := False;
  end
  else
  begin
    lookUser.Visible := True;
  end;
  //MostrarEstatistica;
end;

procedure TFrPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if (MessageDlg('Deseja Sair do Sistema ?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  BEGIN
    try
      try
        DM.cds_ExcRepetidos.Close;
        DM.cds_ExcRepetidos.Params[0].AsInteger := FrmLogin.COD_USUARIO;
        DM.cds_ExcRepetidos.Open;
      finally
        DM.DtsrcExcLogados.DataSet.Delete;
        (DM.DtsrcExcLogados.DataSet as TZQuery).ApplyUpdates;
        (DM.DtsrcExcLogados.DataSet as TZQuery).CommitUpdates;

      end;
    Except
      on E: Exception do
      begin
        MessageDlg('Houve um problema no termino do aplicativo !', mtWarning,
          [mbOK], 0);
        // Application.Terminate;
      end;
    end;

    Application.Terminate;
  END;
end;

procedure TFrPrincipal.FormShow(Sender: TObject);
begin
  Label15.Caption:='';
  Label16.Caption:='';
  //Dtsrc.DataSet.Open;
  FrmLogin.Visible := False;
  InicializarComponentes;
  IniciaAdministracao;
  nomeUser := FrmLogin.NOME;
  UserTemp := FrmLogin.COD_USUARIO;
  codigo := FrmLogin.COD_USUARIO;
  codigoII := FrmLogin.COD_USUARIO;
  condNivelForm := FrmLogin.NIVEL;
  figTipo := FrmLogin.ADMIN;
  // Height:=590;
  ConfigInicial;
  MostrarEstatistica;
  with Dtsrc.DataSet do
  begin
    btnextrair.Enabled := not IsEmpty;
    btnvisualizar.Enabled := not IsEmpty;
    BtnLoc01.Enabled := not IsEmpty;
    BtnLoc02.Enabled := not IsEmpty;
  end;
  GetTempPath(SizeOf(buffer), buffer);
  Temp := StrPas(buffer) + '\OpenArquivos';
  if not DirectoryExists(Temp) then
  begin
    if not ForceDirectories(Temp) then
    begin
      MessageDlg('Não foi possivel criar o Diretorio Temporario !', mtError,
        [mbOK], 0);
      SysUtils.Abort;
    end;
  end;
end;

procedure TFrPrincipal.gravarClick(Sender: TObject);
begin
  if Verifica_Campos_Em_Branco then
begin
  frmSplash := TfrmSplash.Create(Self);
    frmSplash.Show;
    frmSplash.Refresh;
    frmSplash.ProgressBar1.Position := 1;
    // espera...
    Sleep(100);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 8;
    // espera...
    Sleep(700);
    //
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 34;
    // espera...
    Sleep(300);
    Screen.Cursor := crHourGlass;
    try
   begin
    Dtsrc.DataSet.Post;
    (Dtsrc.DataSet as TZQuery).ApplyUpdates;
     (Dtsrc.DataSet as TZQuery).CommitUpdates;
    end;
    except
      on E: Exception do
      begin
        MessageDlg('Erro no de inserimento do Arquivo!',E.Message,mtError,[mbOK],0);
       Abort;
      end;

    end;
    try
    begin
    DM.cds_UserAdd.Open;
    DM.cds_UserAdd.Append;
    DM.cds_UserAddIDUSUARIOS.Value := FrmLogin.COD_USUARIO;
    DM.cds_UserAddIDARQUIVOS.Value := DM.ZQArquivoID.AsInteger;
    DM.cds_UserAdd.Post;
    DM.cds_UserAdd.ApplyUpdates;
    DM.cds_UserAdd.CommitUpdates;
    end;

    except
      on E:Exception do
      begin
        MessageDlg('Erro no de inserimento de Proprietário de Arquivo!',E.Message,mtError,[mbOK],0);
        Abort;
      end;
   end;

    // DM.sds_cont.Close;
    //RegistroTemp := StrToInt(DBText2.Caption);
    Screen.Cursor := crDefault;
    ConfigGravar;
    MostrarEstatistica;
    MostrarIcon;
     // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 51;
    // espera...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 73;
    // espera...
    Sleep(2000);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 85;
    // espera ...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 99;
    // espera ...
    Sleep(500);
    // altera a ProgressBar
    frmSplash.ProgressBar1.Position := 100;
    // espera...
    Sleep(2000);
    if frmSplash.ProgressBar1.Position = 100 then
    begin
      frmSplash.Hide;
      frmSplash.Free;

    end;

    end else Abort;


end;

procedure TFrPrincipal.IdleTimer1Timer(Sender: TObject);
begin
    MostrarEstatistica;
end;

procedure TFrPrincipal.inserirClick(Sender: TObject);
begin
   CodigoAssuntoTemp:=DM.ZQArquivoCOD_ASSUNTO.Value;
   Label15Temp:=Label15.Caption;
   Label15.Caption:='';
   CodigoAssuntoTemp := DM.ZQArquivoCOD_ASSUNTO.Value;

   CodigoAutorTemp:=DM.ZQArquivoCOD_AUTOR.AsInteger;
   Label16Temp:=Label16.Caption;
   CodigoAutorTemp:=DM.ZQArquivoCOD_AUTOR.Value;
   Label16.Caption:='';

    if not Dtsrc.DataSet.Active then
    Dtsrc.DataSet.Open;
    Dtsrc.DataSet.Append;

 if (FrmLogin.TODOS = 0) then
  begin
    lookUser.Visible := False;
  end
  else
  begin
    lookUser.Visible := True;
  end;
end;

procedure TFrPrincipal.carregarClick(Sender: TObject);
var
  F: File of Byte;
  Tamnh, TamnhBytes, TamnhMB, TamnhKB, Temp2: Double;
  varifTempBytes, varifTempKB, varifTempMB: string;
begin
  Tamnh := 0.0;
  TamnhBytes := 0.0;
  TamnhMB := 0.0;
  TamnhKB := 0.0;
  OpenDialog1.FileName := '';
  OpenDialog1.Files.Clear;
  AssignFile(F, OpenDialog1.FileName);
  if FileExists(Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true)) then
  begin
    DeleteFile(Temp + '\' +TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true));
    ExcluirTemp.Enabled := False;
    Image3.Visible := False;
  end
  else if OpenDialog1.Execute then
  begin

    if Dtsrc.State = dsbrowse then
      DM.ZQArquivo.Edit;
    DM.ZQArquivoDADOS.LoadFromFile(OpenDialog1.FileName);
    DM.ZQArquivoNOME_ARQUIVO.AsString := TrocaCaracterEspecial(ExtractFileName(OpenDialog1.FileName),true);
    DM.ZQArquivoNOME_ARQUIVO_ESPECIAL.AsString:= ExtractFileName(OpenDialog1.FileName);
    DM.ZQArquivoEXTENCAO.AsString :=
      LowerCase(ExtractFileExt(OpenDialog1.FileName));
    AssignFile(F, OpenDialog1.FileName);
    Reset(F);
    Tamnh := FileSize(F);

    if Tamnh <= 1024 then
    begin
      varifTempBytes := (FloatToStrF((Tamnh), ffNumber, 11, 0));
      DM.ZQArquivoTAMANHO.AsString := varifTempBytes + ' Bytes';
      DM.ZQArquivoSIZE_ARQUIVO.AsFloat := StrToFloat(varifTempBytes);
    end
    else if (Tamnh > 1024) then
    begin
      varifTempBytes := (FloatToStrF((Tamnh), ffNumber, 11, 0));
      TamnhKB := (Tamnh / 1024);
      Temp2 := (Tamnh / 1024);
      TamnhMB := (Temp2 / 1024);
      if (TamnhKB <= 1024) then
      begin
        varifTempKB := (FloatToStrF((TamnhKB), ffNumber, 11, 2));
        DM.ZQArquivoTAMANHO.AsString := varifTempKB + ' (KB)-' + '(' +
          varifTempBytes + ' Bytes)';
        DM.ZQArquivoSIZE_ARQUIVO.AsFloat := TamnhKB;
      end
      else
      begin
        varifTempMB := (FloatToStrF((TamnhMB), ffNumber, 11, 1));
        varifTempKB := (FloatToStrF((TamnhKB), ffNumber, 11, 2));
        DM.ZQArquivoTAMANHO.AsString := varifTempMB + ' (MB)-' + varifTempKB +
          ' (KB)-' + '(' + varifTempBytes + ' Bytes)';
        DM.ZQArquivoSIZE_ARQUIVO.AsFloat := TamnhKB;
      end;
    end;

      MostrarIcon;
     if (Tamnh >= 125829120) then // 120MB
      begin
        Dtsrc.DataSet.Cancel;
        MessageDlg('Memória insuficiente no Banco!, Ultrapassou os 120 MB!',
          mtError, [mbOK], 0);
        MostrarIcon;
      end;
  end;

end;

procedure TFrPrincipal.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   with ListView1 do
  begin
    if (Item.Index mod 2) = 0 then
    begin
      Canvas.Brush.Color := $00CBEAEB;
      Canvas.Font.Color := clGray;
    end
    else
    begin
      Canvas.Brush.Color := $00FFF4F4;
      Canvas.Font.Color := clGray;
    end;
  end;
end;

procedure TFrPrincipal.btntrazerClick(Sender: TObject);
var
  DataInserimento: String;
begin
    FrmDlgPesquisa := TFrmDlgPesquisa.Create(Self);

      if FrmDlgPesquisa.ShowModal = mrOk then
      if (FrmLogin.TODOS = 0) then
      begin
        try
          DM.ZQArquivo.Close;
          DM.ZQArquivo.Params[0].Value := DM.sds_ArquID.AsInteger;
          DM.ZQArquivo.Open;
          MostrarIcon;
           frmSplash := TfrmSplash.Create(Self);
              frmSplash.Show;
              frmSplash.Refresh;
              frmSplash.ProgressBar1.Position := 1;
              // espera...
              Sleep(100);
              Sleep(100);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 8;
              // espera...
              Sleep(700);
              //
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 34;
              // espera...
              Sleep(300);


               // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 51;
              // espera...
              Sleep(500);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 73;
              // espera...
              Sleep(2000);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 85;
              // espera ...
              Sleep(500);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 99;
              // espera ...
              Sleep(500);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 100;
              // espera...
              Sleep(2000);
              if frmSplash.ProgressBar1.Position = 100 then
              begin
                frmSplash.Hide;
                frmSplash.Free;

              end;
              MostrarIcon;
        finally
          DM.sds_Arqu.Close;
          FrmDlgPesquisa.Free;
        end;

      end
      else if FrmLogin.TODOS = 1 then
      begin
        try
          DM.ZQArquivo.Close;
          DM.ZQArquivo.Params[0].AsInteger := DM.sds_ArquTodosID.AsInteger;
          DM.ZQArquivo.Open;

           frmSplash := TfrmSplash.Create(Self);
              frmSplash.Show;
              frmSplash.Refresh;
              frmSplash.ProgressBar1.Position := 1;
              // espera...
              Sleep(100);
              Sleep(100);
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 8;
              // espera...
              Sleep(700);
              //
              // altera a ProgressBar
              frmSplash.ProgressBar1.Position := 34;
              // espera...
              Sleep(300);


                        // altera a ProgressBar
                       frmSplash.ProgressBar1.Position := 51;
                       // espera...
                       Sleep(500);
                       // altera a ProgressBar
                       frmSplash.ProgressBar1.Position := 73;
                       // espera...
                       Sleep(2000);
                       // altera a ProgressBar
                       frmSplash.ProgressBar1.Position := 85;
                       // espera ...
                       Sleep(500);
                       // altera a ProgressBar
                       frmSplash.ProgressBar1.Position := 99;
                       // espera ...
                       Sleep(500);
                       // altera a ProgressBar
                       frmSplash.ProgressBar1.Position := 100;
                       // espera...
                       Sleep(2000);
                       if frmSplash.ProgressBar1.Position = 100 then
                       begin
                         frmSplash.Hide;
                         frmSplash.Free;

                       end;

        finally
          DM.sds_ArquTodos.Close;
          FrmDlgPesquisa.Free;
        end;
           MostrarIcon;
      end;
      lookUser.Visible:=true;
      MostrarIcon;
    IniciaAdministracao;
    if not DM.ZQArquivo.IsEmpty then
    begin
      //Edit1.Text := DBText1.Caption;
      tempNome := DBMemo2.Lines.Text;
    end;
    if FileExists(Temp + '\' + TrocaCaracterEspecial(DM.ZQArquivoNOME_ARQUIVO.AsString,true)) = True then
    begin
      ExcluirTemp.Enabled := True;
      Image3.Visible := True;
    end
   { else if not(FileExists(Temp + '\' + DM.ZQArquivoNOME_ARQUIVO.AsString)) then
    begin
      ExcluirTemp.Enabled := False;
      Image3.Visible := False;
      SysUtils.Abort;
    end;  }

end;

procedure TFrPrincipal.btnextrairClick(Sender: TObject);
begin
  if DM.ZQArquivo.IsEmpty then
    begin
      MessageDlg('Não ha Arquivo no cadastro, consulte ou localize primeiro !',
        mtWarning, [mbOK], 0);
    end
    else
    begin
      with SaveDialog1 do
      begin
        FileName := DM.ZQArquivo['NOME_ARQUIVO'];
        if Execute then
        begin
          DM.ZQArquivoDADOS.SaveToFile(FileName);
        end;
      end;
    end;
end;

procedure TFrPrincipal.lookUserClick(Sender: TObject);
begin
    FrmAtribuiUser := TFrmAtribuiUser.Create(Self);
  try
    FrmAtribuiUser.ShowModal;
  finally
    FrmAtribuiUser.Free;
  end;
end;

procedure TFrPrincipal.sairClick(Sender: TObject);
begin
   if (MessageDlg('Deseja Sair do Sistema ?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  BEGIN
    try
      try
        DM.cds_ExcRepetidos.Close;
        DM.cds_ExcRepetidos.Params[0].AsInteger := FrmLogin.COD_USUARIO;
        DM.cds_ExcRepetidos.Open;
      finally
        DM.DtsrcExcLogados.DataSet.Delete;
        (DM.DtsrcExcLogados.DataSet as TZQuery).ApplyUpdates;
        (DM.DtsrcExcLogados.DataSet as TZQuery).CommitUpdates;

      end;
    Except
      on E: Exception do
      begin
        MessageDlg('Houve um problema no termino do aplicativo !', mtWarning,
          [mbOK], 0);
        // Application.Terminate;
      end;
    end;

    Application.Terminate;
  END;
end;

procedure TFrPrincipal.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
   if Panel.ID = 1 then
  begin
    StatusBar1.Canvas.Brush.Color := clWhite;
    StatusBar.Canvas.Font.Color := clBlue;
    StatusBar1.Canvas.FillRect(Rect);
    StatusBar1.Canvas.TextOut(Rect.left + 18, Rect.Top, Panel.Text);
    if FrmLogin.ADMIN = 0 then
    begin
      ImageList1.Draw(StatusBar.Canvas, Rect.left, Rect.Top, 1);
    end
    else
    begin
      ImageList1.Draw(StatusBar.Canvas, Rect.left, Rect.Top, 0);
    end;
  end
  else if Panel.ID = 2 then
  begin
    StatusBar1.Canvas.Brush.Color := clWhite;
    StatusBar.Canvas.Font.Color := clBlue;
    StatusBar1.Canvas.FillRect(Rect);
    StatusBar1.Canvas.TextOut(Rect.left + 18, Rect.Top, Panel.Text);
    ImageList1.Draw(StatusBar.Canvas, Rect.left, Rect.Top, 2);
  end
  else
  begin
    StatusBar1.Canvas.Brush.Color := clWhite;
    StatusBar.Canvas.Font.Color := clBlue;
    StatusBar1.Canvas.FillRect(Rect);
    StatusBar1.Canvas.TextOut(Rect.left + 18, Rect.Top, Panel.Text);
    ImageList1.Draw(StatusBar.Canvas, Rect.left, Rect.Top, 3);
  end;
end;

procedure TFrPrincipal.Timer1Timer(Sender: TObject);
begin
    MostrarEstatistica;
end;

procedure TFrPrincipal.IniciaAdministracao;
begin
  if FrmLogin.BitBtn2.ModalResult = mrOk then
  begin
    with DM.dst_Login do
      if not IsEmpty then
      begin

        { if (FrmLogin.TODOS = 1) then
          begin
          FrPrincipal.cbtconsulta.Enabled:=true;
          cbconsulta.Enabled := True;
          end else
          begin
          if (FrmLogin.TODOS = 0) then
          begin
          FrPrincipal.cbtconsulta.Enabled :=false;
          end; }

       { if DM.sdt_Verif_Perfil.FieldByName('MENU_ARQUI_CONSULTAS').AsString = 'S'
        then
        begin
          cbconsulta.Enabled := True;
        end
        else
        begin
          cbconsulta.Enabled := False;
        end; }
              // averiguar depois ...
       { if DM.sdt_Verif_Perfil.FieldByName('MENU_ARQUI_ASSUNTOS').AsString = 'S'
        then
        begin
          FrPrincipal.cbassunto.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbassunto.Enabled := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('MENU_ARQUI_AUTORES').AsString = 'S'
        then
        begin
          FrPrincipal.cbautores.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbautores.Enabled := False;
        end;
        // Sessão Menu Usuário
        if DM.sdt_Verif_Perfil.FieldByName('MENU_USUARIO_CADASTRO').AsString = 'S'
        then
        begin
          FrPrincipal.cbcadastro.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbcadastro.Enabled := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('MENU_USUARIO_PERFIL').AsString = 'S'
        then
        begin
          FrPrincipal.cbperfil.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbperfil.Enabled := False;
        end;

        // Sessão Menu Manutenção
        if FrmLogin.ADMIN = 1 then
        begin
          FrPrincipal.cbManutSQL.Visible := True;
        end
        else
        begin
          FrPrincipal.cbManutSQL.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('MENU_MANUTENCAO_TEMP').AsString = 'S'
        then
        begin
          FrPrincipal.cbManutTEMP.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbManutTEMP.Enabled := False;
        end;
        if FrmLogin.ADMIN = 1 then
        begin
          FrPrincipal.cbCadLogAssistente.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbCadLogAssistente.Enabled := False;
        end;
        if FrmLogin.ADMIN = 1 then
        begin
          FrPrincipal.cbManutAssistente.Enabled := True;
        end
        else
        begin
          FrPrincipal.cbManutAssistente.Enabled := False;
        end; }
        // Sessão MenuBar
        { if FrmLogin.NIVEL = 1 then
          begin
          if DMII.sdt_Verif_Perfil.FieldByName('ARQUI_CONSULTA').AsString = 'S' then
          begin
          FrPrincipal.cbtconsulta.Visible:=True;
          end
          else
          begin
          FrPrincipal.cbtconsulta.Visible:=false;
          end;
          end else
          begin
          FrPrincipal.cbtconsulta.Visible:=False;
          end; }
        if FrmLogin.NIVEL = 1 then
        begin
          FrPrincipal.btnvisualizar.Visible := True;
          FrPrincipal.btnextrair.Visible := True;
        end
        else if FrmLogin.NIVEL = 0 then
        begin
          FrPrincipal.btnvisualizar.Visible := False;
          FrPrincipal.btnextrair.Visible := False;
        end;
        // if FrmLogin.NIVEL = 1 then
        // begin
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_CONSULTAR').AsString = 'S'
        then
        begin
          FrPrincipal.cbtconsulta.Visible := True;
        end
        else
        begin
          FrPrincipal.cbtconsulta.Visible := False;
        end;
        // end
        // else
        // begin
        // FrPrincipal.cbconsulta.visible := False;
        // end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_USUARIO').AsString = 'S'
        then
        begin
          FrPrincipal.usuarios.Visible := True;
        end
        else
        begin
          FrPrincipal.usuarios.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_ASSUNTOS').AsString = 'S'
        then
        begin
          FrPrincipal.Assuntos.Visible := True;
        end
        else
        begin
          FrPrincipal.Assuntos.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_AUTORES').AsString = 'S'
        then
        begin
          FrPrincipal.autores.Visible := True;
        end
        else
        begin
          FrPrincipal.autores.Visible := False;
        end;
        if FrmLogin.ADMIN = 1 then
        begin
          FrPrincipal.log.Visible := True;
        end
        else
        begin
          FrPrincipal.log.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_LOCALIZAR').AsString = 'S'
        then
        begin
          FrPrincipal.btntrazer.Visible := True;
        end
        else
        begin
          FrPrincipal.btntrazer.Visible := False;
        end;
        // Sessão Botões de Cadastro
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_INSERIR').AsString = 'S'
        then
        begin
          FrPrincipal.inserir.Visible := True;
        end
        else
        begin
          FrPrincipal.inserir.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_EDITAR').AsString = 'S' then
        begin
          FrPrincipal.editar.Visible := True;
        end
        else
        begin
          FrPrincipal.editar.Visible := False;
        end;
        if DM.sdt_Verif_Perfil.FieldByName('ARQUI_EXCLUIR').AsString = 'S'
        then
        begin
          FrPrincipal.excluir.Visible := True;
        end
        else
        begin
          FrPrincipal.excluir.Visible := False;
        end;
      end;

  end;

end;


end.

