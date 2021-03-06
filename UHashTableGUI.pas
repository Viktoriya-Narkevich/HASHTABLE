unit UHashTableGUI;

interface
uses UHashTable, UInfo, Grids,StdCtrls, Dialogs, SysUtils, Controls;
type
  TGUIHashTable = class(THashTable)
  private
    FModified:Boolean;
    FFileName:string;
    FGrid: TStringGrid;
  protected
    procedure SetModified(value:Boolean);
  public
    constructor Create(SG:TStringGrid; AC,AD:integer);
    procedure Clear; override;
    function Add(Info:TInfo):Boolean;
    function Delete(key:TKey):Boolean;
    function LoadFromFile(FileName:string):Boolean;
    procedure SaveToFile(FileName:string);
    property Modified:Boolean read FModified write SetModified;
    property FileName:String read FFileName;
  end;
implementation

{ TGUIHashTable }

function TGUIHashTable.Add(Info: TInfo): Boolean;
begin
  Result:=inherited Add(Info);
  if Result
    then Modified:=True;
end;

procedure TGUIHashTable.Clear;
begin
  if Count >0
    then
      begin
        inherited Clear;
        Modified:=True;
      end;
end;

constructor TGUIHashTable.Create(SG:TStringGrid; AC,AD:integer);
var info:TInfo;
begin
  inherited Create(AC,AD);
  FModified:=False;
  FFileName:='';
  FGrid:=SG;
  info.ShowTitle(FGrid);
end;

function TGUIHashTable.Delete(key: TKey): Boolean;
begin
  Result:=inherited Delete(key);
  if Result then
    Modified:=True;
end;

function TGUIHashTable.LoadFromFile(FileName: String): Boolean;
var info:TInfo;
begin
  FFileName:=FileName;
  Result:=inherited LoadFromFile(Filename);
  FModified:=False;
  info.ShowTitle(FGrid);
  View(FGrid);
end;

procedure TGUIHashTable.SaveToFile(FileName: string);
begin
  FFileName:=FileName;
  FModified:=false;
  inherited SaveToFile(FFileName);
end;


procedure TGUIHashTable.SetModified(value: Boolean);
begin
  FModified:=value;
  if value then
    View(FGrid);
end;

end.
