unit UnDlgPequisaUsuario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  DBGrids, StdCtrls, ZDataset, db;

type

  { TFrmPesqusaUsuario }

  TFrmPesqusaUsuario = class(TForm)
    BitBtn1: TBitBtn;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Dtsrc: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmPesqusaUsuario: TFrmPesqusaUsuario;

implementation

{$R *.lfm}

uses UnDM;

{ TFrmPesqusaUsuario }

procedure TFrmPesqusaUsuario.FormShow(Sender: TObject);
begin
with Dtsrc.DataSet as TZQuery do
  begin
    BtnOk.Enabled := not IsEmpty;
  end;
end;

procedure TFrmPesqusaUsuario.BitBtn1Click(Sender: TObject);
begin
  DM.sds_Autores.Close;
  DM.sds_Autores.Params[0].Value:='%'+Edit1.Text+'%';
  DM.sds_Autores.Open;

  with Dtsrc.DataSet as TZQuery do
  begin
    BtnOk.Enabled := not IsEmpty;
  end;
end;

end.

