unit uHighScores;

interface

uses
  System.Generics.Defaults,
  System.Sysutils, System.Generics.Collections;

type
  IScores = interface
    ['{137C658A-9191-4EC0-B61D-6D45E6DBC248}']
    function Highest:Integer;
    function Latest:Integer;
    function Scores: TList<Integer>;
    function personalTopThree: TList<Integer>;
    function Report:string;
  end;

function NewScores(AValues:TArray<Integer>):IScores;

implementation

uses
  System.Math;

type
  TScores = class(TInterfacedObject, IScores)
  private
    FScoreList: TList<Integer>;
    FScoreSortedList: TList<Integer>;
  public
    function Highest:Integer;
    function Latest:Integer;
    function Scores: TList<Integer>;
    function personalTopThree: TList<Integer>;
    function Report:string;
    property ScoreList:TList<Integer> read FScoreList;
    property ScoreSortedList:TList<Integer> read FScoreSortedList;
    constructor Create(AScoreList:TArray<integer>);
  end;

resourcestring
  LATEST_PERSONAL_BEST = 'Your latest score was %d. That''s your personal best!';
  LATEST_NOT_PERSONAL_BEST = 'Your latest score was %d. That''s %d short of your personal best!';

function NewScores(AValues:TArray<Integer>):IScores;
begin
  Result := TScores.Create(AValues);
end;


{ TScores }

constructor TScores.Create(AScoreList: TArray<integer>);
var
  IntegerComparer: IComparer<Integer>;
begin
  inherited Create;
  IntegerComparer := TComparer<Integer>.Default;
  FScoreList := TList<integer>.Create;
  FScoreList.AddRange(AScoreList);
  FScoreSortedList := TList<integer>.Create(FScoreList);
  FScoreSortedList.Sort(IntegerComparer);
end;

function TScores.Highest: Integer;
begin
  Result := FScoreSortedList.Last;
end;

function TScores.Latest: Integer;
begin
  Result := FScoreList.Last;
end;

function TScores.personalTopThree: TList<Integer>;
var
  i:Integer;
begin
  Result := TList<Integer>.Create();
  Result.AddRange(FScoreSortedList);
  Result.Reverse;
  Result.Count := Min(3, Result.Count);
  Result.TrimExcess;
end;

function TScores.Report: string;
begin
  Result := string.Empty;

  if Latest = Highest then
    Result := Format(LATEST_PERSONAL_BEST, [Latest])
  else
    Result := Format(LATEST_NOT_PERSONAL_BEST, [Latest, (Highest-Latest)]);
end;

function TScores.Scores: TList<Integer>;
begin
  Result := FScoreList;
end;

end.