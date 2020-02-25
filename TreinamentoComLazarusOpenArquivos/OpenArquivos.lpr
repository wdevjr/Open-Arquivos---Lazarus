program OpenArquivos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UnPrinc, UnDM, zcomponent, unDlgPesquisaArquivo, UnLogin, UnAbertura,
  unDlgDescricao, UnDlgDialogAssunto, undlgpesquisautores, UnProcessIndefinido,
  UnatribuiUsuariosPorArquivos, UnIncluirUsuarios, UnConsultaEspecial,
  datetimectrls, uncadastrousuarios, pkg_gifanim;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Open Arquivos';
  Application.Scaled:=True;
  Application.Initialize;

  Abertura := TAbertura.Create(nil);
  Abertura.Show;
  Abertura.Refresh;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

