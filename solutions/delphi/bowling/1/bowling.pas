unit uBowling;

interface
uses System.Generics.Collections;
type

  IBowlingGame = interface
    procedure Roll(pins: integer);
    function Score:integer;
  end;

  TBowlingFrame = class
    FrameIndex:integer;
    FirstBall:integer;
    SecondBall:integer;
    IsStrike:boolean;
    IsSpare:boolean;
    FMinIndex:integer;
    FMaxIndex:integer;
  public
    constructor Create(Index:integer);
  end;

  TBowlingGame = class(TInterfacedObject, IBowlingGame)
  private
    FScore:integer;
    FRoll:integer;
    FPins: TList<integer>;
    FFrames: TList<TBowlingFrame>;
    FIndex:integer;
  public
    procedure Roll(pins: integer);
    function Score:integer;
    constructor Create;
  end;

  function NewBowlingGame:IBowLingGame;

implementation

function NewBowlingGame:IBowlingGame;
begin
  result := TBowlingGame.Create;
end;

constructor TBowlingFrame.Create(Index:integer);
begin
  FrameIndex := Index;
  FirstBall := 0;
  SecondBall := 0;
  IsStrike := False;
  IsSpare := False;
  FMinIndex := Index;
  FMaxIndex := Index;
end;

constructor TBowlingGame.Create;
begin
  FScore := 0;
  FIndex := 0;
  FPins := TList<integer>.Create;
  FFrames := TList<TBowlingFrame>.Create;
end;

procedure TBowlingGame.Roll(pins: integer);
begin
  FPins.Add(pins);
  inc(FIndex);
  if (pins=10) then
    inc(FIndex);
end;

function TBowlingGame.Score: integer;
var i, pins, iFrame, iFrames, gameLen,CurrScore: integer;
  aBowlingFrame, CurrFrame :TBowlingFrame;
  FNew:boolean;
begin
  gameLen := FIndex;
  if (gameLen < 20) then
    result := -1
  else
  begin
    FRoll := 0;
    iFrame := 0;
    aBowlingFrame := nil;
    FNew := true;
    for i := 0 to FPins.Count-1 do
    begin
      pins := FPins[i];
      if FNew then
      begin
        aBowlingFrame := TBowlingFrame.Create(iFrame);
        aBowlingFrame.FirstBall := pins;
        aBowlingFrame.IsStrike := (pins = 10);
        FNew := aBowlingFrame.IsStrike;
        if (aBowlingFrame.IsStrike) then
        begin
          FFrames.Add(aBowlingFrame);
          aBowlingFrame.FMaxIndex := aBowlingFrame.FMinIndex + 2;
          inc(iFrame);
        end
      end
      else
      begin
        aBowlingFrame.SecondBall := pins;
        if (not (aBowlingFrame.IsStrike)) then
        begin
          aBowlingFrame.IsSpare:= (aBowlingFrame.FirstBall + pins = 10);
          aBowlingFrame.FMaxIndex := aBowlingFrame.FMinIndex + 2;
        end;
        FFrames.Add(aBowlingFrame);
        FNew := true;
        inc(iFrame);
      end;
    end;


    for CurrFrame in FFrames do
    begin
      CurrScore := (CurrFrame.FirstBall + CurrFrame.SecondBall);
      if ((CurrScore >= 0) and (CurrScore <=10)) then
      begin
        FScore := FScore + CurrScore;
        if ((CurrFrame.IsStrike) and (CurrFrame.FrameIndex<iFrame) and (CurrFrame.FMaxIndex < iFrame)) then
        begin
            FScore := FScore + FPins[CurrFrame.FMaxIndex-1]+ FPins[CurrFrame.FMaxIndex];
        end;

        if ((CurrFrame.IsSpare) and (CurrFrame.FrameIndex<iFrame) and (CurrFrame.FMaxIndex < iFrame)) then
          FScore := FScore + (FPins[CurrFrame.FMaxIndex]);
      end
      else
      begin
        FScore := -1;
        break;
      end;
    end;
    result := FScore;
  end;

end;

end.