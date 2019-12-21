unit UnDM;

{$mode objfpc}{$H+}

interface

uses
    Windows, Messages, Classes, SysUtils, IBConnection, sqldb, db, FileUtil,
    LR_Class, LR_DBSet, LR_ChBox, Forms, Controls, Graphics, Dialogs, DBGrids,
    ZConnection, ZDataset, ZSqlUpdate, IniFiles;

type

  { TDM }

  TDM = class(TDataModule)
    cds_ExcRepetidosCODIGO: TLongintField;
    cds_ExcRepetidosCOD_USUARIO: TLongintField;
    cds_ExcRepetidosDATAATUAL: TDateField;
    cds_ExcRepetidosORDEM: TLongintField;
    cds_LogACAO: TStringField;
    cds_logadosCODIGO: TLongintField;
    cds_logadosCOD_USUARIO: TLongintField;
    cds_logadosDATAATUAL: TDateField;
    cds_logadosORDEM: TLongintField;
    cds_LogAPLICATIVO: TStringField;
    cds_LogCODIGO: TLongintField;
    cds_LogCOD_ACAO: TLongintField;
    cds_LogCOD_REGISTRO: TLongintField;
    cds_LogCOD_USUARIO: TLongintField;
    cds_LogDISCRIMINACAO: TStringField;
    cds_LogHORA: TTimeField;
    cds_LogINSERDATA: TDateField;
    cds_UserAddIDARQUIVOS: TLongintField;
    cds_UserAddIDUSUARIOS: TLongintField;
    Dtsrc_Logando: TDataSource;
    DtsrcExcLogados: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    sds_ArquCOD_ASSUNTO: TLongintField;
    sds_ArquCOD_USUARIO: TLongintField;
    sds_ArquDATA: TDateField;
    sds_ArquDESCRICAO: TStringField;
    sds_ArquID: TLongintField;
    sds_ArquIDUSUARIOS: TLongintField;
    sds_ArquNOME: TStringField;
    sds_ArquNOME_1: TStringField;
    sds_ArquNOME_ARQUIVO: TStringField;
    sds_ArquTITULO: TStringField;
    sds_ArquTITULOASSUN: TStringField;
    sds_ArquTodosCOD_USUARIO: TLongintField;
    sds_ArquTodosDESCRICAO: TStringField;
    sds_ArquTodosID: TLongintField;
    sds_ArquTodosINFORMACOES: TMemoField;
    sds_ArquTodosLOGIN: TStringField;
    sds_ArquTodosNIVEL: TLongintField;
    sds_ArquTodosNOME: TStringField;
    sds_ArquTodosNOME_1: TStringField;
    sds_ArquTodosNOME_ARQUIVO: TStringField;
    sds_ArquTodosTITULO: TStringField;
    sds_ArquTodosTITULOASSUN: TStringField;
    sds_AssuntCODIGO: TLongintField;
    sds_AssuntTITULOASSUN: TStringField;
    sds_AutoresCODIGO: TLongintField;
    sds_AutoresCOD_DEPARTAMENTO: TLongintField;
    sds_AutoresINSTITUICAO: TStringField;
    sds_AutoresNOME: TStringField;
    sds_AutoresNOME_DEP: TStringField;
    sds_Cont_LogarCODIGO: TLongintField;
    sds_Cont_LogarCOD_USUARIO: TLongintField;
    sds_Cont_LogarDATAATUAL: TDateField;
    sds_Cont_LogarORDEM: TLongintField;
    sds_lista_UsuariosCOD_USUARIO: TLongintField;
    sds_lista_UsuariosIDARQUIVOS: TLongintField;
    sds_lista_UsuariosIDUSUARIOS: TLongintField;
    sds_lista_UsuariosNOME: TStringField;
    sdt_Verif_PerfilARQUI_ASSUNTOS: TStringField;
    sdt_Verif_PerfilARQUI_AUTORES: TStringField;
    sdt_Verif_PerfilARQUI_CONSULTAR: TStringField;
    sdt_Verif_PerfilARQUI_EDITAR: TStringField;
    sdt_Verif_PerfilARQUI_EXCLUIR: TStringField;
    sdt_Verif_PerfilARQUI_INSERIR: TStringField;
    sdt_Verif_PerfilARQUI_LOCALIZAR: TStringField;
    sdt_Verif_PerfilARQUI_USUARIO: TStringField;
    sdt_Verif_PerfilASSUNTOS_EDITAR: TStringField;
    sdt_Verif_PerfilASSUNTOS_EXCLUIR: TStringField;
    sdt_Verif_PerfilASSUNTOS_INSERIR: TStringField;
    sdt_Verif_PerfilASSUNTOS_TRAZER: TStringField;
    sdt_Verif_PerfilAUTORES_EDITAR: TStringField;
    sdt_Verif_PerfilAUTORES_EXCLUIR: TStringField;
    sdt_Verif_PerfilAUTORES_INSERIR: TStringField;
    sdt_Verif_PerfilAUTORES_TRAZER: TStringField;
    sdt_Verif_PerfilCODIGO: TLongintField;
    sdt_Verif_PerfilCONFIG_BOTOES: TStringField;
    sdt_Verif_PerfilCONFIG_CONVERTER: TStringField;
    sdt_Verif_PerfilMENU_ARQUI_ASSUNTOS: TStringField;
    sdt_Verif_PerfilMENU_ARQUI_AUTORES: TStringField;
    sdt_Verif_PerfilMENU_ARQUI_CONSULTAS: TStringField;
    sdt_Verif_PerfilMENU_MANUTENCAO_SQL: TStringField;
    sdt_Verif_PerfilMENU_MANUTENCAO_TEMP: TStringField;
    sdt_Verif_PerfilMENU_USUARIO_CADASTRO: TStringField;
    sdt_Verif_PerfilMENU_USUARIO_PERFIL: TStringField;
    sdt_Verif_PerfilNOMEL: TStringField;
    sdt_Verif_PerfilUSUARIO_EDITAR: TStringField;
    sdt_Verif_PerfilUSUARIO_EXCLUIR: TStringField;
    sdt_Verif_PerfilUSUARIO_INSERIR: TStringField;
    sdt_Verif_PerfilUSUARIO_TRAZER: TStringField;
    ZConnection: TZConnection;
    ZQArquivo: TZQuery;
    sdt_Combo: TZQuery;
    dst_Login: TZQuery;
    cds_Log: TZQuery;
    sdt_Verif: TZQuery;
    sds_Verif: TZQuery;
    cds_logados: TZQuery;
    cds_ExcRepetidos: TZQuery;
    Qury: TZQuery;
    sdt_List: TZQuery;
    sdt_ExcAtual: TZQuery;
    Qry_Secun: TZQuery;
    sds_cont: TZQuery;
    sds_Cont_Logar: TZQuery;
    sdt_Verif_Perfil: TZQuery;
    ZQArquivoCOD_ASSUNTO: TLongintField;
    ZQArquivoCOD_AUTOR: TLongintField;
    ZQArquivoCOD_USUARIO: TLongintField;
    ZQArquivoDADOS: TBlobField;
    ZQArquivoDATA: TDateField;
    ZQArquivoDESCRICAO: TStringField;
    ZQArquivoEXTENCAO: TStringField;
    ZQArquivoHORA: TTimeField;
    ZQArquivoID: TLongintField;
    ZQArquivoINFORMACOES: TMemoField;
    ZQArquivoNOME_ARQUIVO: TStringField;
    ZQArquivoSIZE_ARQUIVO: TFloatField;
    ZQArquivoTAMANHO: TStringField;
    ZQArquivoTITULO: TStringField;
    ZQLocalisaArquivoCOD_USUARIO: TLongintField;
    ZQLocalisaArquivoDESCRICAO: TStringField;
    ZQLocalisaArquivoID: TLongintField;
    ZQLocalisaArquivoLOGIN: TStringField;
    ZQLocalisaArquivoNIVEL: TLongintField;
    ZQLocalisaArquivoNOME: TStringField;
    ZQLocalisaArquivoNOME_1: TStringField;
    ZQLocalisaArquivoNOME_ARQUIVO: TStringField;
    ZQLocalisaArquivoTITULO: TStringField;
    ZQLocalisaArquivoTITULOASSUN: TStringField;
    sds_Arqu: TZQuery;
    sds_ArquTodos: TZQuery;
    sds_Assunt: TZQuery;
    sds_Autores: TZQuery;
    cds_UserAdd: TZQuery;
    sds_lista_Usuarios: TZQuery;
    ZQuery1: TZQuery;
    ZQuery1NOME_ARQUIVO: TStringField;
    ZQuery2: TZQuery;
    ZQuery2COD_ASSUNTO: TLongintField;
    ZQuery2COD_AUTOR: TLongintField;
    ZQuery2COD_USUARIO: TLongintField;
    ZQuery2DATA: TDateField;
    ZQuery2DESCRICAO: TStringField;
    ZQuery2EXTENCAO: TStringField;
    ZQuery2HORA: TTimeField;
    ZQuery2ID: TLongintField;
    ZQuery2INFORMACOES: TMemoField;
    ZQuery2NOME_ARQUIVO: TStringField;
    ZQuery2NOME_ARQUIVO_ESPECIAL: TStringField;
    ZQuery2SIZE_ARQUIVO: TFloatField;
    ZQuery2TAMANHO: TStringField;
    ZQuery2TITULO: TStringField;
    ZUpdateSQL1: TZUpdateSQL;
    ZUpdateSQL2: TZUpdateSQL;
    ZUpdateSQL3: TZUpdateSQL;
    ZUpdateSQL4: TZUpdateSQL;
    ZUpdateSQL5: TZUpdateSQL;
    ZUpdateSQL6: TZUpdateSQL;
    ZUpdateSQL7: TZUpdateSQL;
    procedure cds_ExcRepetidosNewRecord(DataSet: TDataSet);
    procedure cds_logadosBeforePost(DataSet: TDataSet);
    procedure cds_logadosNewRecord(DataSet: TDataSet);
    procedure cds_LogBeforePost(DataSet: TDataSet);
    procedure cds_LogNewRecord(DataSet: TDataSet);
    procedure cds_UserAddApplyUpdateError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
     procedure ProgressBar1;
     procedure sds_lista_UsuariosFilterRecord(DataSet: TDataSet;
       var Accept: Boolean);
     procedure ZConnectionBeforeConnect(Sender: TObject);
    procedure ZQArquivoBeforePost(DataSet: TDataSet);
    procedure ZQArquivoNewRecord(DataSet: TDataSet);
    procedure VerificaErroCount;
  private

  public

    codigo: Integer;
    codigoUser: Integer;
    CodUser: Integer;
    TipoUser: string;
    condNivel: Integer;
    checado: Integer;
    adminis: Integer;
    codigoArqui: Integer;
    codigoLogado: Integer;
    Function VerificaUser(codigoParam: Integer): Boolean;
    Function Verifica(codigoParam: Integer): Boolean;
    Function COUNTDADOS: Integer;
    function PreencheCombo: TStrings;
    function PreencheList: TStrings;
    //function receberValor: Integer;
   // function receberUsuario: Integer;
    procedure ExcluirAtual(CodUserUnic: Integer);
    procedure IncrementaPersonalizado(Nome_Tabela: String; Chave_Primaria: TField);

  end;

var
  DM: TDM;


implementation

{$R *.lfm}

uses UnPrinc, Unlogin, UnAbertura;


procedure TDM.IncrementaPersonalizado(Nome_Tabela: String;
  Chave_Primaria: TField);
var
  Qry: TZQuery;
begin
  // if Chave_Primaria.DataSet.State <> dsInsert then
  // exit; // termina a execução caso não esteja em modo de inserção
  Qry := TZQuery.Create(nil); // cria uma instância do objeto
  try
    Qry.Connection := ZConnection; // componente de conexão
    Qry.SQL.Add('SELECT MAX(' + Chave_Primaria.FieldName + ') FROM ' +
      Nome_Tabela);
    Qry.Open;
    if (Qry.Fields[0].IsNull) OR (Qry.Fields[0].AsInteger = 0) then
      // se a tabela está vazia retornará nulo
      Chave_Primaria.AsInteger := 402585
      // então este será o primeiro registro
    else
      Chave_Primaria.AsInteger := Qry.Fields[0].AsInteger + 1;
  finally
    FreeAndNil(Qry); // tira o objeto da memória
  end;
end;

procedure TDM.cds_LogNewRecord(DataSet: TDataSet);
begin
  IncrementaPersonalizado('LOG', cds_LogCODIGO);
end;

procedure TDM.cds_UserAddApplyUpdateError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  ShowMessage('Esse Usuário já Existe no Arquivo! ');
end;

procedure TDM.cds_LogBeforePost(DataSet: TDataSet);
begin
    if cds_Log.State = dsInsert then
    IncrementaPersonalizado('LOG', cds_LogCODIGO);
  cds_LogINSERDATA.Value := Date;
end;

procedure TDM.cds_logadosBeforePost(DataSet: TDataSet);
begin
    if cds_Logados.State = dsInsert then
   IncrementaPersonalizado('NUM_LOGADOS', cds_LogadosCODIGO);
  cds_LogadosDATAATUAL.Value := Date;
end;

procedure TDM.cds_logadosNewRecord(DataSet: TDataSet);
begin
     IncrementaPersonalizado('NUM_LOGADOS', cds_LogadosCODIGO);
end;

procedure TDM.cds_ExcRepetidosNewRecord(DataSet: TDataSet);
begin
    IncrementaPersonalizado('NUM_LOGADOS', cds_LogadosCODIGO);
end;

procedure TDM.ZQArquivoBeforePost(DataSet: TDataSet);
var
  DataInserimento: String;
begin
  if ZQArquivo.State = dsInsert then
  begin
    DataInserimento := DM.ZQArquivoDATA.AsString;

    ZQArquivoDATA.Value := Date;
    // FormatDateTime('dd/MM/yyyy',StrToDate(DataInserimento));
    ZQArquivoHORA.Value := Time;
   // ZQArquivoHORA.Value:=TimeToStr(Time);  SQL SERVER ...
    ZQArquivoCOD_USUARIO.AsInteger:=FrmLogin.COD_USUARIO;
  end;

end;

procedure TDM.ZQArquivoNewRecord(DataSet: TDataSet);
begin
  IncrementaPersonalizado('ARQUIVOLIST', ZQArquivoID);
end;

 procedure TDM.ProgressBar1;
begin
  Abertura.ProgressBar1.Max := sdt_Combo.RecordCount;
  sdt_Combo.First;
  if not sdt_Combo.Eof then
    repeat
      Abertura.ProgressBar1.Position := Abertura.ProgressBar1.Position + 1;
      Sleep(1000);
      sdt_Combo.Next
    until sdt_Combo.Eof;
end;

procedure TDM.sds_lista_UsuariosFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
    Accept := False;
  if (sds_lista_Usuarios['IDUSUARIOS'] = frmlogin.COD_USUARIO) then
  begin
    Accept := True;
  end;
end;

procedure TDM.ZConnectionBeforeConnect(Sender: TObject);
var
  Ini: TIniFile;
begin
    Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'String_Conexao.ini');
    try
        ZConnection.Connected       := False;
        ZConnection.HostName        := Ini.ReadString('ZConnection', 'Hostname', '');
        ZConnection.Port            := Ini.ReadInteger('ZConnection', 'Port', 0);
        ZConnection.Protocol        := Ini.ReadString('ZConnection', 'Protocol', '');
        ZConnection.LibraryLocation := Ini.ReadString('ZConnection', 'LibraryLocation', '');
        ZConnection.User            := Ini.ReadString('ZConnection', 'User', '');
        ZConnection.Password        := Ini.ReadString('ZConnection', 'Password', '');
        ZConnection.Database        := Ini.ReadString('ZConnection', 'Database', '');
        ZConnection.ClientCodepage  := Ini.ReadString('ZConnection', 'Charset', '');
        ZConnection.AutoEncodeStrings  := False;

    except
         on E:Exception do
         MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);
    end;
end;


function TDM.PreencheCombo: TStrings;
var
  aStr: TStrings;
begin
  aStr := TStringList.Create;
  sdt_Combo.Close;
  sdt_Combo.SQL.Add('select LOGIN from USUARIO order by LOGIN');
  sdt_Combo.Open;
  sdt_Combo.First;
  while not sdt_Combo.Eof do
  begin
    aStr.Add(sdt_Combo.FieldByname('LOGIN').AsString);
    sdt_Combo.Next;
  end;
  Result := aStr;
end;

function TDM.PreencheList: TStrings;
var
  Str: TStrings;
begin
  Str := TStringList.Create;
  sdt_List.Close;
  sdt_List.SQL.Add('select COD_USUARIO, NOME from USUARIO order by NOME');
  sdt_List.Open;
  sdt_List.First;
  while not sdt_List.Eof do
  begin
    // Str.Add(sdt_List.FieldByName('COD_USUARIO').AsString);
    Str.Add(sdt_List.FieldByname('NOME').AsString);
    sdt_List.Next;
  end;
  Result := Str;
end;

Function TDM.VerificaUser(codigoParam: Integer): Boolean;
begin
  Result := False;
  sdt_Verif.Close;
  sdt_Verif.SQL.Clear;
  sdt_Verif.SQL.Add('select COD_USUARIO,NIVEL from USUARIO ' +
    'where COD_USUARIO = ' + IntToStr(codigoParam));
  sdt_Verif.Open;
  with sdt_Verif do
  begin
    if not sdt_Verif.IsEmpty then
    begin
      if (Fields[1].AsInteger = 1) then
      begin
        Result := True;
      end
      else
        Result := False;
    end;
  end;
end;

Function TDM.Verifica(codigoParam: Integer): Boolean;
begin
  Result := False;
  sds_Verif.Close;
  sds_Verif.SQL.Clear;
  sds_Verif.SQL.Add('select CODIGO,COD_USUARIO from NUM_LOGADOS '
    + ' where COD_USUARIO = ' + IntToStr(codigoParam));

  sds_Verif.Open;

  with sds_Verif do
  begin
    if (RecordCount = 0) then
    begin
      Result := False;
    end
    else if (RecordCount >= 1) then
    begin
      Result := True;
    end
  end;
end;

procedure TDM.ExcluirAtual(CodUserUnic: Integer);
begin
  CodUserUnic := frmlogin.COD_USUARIO;
  try
    sdt_ExcAtual.Close;
    sdt_ExcAtual.SQL.Clear;
    sdt_ExcAtual.SQL.Add('delete from NUM_LOGADOS ' +
      ' where COD_USUARIO = ' + IntToStr(CodUser));
    sdt_ExcAtual.Open;
  Except
    on E: Exception do
    begin
      MessageDlg
        ('Erro de instrução SQL ou Algum problema no Banco ou Usuário inadequado !'
        + #13 + 'Mensagem nativa do erro é : ' + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDM.VerificaErroCount;
begin

  Qry_Secun.Close;
  Qry_Secun.SQL.Clear;
  Qry_Secun.SQL.Add('select COD_USUARIO from NUM_LOGADOS ' +
    ' where COD_USUARIO = 0');
  Qry_Secun.Open;
  if Qry_Secun.RecordCount >= 1 then
  begin
    try
      try
        DM.cds_ExcRepetidos.Close;
        DM.cds_ExcRepetidos.Params[0].AsInteger := 0;
        DM.cds_ExcRepetidos.Open;
      finally
        Dtsrc_Logando.DataSet.Delete;
        //(Dtsrc_Logando.DataSet as TClientDataSet).ApplyUpdates(0);
      end;
    Except
      on E: Exception do
      begin
        MessageDlg
          ('Algum procedimento falhou na procedure de verificar erros de Logandos !'
          + #13 + 'Mensagem nativa da procedure : ' + E.Message, mtError,
          [mbOk], 0);
      end;
    end;
  end;
end;

Function TDM.COUNTDADOS: Integer;
var
  respMaxLogados: Integer;
begin
  Result := 0;
  respMaxLogados := 0;
  try
   // DM.sds_AnteCount.Close;
 //   DM.sds_AnteCount.DataSet.CommandText := '';
  //  DM.sds_AnteCount.DataSet.CommandText := 'select COUNT(*) from NUM_LOGADOS ';
  //  DM.sds_AnteCount.Open;
   // respMaxLogados := DM.sds_AnteCount.Fields[0].AsInteger;
  Except
    on E: Exception do
    begin
      MessageDlg
        ('Erro ao montar a instrução SQL[MAX] ou algum parametro de linha inconsistente !'
        + #13 + 'Mensagem Nativa do Erro : ' + E.Message, mtError, [mbOk], 0);
      Abort;
    end
    else
    begin
      Result := respMaxLogados;
    end;
  end;
end;


end.

