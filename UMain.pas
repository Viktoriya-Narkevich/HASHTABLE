unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,QDialogs, Menus, Grids, UInfo, UHelpForm, UHashTableGUI, UHashTable;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    NNew: TMenuItem;
    NOpen: TMenuItem;
    NSave: TMenuItem;
    NSaveAs: TMenuItem;
    NClose: TMenuItem;
    N7: TMenuItem;
    NAdd: TMenuItem;
    NDelete: TMenuItem;
    NClear: TMenuItem;
    NFind: TMenuItem;
    NExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure NOpenClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose:boolean);
    procedure NCloseClick(Sender: TObject);
    procedure NNewClick(Sender: TObject);
    procedure NFindClick(Sender: TObject);
    procedure NSaveClick(Sender: TObject);
    procedure NSaveAsClick(Sender: TObject);
    procedure NDeleteClick(Sender: TObject);
    procedure NClearClick(Sender: TObject);
    procedure NAddClick(Sender: TObject);
  private
    HashTable:TGUIHashTable;
    procedure MyIdle(sender: TObject; var Done:boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.FormCreate(Sender: TObject);
begin
  HashTable:=nil;
  Application.OnIdle:= MyIdle;
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if HashTable<>nil
    then NClose.Click;
  CanClose:=HashTable = nil;
end;

procedure TForm1.NCloseClick(Sender: TObject);
var
  CanClose:Boolean;
begin
  Canclose:=True;
  if (HashTable<>nil) and HashTable.Modified then
      case MessageDlg('��������� ���������?', mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrNo:;
        mrCancel: CanClose:=False;
        mrYes:
          begin
            NSave.Click;
            CanClose:= not HashTable.Modified;
          end;
      end;
  if CanClose
    then FreeAndNil(HashTable);

end;

procedure TForm1.MyIdle(sender: TObject; var Done: Boolean);
var
  HashTableExists, RecordsPresent : Boolean;
begin
  HashTableExists := HashTable <> nil;
  RecordsPresent := HashTableExists and not HashTable.IsEmpty;

  StringGrid1.Visible := HashTableExists;
  NSave.Enabled := HashTableExists;
  NSaveAs.Enabled := HashTableExists;
  NClose.Enabled := HashTableExists;
  NAdd.Enabled := HashTableExists;
  NDelete.Enabled := RecordsPresent;
  NClear.Enabled := RecordsPresent;
  NFind.Enabled := RecordsPresent;
end;

procedure TForm1.NOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute
    then
      begin
        if HashTable <> nil
          then NClose.Click;

        if HashTable = nil
          then
            begin
              HashTable:=TGUIHashTable.Create(StringGrid1, 5, 6);
              HashTable.LoadFromFile(OpenDialog1.FileName);
            end;
      end;
end;


procedure TForm1.NNewClick(Sender: TObject);
begin
  if HashTable <> nil
    then NClose.Click;

  if HashTable = nil
    then HashTable:=TGUIHashTable.Create(StringGrid1,5,6);
end;

procedure TForm1.NFindClick(Sender: TObject);
var
  key:string;
  MyInfo:TInfo;
  FormShow: TTFormAdd;
begin
  key:='';
  if InputQuery('�����', '������� �������� ������', key) then
    begin
      if HashTable.Find(key,MyInfo)
        then
          begin
            FormShow:=TTFormAdd.Create(Self);
            with FormShow do
            begin
              Caption:='��������� �����';
              ETitle.Text:=MyInfo.FName;
              EDirector.Text:=MyInfo.Direct;
              EActors.Text:=MyInfo.Act;
              MDescription.Text:=MyInfo.Descript;
              ETitle.ReadOnly:=True;
              EActors.ReadOnly:=True;
              MDescription.ReadOnly:=True;
              EDirector.ReadOnly:=True;
              Button2.Visible:=False;
              ShowModal
            end;
            FreeAndNil(FormShow);
          end
        else ShowMessage('����� �� ������');
    end;
end;

procedure TForm1.NSaveClick(Sender: TObject);
begin
     if HashTable.Filename = ''
    then NSaveAs.Click
    else HashTable.SaveToFile(HashTable.FileName);
end;

procedure TForm1.NSaveAsClick(Sender: TObject);
begin
  SaveDialog1.FileName:=HashTable.Filename;
  if SaveDialog1.Execute
    then HashTable.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.NDeleteClick(Sender: TObject);
var
  key:string;
begin
  key:='';
  if QDialogs.InputQuery('��������','������� �������� ������',key)
    then
      if HashTable.Delete(key)
        then ShowMessage('����� ������')
        else MessageDlg('����� �� ������',mtError,[mbCancel],0)
end;

procedure TForm1.NClearClick(Sender: TObject);
begin
  case MessageDlg('�� ������������� ������ �������� �������?',mtConfirmation,[mbYes,mbNo], 0) of
      mrYes :  HashTable.Clear;
      mrNo:;
   end;
end;

procedure TForm1.NAddClick(Sender: TObject);
begin
  with TTFormAdd.Create(Self) do
    try
      if ShowModal=mrOK then
          if not HashTable.Add(Info)
            then
              begin
                MessageDlg('����� � ����� ������ ��� ������������ � �������',mtError,[mbCancel],0);
                Info.Free
              end;
    finally
      Free
    end;
end;

end.



