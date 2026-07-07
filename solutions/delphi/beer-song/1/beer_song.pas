unit uBeerSong;

interface

type
  Beer = class
  private
    class function NumBottles(const AIndex:integer):string;
    class function IsLastBottle(const AIndex:integer):string;
  public
    class function Recite(const startBottles: integer; const takeDown: integer):string;
  end;

implementation

uses
  System.SysUtils;

class function Beer.NumBottles(const AIndex:integer):string;
begin
  if AIndex > 1 then
    Result := AIndex.ToString + ' bottles'
  else if AIndex = 1 then
    Result := AIndex.ToString + ' bottle'
  else if
    AIndex = 0 then Result := 'no more bottles';
end;

class function Beer.IsLastBottle(const AIndex:integer):string;
begin
  if AIndex = 1 then Result := 'it'
  else Result := 'one';
end;

class function Beer.Recite(const startBottles, takeDown: integer): string;
var
  index:integer;
  sb:TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    for index := startBottles downto (startBottles - takeDown + 1) do begin
      if (index > 0) then begin
        sb.Append(Beer.NumBottles(index));
        sb.Append(' of beer on the wall, ');
        sb.Append(Beer.NumBottles(index));
        sb.Append(' of beer.\n');
        sb.Append('Take ');
        sb.Append(Beer.IsLastBottle(index));
        sb.Append(' down and pass it around, ');
        sb.Append(Beer.NumBottles(index-1));
        sb.Append(' of beer on the wall.\n');

        if (index <> (startBottles - takeDown + 1)) then
          sb.Append('\n');
      end
      else begin
        sb.Append('No more bottles of beer on the wall, no more bottles of beer.\n');
        sb.Append('Go to the store and buy some more, 99 bottles of beer on the wall.\n');
      end;
    end;
    Result := sb.ToString;
  finally
    FreeAndNil(sb);
  end;

end;

end.