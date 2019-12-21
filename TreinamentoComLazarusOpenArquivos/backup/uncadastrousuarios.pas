unit uncadastrousuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, DBCtrls, Buttons;

type

  { TFrmCadastrodeUsuarios }

  TFrmCadastrodeUsuarios = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit1: TDBEdit;
    DBImage1: TDBImage;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ListView1: TListView;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    StaticText1: TStaticText;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
  private

  public

  end;

var
  FrmCadastrodeUsuarios: TFrmCadastrodeUsuarios;

implementation

{$R *.lfm}

end.

