unit UInfo;

interface
uses SysUtils, Grids, Classes;
type
  TKey = string[255];
  TInfo = class
            private
              FilmName: TKey;
              Director: string;
              Actors: string;
              Description: string;

              function KeyToStr(Key:TKey):string;
            public
              constructor Create; overload;
              constructor Create(AFilmName: TKey; ADirector, AActors, ADescription: string); overload;
              class function HF(key: TKey): integer;
              function IsEqualKey(k1, k2: TKey): boolean;
              procedure SaveInfo(var f: TextFile; info: TInfo);
              function LoadInfo(var f: TextFile; var info: TInfo):boolean;
              procedure ShowTitle(SG: TStringGrid);
              procedure ShowInfo(info: TInfo; Row: TStrings);

              property FName: TKey
                read FilmName write FilmName;
              property Direct: string
                read Director write Director;
              property Act: string
                read Actors write Actors;
              property Descript: string
                read Description write Description;

          end;


implementation

function TInfo.KeyToStr(Key:Tkey):string;
begin
result:=Key;
end;

function GetValue(var str:string;var value:string):boolean;
var i, len:integer;
begin
  str:=trim(str);
  len:=length(str);
  i:=1;
  if len>0 then
    begin
      while (i<=len) and (str[i]<>#9) do
        inc(i);
      value:=trim(copy(str,1,i-1));
      result:=true;
      delete(str,1,i);
    end
  else
    result:=false;
end;

constructor TInfo.Create;
begin
  FilmName:='';
  Director:='';
  Actors:='';
  Description:='';
  inherited Create;
end;

constructor TInfo.Create(AFilmName: TKey; ADirector, AActors, ADescription: string);
begin
  inherited Create;
  FilmName:=AFilmName;
  Director:=ADirector;
  Actors:=AActors;
  Description:=ADescription;
end;

class function TInfo.HF(key: TKey):integer;
var i:integer;
begin
  Result:=0;
  for i:=1 to length(key) do
    Result:=Result + ord(key[i]);
end;

function TInfo.IsEqualKey(k1, k2: TKey):boolean;
begin
  Result:= k1 = k2;
end;

function TInfo.LoadInfo(var f: TextFile; var info: TInfo): boolean;
var tmp, BFilmName, BDirector, BActors, BDescription:string;
begin
  if eof(f) then
    result:=false
  else
    begin
      readln(f,tmp);
      result:=GetValue(tmp,BFilmName) and GetValue(tmp,BDirector) and GetValue(tmp,BActors) and GetValue(tmp,BDescription) and (BFilmName<>'');
    end;
  if Result then
        info:= TInfo.Create(BFilmName, BDirector, BActors,BDescription)


end;

const Tab = #9;

procedure TInfo.SaveInfo(var f: TextFile; info: TInfo);
begin
  with info do
    begin
      writeln(f, 'Название: ' + FilmName);
      writeln(f, 'Режиссер: ' + Director);
      writeln(f, 'Актеры: ' + Actors);
      writeln(f, 'Описание: ' + Description);
      writeln(f);
    end
end;

procedure TInfo.ShowTitle(SG: TStringGrid);
begin
  with SG do
    begin
      RowCount:= 2;
      FixedRows:= 1;
      ColCount:= 4;
      FixedCols:= 0;
      Cells[0, 0] := 'Название';
      Cells[1, 0] := 'Режиссер';
      Cells[2, 0] := 'Актеры';
      Cells[3, 0] := 'Описание';
      Rows[1].Clear;
    end;
end;

procedure TInfo.ShowInfo(info : TInfo; Row : TStrings);
begin
  Row[0] := info.FilmName;
  Row[1] := info.Director;
  Row[2] := info.Actors;
  Row[3] := info.Description;
end;

end.
 