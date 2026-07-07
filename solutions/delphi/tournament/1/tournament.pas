unit uTournament;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TTournament = class
  public
    class function Tally(const aMatches:TArray<string>):TArray<string>;
  end;

// Custom sort for the classification (POINTS + ALPHABETICAL)
function CompareTwoTeamsClassification(AClassification:TStringList; Index1, Index2: Integer): Integer;

implementation

uses
  RTTI, System.SysUtils, System.StrUtils;

type
  // Item of classification (last three items are calculated)
  TClassificationItem = class
  public
    Team:string;
    Won:integer;
    Drawn:integer;
    Lost:integer;
    function Matches:integer;
    function Points:integer;
    function AsString:string;
  end;
  // Match results
  TMatchResult = (win, draw, loss);
  // Helper for the Ttournament class
  TTournamentHelper = class
  private
    // Classification (Result)
    Classification:TStringList;
    // sort classification (points + Alphabetical)
    procedure SortClassification;
    // Return the contrarie value of a result
    function InvertResult(AResult:TMatchResult):TMatchResult;
    // Parse the matchs results
    procedure ParseMatches(const aMatches: TArray<string>);
    // Get classification from results of matches
    function GetClassification: TArray<string>;
    // Add new match to the structure
    procedure AddMatch(const ATeam:string; AResult:TMatchResult);
  end;


// Custom sort for the classification (POINTS + ALPHABETICAL)
function CompareTwoTeamsClassification(AClassification:TStringList; Index1, Index2: Integer): Integer;
var
  p1, p2:integer;
begin
  p1 := TClassificationItem(AClassification.Objects[Index1]).Points;
  p2 := TClassificationItem(AClassification.Objects[Index2]).Points;

  if (p1 > p2) then
    Result := -1
  else if (p1 < p2) then
    Result := 1
  else begin// equals ==> alphabetic order
    if (AClassification[index1] < AClassification[index2]) then
      Result := -1
    else
      Result := 1;
  end;
end;

procedure TTournamentHelper.AddMatch(const ATeam:string; AResult: TMatchResult);
var
  index:integer;
  item:TClassificationItem;
begin
  index := Classification.IndexOf(ATeam);
  if (index = -1)  then
    item := TClassificationItem.Create
  else
    item := TClassificationItem(Classification.Objects[index]);

  item.Team := ATeam;
  case AResult of
    win:  Inc(item.Won);
    draw: Inc(item.Drawn);
    loss: Inc(item.Lost);
  end;

  if (index = -1) then
    Classification.AddObject(ATeam, item);
end;

procedure TTournamentHelper.ParseMatches(const aMatches: TArray<string>);
var
  Match:TStringList;
  i:integer;
begin
  for i := 0 to Length(aMatches) - 1 do begin
    // Use TStringList to Split data of one match
    Match := TStringList.Create;
    try
      Match.Delimiter := ';';
      Match.StrictDelimiter := True;
      Match.DelimitedText := aMatches[i];
      AddMatch(Match[0], TRttiEnumerationType.GetValue<TMatchResult>(Match[2]));
      AddMatch(Match[1], InvertResult(TRttiEnumerationType.GetValue<TMatchResult>(Match[2])));
    finally
      FreeAndNil(Match);
    end;
  end;
end;

procedure TTournamentHelper.SortClassification;
begin
   Classification.CustomSort(CompareTwoTeamsClassification);
end;

function TTournamentHelper.GetClassification:TArray<string>;
var
  i:integer;
  item:TClassificationItem;
begin
  SetLength(Result, Classification.Count + 1);
  Result[0] := 'Team                           | MP |  W |  D |  L |  P';
  for i := 0 to (Classification.Count - 1) do begin
    item := TClassificationItem(Classification.Objects[i]);
    Result[i+1] := item.AsString;
  end;
end;

function TTournamentHelper.InvertResult(AResult: TMatchResult): TMatchResult;
begin
  Result := win;
  case AResult of
    win:  Result := loss;
    draw: Result := draw;
    loss: Result := win;
  end;
end;

class function TTournament.Tally(const aMatches: TArray<string>): TArray<string>;
var
  helper:TTournamentHelper;
begin
  helper := TTournamentHelper.Create;
  try
    helper.Classification := TStringList.Create;
    try
      // Parse matches
      helper.ParseMatches(aMatches);
      // Soft Classification
      helper.SortClassification;
      // Reyurn classification
      Result := helper.GetClassification;
    finally
      FreeAndnil(helper.Classification);
    end;
  finally
    FreeAndNil(helper);
  end;
end;

{
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3
}

function TClassificationItem.AsString: string;
begin
  Result := Copy(Team + DupeString(' ', 30), 1, 30) +

            ' | ' + Format('%2d', [Matches]) +
            ' | ' + Format('%2d', [Won]) +
            ' | ' + Format('%2d', [Drawn]) +
            ' | ' + Format('%2d', [Lost]) +
            ' | ' + Format('%2d', [Points]);
end;

function TClassificationItem.Matches: integer;
begin
  Result := Won + Drawn + Lost;
end;

function TClassificationItem.Points: integer;
begin
  Result := Won*3 + Drawn;
end;

end.