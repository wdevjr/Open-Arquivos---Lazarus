unit UnLogin;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, DBCtrls, ZDataset, process;

type

  { TFrmLogin }

  TFrmLogin = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DtsrcLogados: TDataSource;
    DtsrcExcRepetido: TDataSource;
    Dtsrc: TDataSource;
    Edtusuario: TComboBox;
    EdtSenha: TEdit;
    Image2: TImage;
    Image4: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

    private

    public
    i: Longint;
    ID: TStrings;
    // ID:Integer;
    COD_USUARIO: Integer;
    COD_PERFIL: Integer;
    NOME: string;
    LOGIN: string;
    NIVEL: Integer;
    ADMIN: Integer;
    TODOS: Integer;
    THEMA_ATUAL: String;
    procedure IncrementaAdd;
    procedure CorrigeUserCod;
  end;

var
  FrmLogin: TFrmLogin;
  auxint: Integer;
  auxRota: String;
  //auxRegistro: TRegIniFile;

implementation

{$R *.lfm}

{ TFrmLogin }

uses UnDM, UnPrinc, UnAbertura;

procedure TFrmLogin.BitBtn1Click(Sender: TObject);
var
  respValue: Integer;
  mensagem: String;

begin
  mensagem := 'Usuário ou Senha Invalidos !' + #13 + #13 +
    'Se você esqueceu sua Senha ' + #13 +
    'Consulte o Administrador do Sistema !' + #13;
  try
    DM.dst_Login.close;
    DM.dst_Login.SQL.Clear;
    DM.dst_Login.SQL.Add(
      'select UR.COD_USUARIO,PL.CODIGO,UR.NOME,UR.LOGIN,UR.NIVEL,UR.SENHA,UR.ADMINISTRADOR,UR.TIPO_TODOS from USUARIO UR inner join PERFIL PL on PL.CODIGO = UR.COD_PERFIL  where LOGIN = '
      + QuotedStr(Edtusuario.Text) + ' and SENHA = ' + QuotedStr(EdtSenha.Text));
    DM.dst_Login.Open;
  Except
    on E: Exception do
    begin
      MessageDlg('Erro no procedimento de Login !' + #13 +
        'Mensagem nativa do erro : ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
  if DM.dst_Login.RecordCount = 1 then
  begin
    with DM.dst_Login do
    begin
      COD_USUARIO := Fields[0].AsInteger;
      COD_PERFIL := Fields[1].AsInteger;
      NOME := Fields[2].AsString;
      LOGIN := Fields[3].AsString;
      NIVEL := Fields[4].AsInteger;
      ADMIN := Fields[6].AsInteger;
      TODOS := Fields[7].AsInteger;
      // THEMA_ATUAL := Fields[8].AsString;
      // ID.add(DM.dst_Login['ID']);
     // DMII.CarregaPerfil;  ------------------>
    end;
    // Sessão Menu Arquivo
    // ENTIDADE: LOG ...
    Dtsrc.DataSet.Open;
    Dtsrc.DataSet.Append;
    DM.cds_LogCOD_USUARIO.Value := COD_USUARIO;
    DM.cds_LogINSERDATA.Value := Date;
    DM.cds_LogHORA.Value := Time;
    DM.cds_LogCOD_ACAO.Value := 4;
    DM.cds_LogACAO.Value := 'LOGOU';
    DM.cds_LogAPLICATIVO.Value := 'LOGIN DE USUÁRIO';
    DM.cds_LogCOD_REGISTRO.Value := 0;
    DM.cds_LogDISCRIMINACAO.Value := 'SEM DADOS POIS ESTA LOGANDO';
    Dtsrc.DataSet.Post;
    (Dtsrc.DataSet as TZQuery).ApplyUpdates;
     (Dtsrc.DataSet as TZQuery).CommitUpdates;

    // VERIFICA ERROS ANTERIORES E REPETIÇÃO DE USUÁRIO
    if (DM.Verifica(COD_USUARIO) = true) then
    begin
      try
        CorrigeUserCod;
      Except
        on E: Exception do
        begin
          MessageDlg('Erro no procedimento CorrigeUserCod !' + #13 +
            'Mensagem nativa do erro : ' + E.Message, mtError, [mbOK], 0);
        end;
      end;
      try
        IncrementaAdd;
      Except
        on E: Exception do
        begin
          MessageDlg('Erro no procedimento IncrementaAdd !' + #13 +
            'Mensagem nativa do erro : ' + E.Message, mtError, [mbOK], 0);
        end;
      end;
    end
    else if DM.Verifica(COD_USUARIO) = False then
      try
        IncrementaAdd;
      Except
        on E: Exception do
        begin
          MessageDlg
            ('Algum procedimento falhou na procedure de incremento (IncrementaAdd) de Logandos !'
            + #13 + 'Mensagem nativa da procedure : ' + E.Message, mtError,
            [mbOK], 0);
          Abort;
        end;
      end;
    // //Application.CreateForm(TFrPrincipal, FrPrincipal);
    if not Assigned(FrPrincipal) then
      FrPrincipal := TFrPrincipal.Create(Application);
    FrPrincipal.Show;
    FrPrincipal.Visible := true;
    // try
    // thema := TStyleManager.Create();
    // thema.TrySetStyle('Sapphire Kamri');
    // FrPrincipal := TFrPrincipal.Create(Application);
    // try
    // FrPrincipal.ShowModal;
    // //FrmLogin.close;
    // finally
    // FrPrincipal.Free;
    // end;
    { Except
      on E: Exception do
      begin

      end;
      end; }

  end
  else if DM.dst_Login.RecordCount = 0 then
  begin
    Application.MessageBox(PChar(mensagem), 'Login de Usuário ',
      MB_OK + MB_ICONERROR);
    EdtSenha.Text := '';
    EdtSenha.SetFocus;
  end;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
var
    cont, ForGlobal: Longint;
begin
    // Abertura := TAbertura.Create(Application);
    // Abertura.Show;
    // Abertura.Refresh;
    Edtusuario.Items := DM.PreencheCombo;
    DM.ProgressBar1;
    // auxRegistro := TRegIniFile.Create('\');
    // auxRegistro.rootKey := HKEY_LOCAL_MACHINE;
    // auxRota := '\Software\Classes\Config';
    //
    // if auxRegistro.OpenKey(auxRota, False) then
    // begin
    // auxint := auxRegistro.ReadInteger('cnt', 'ctd1', 0);
    // auxRegistro.WriteInteger('cnt', 'ctd1', auxint - 1);
    // cont := auxRegistro.ReadInteger('cnt', 'ctd1', 5000);
    // end
    // else
    // begin
    // auxRegistro.CreateKey(auxRota);
    // auxRegistro.OpenKey(auxRota, False);
    // auxRegistro.WriteInteger('cnt', 'ctd1', 5000);
    // auxRegistro.WriteInteger('cnt', 'ctd2', 90);
    // auxRegistro.WriteString('Identificador', 'ldt1', 'Utilit');
    // auxRegistro.WriteString('Identificador', 'ldt2', 'n90');
    // auxRegistro.WriteString('Identificador', 'ldt3', 'v6.7.0.0');
    // end;
    // auxRegistro.CloseKey;
    // if (cont <= 0) then
    // begin
    // MessageDlg('Procure o Desenvolvedor do Sistema para uma Nova Licença!',
    // mtWarning, [mbOK], 0);
    // Application.Terminate;
    // end;
    Abertura.Free;
    // Abertura.Close;


end;

  procedure TFrmLogin.IncrementaAdd;
  var
    Qryorder: TZQuery;
  begin
    DM.Qury.close;
    DM.Qury.SQL.Clear;
    DM.Qury.SQL.Add('select CODIGO from NUM_LOGADOS');
    DM.Qury.Open;
    if (DM.Qury.RecordCount = 0) then
    begin
      DtsrcLogados.DataSet.Open;
      DtsrcLogados.DataSet.Append;
      DM.cds_LogadosORDEM.Value := 1;
      DM.cds_LogadosCOD_USUARIO.Value := COD_USUARIO;
      DM.cds_LogadosDATAATUAL.Value := Date;
      DtsrcLogados.DataSet.Post;
      (DtsrcLogados.DataSet as TZQuery).ApplyUpdates;
      (DtsrcLogados.DataSet as TZQuery).CommitUpdates;
    end
    else
    begin // termina a execução caso não esteja em modo de inserção
      Qryorder := TZQuery.Create(nil); // cria uma instância do objeto
      try
        Qryorder.Connection:=DM.ZConnection; // componente de conexão
        Qryorder.SQL.Add('SELECT MAX(ORDEM) as Num FROM NUM_LOGADOS');
        try
          Qryorder.Open;
        Except
          on E: Exception do
          begin
            MessageDlg('Problema com com o Select MAX... problemas no Banco ....'
              + E.Message, mtError, [mbOK], 0);
          end;
        end;
        if Qryorder.FieldByName('Num').AsInteger = 0 then
          // se a tabela está vazia retornará nulo    //então este será o primeiro registro
          Qryorder.Fields[0].AsInteger := 1
        else
          try
            DtsrcLogados.DataSet.Open;
            DtsrcLogados.DataSet.Append;
            DM.cds_LogadosORDEM.AsInteger := Qryorder.FieldByName('Num').AsInteger + 1;
            DM.cds_LogadosCOD_USUARIO.Value := COD_USUARIO;
            // DM.cds_LogadosDATAATUAL.Value := Date;
            DtsrcLogados.DataSet.Post;
            (DtsrcLogados.DataSet as TZQuery).ApplyUpdates;
            (DtsrcLogados.DataSet as TZQuery).CommitUpdates;
          Except
            on E: Exception do
            begin
              MessageDlg('Problemas no incremento (IncrementaAdd) ' + E.Message,
                mtError, [mbOK], 0);
            end;

          end;
      finally
        FreeAndNil(Qryorder); // tira o objeto da memória
      end;
    end;

  end;

  procedure TFrmLogin.CorrigeUserCod;
  begin
    try
      DM.cds_ExcRepetidos.close;
      DM.cds_ExcRepetidos.Params[0].AsInteger := COD_USUARIO;
      DM.cds_ExcRepetidos.Open;
    finally
      DtsrcExcRepetido.DataSet.Delete;
      (DtsrcExcRepetido.DataSet as TZQuery).ApplyUpdates;
      (DtsrcExcRepetido.DataSet as TZQuery).CommitUpdates;
    end
  end;



end.

