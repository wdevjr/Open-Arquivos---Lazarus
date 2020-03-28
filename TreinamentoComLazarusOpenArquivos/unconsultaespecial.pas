unit UnConsultaEspecial;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, DBCtrls, DateTimePicker;

type

  { TFrmConsultaEspecial }

  TFrmConsultaEspecial = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSourceCriterio: TDataSource;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DtsrcCod: TDataSource;
    Dtscru: TDataSource;
    Dtscra: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    habilitar00: TBitBtn;
    desabilitar00: TBitBtn;
    habilitar02: TBitBtn;
    desabilitar02: TBitBtn;
    Image1: TImage;
    Label2: TLabel;
    Label6: TLabel;
    PanelMostrData: TPanel;
    SpeedButton11: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TBitBtn;
    SpeedButton10: TBitBtn;
    SpeedButton12: TBitBtn;
    SpeedButton13: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBoxConsulta: TCheckBox;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    PanelMaximizar: TPanel;
    Alert: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    StaticText1: TStaticText;
    procedure SpeedButton8Click(Sender: TObject);
  private

  public

  end;

var
  FrmConsultaEspecial: TFrmConsultaEspecial;

implementation

{$R *.lfm}

{ TFrmConsultaEspecial }

uses UnDM;

procedure TFrmConsultaEspecial.SpeedButton8Click(Sender: TObject);
begin
  try
    try
      DM.ZQueryRelatorioArquivo.Close;
      //DM.ZQueryRelatorioArquivo.Params[0].Value := DM.ZQArquivoID.AsInteger;
      DM.ZQueryRelatorioArquivo.Open;
    except
      on E: Exception do
      begin
        MessageDlg('Erro de Consulta de Arquivo!', E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    DM.frReportArquivo.LoadFromFile('Reports/RelConsultaArquivos.lrf');
    DM.frReportArquivo.showReport;
  end;
end;

end.
