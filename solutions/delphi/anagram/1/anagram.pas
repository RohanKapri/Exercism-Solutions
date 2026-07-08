unit uAnagram;

interface

type
  TAnagram = class
    FWord:string;
    function IsAnagram(const AWord, AAnagram:string):Boolean;
  public
    function findAnagram(ACandidates:TArray<string>):TArray<string>;
    constructor Create(const AValue:string);
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections;

{ TAnagram }

constructor TAnagram.Create(const AValue: string);
begin
  inherited Create;
  FWord := AValue;
end;

function TAnagram.findAnagram(ACandidates: TArray<string>):TArray<string>;
var
  i: Integer;
  l:TList<string>;
begin
  Result := [];
  l := TList<string>.Create;
  try
    for i := Low(ACandidates) to High(ACandidates) do begin
      if IsAnagram(FWord, ACandidates[i]) then begin

        if not l.Contains(LowerCase(ACandidates[i])) then     // for detect duplicates Candidates
          l.Add(LowerCase(ACandidates[i]))
        else begin
          l.Clear;
          Break;
        end;

      end;
    end;
    Result := l.ToArray;
  finally
    FreeAndNil(l);
  end;
end;

function TAnagram.IsAnagram(const AWord, AAnagram: string): Boolean;
var
  res:string;
  i:Integer;
begin
  res := AWord;
  for i := Low(AWord) to High(AWord) do
    res := StringReplace(res, AAnagram[i], string.Empty, [rfIgnoreCase]);
  Result := (res = string.Empty) and (Length(AWord) = Length(AAnagram));
end;

end.