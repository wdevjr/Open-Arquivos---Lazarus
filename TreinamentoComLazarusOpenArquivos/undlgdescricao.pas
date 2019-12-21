unit unDlgDescricao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, Buttons,
  ExtCtrls, StdCtrls;

type

  { TFrmDlgDescricao }

  TFrmDlgDescricao = class(TForm)
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    DBMemo1: TDBMemo;
    Image1: TImage;
    Label1: TLabel;
  private

  public

  end;

var
  FrmDlgDescricao: TFrmDlgDescricao;

implementation

{$R *.lfm}

uses UnDM;

end.

