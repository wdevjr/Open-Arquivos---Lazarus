unit UnProcessIndefinido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  GifAnim;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    GifAnim1: TGifAnim;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
  private

  public

  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

end.

