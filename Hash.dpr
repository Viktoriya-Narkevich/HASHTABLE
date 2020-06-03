program Hash;

uses
  Forms,
  UInfo in 'UInfo.pas',
  UHashTable in 'UHashTable.pas',
  UHashTableGUI in 'UHashTableGUI.pas',
  UHelpForm in 'UHelpForm.pas' {TFormAdd},
  UMain in 'UMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TTFormAdd, TFormAdd);
  Application.Run;
end.
