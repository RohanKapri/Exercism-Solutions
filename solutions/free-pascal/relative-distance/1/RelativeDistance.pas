unit RelativeDistance;

{$mode ObjFPC}{$H+}

{$WARN 4046 OFF}
{$WARN 5024 OFF}
{$WARN 5062 OFF}
{$WARN 5071 OFF}
{$WARN 6058 OFF}

interface

uses SysUtils, Generics.Collections;

type
  TStrArray   = Array of String;
  TFamilyTree = specialize TDictionary<String, TStrArray>;
  TFamilyPair = specialize TPair<String, TStrArray>;

function degreeOfSeparation(const familyTree : TFamilyTree;
  const personA, personB : String) : integer;

implementation

function degreeOfSeparation(const familyTree : TFamilyTree;
  const personA, personB : String) : integer;
var
  adjacent : TFamilyTree;

  procedure link(first, second : String);
  var
    neighbours: TStrArray = ();
    entry : String;
  begin
    if adjacent.ContainsKey(first) then
      neighbours := adjacent[first];
   
    for entry in neighbours do
      if entry = second then
        Exit();

    Insert(second, neighbours, Length(neighbours));
    adjacent.AddOrSetValue(first, neighbours);
  end;

  procedure readFamilyTree;
  var
    pair: TFamilyPair;
    i, j: Integer;
  begin
    for pair in familyTree do
    begin
      for i := Low(pair.Value) to High(pair.Value) do
      begin
        link(pair.key, pair.Value[i]);
        link(pair.Value[i], pair.key);

        for j := i + 1 to High(pair.Value) do
        begin
          link(pair.Value[i], pair.Value[j]);
          link(pair.Value[j], pair.Value[i]);
        end;
      end;
    end;
  end;

  function search : integer;
  const
    EMPTY : TStrArray = ();
  var
    seen : TFamilyTree;
    current : TStrArray = ();
    next : TStrArray = ();
    personC : String;
    personD : String;
  begin
    result := 0;
    if personA = personB then
      Exit();

    if not adjacent.ContainsKey(personA) then
      Exit(-1);

    seen := TFamilyTree.Create;
    try
      Insert(personA, next, Length(next));
      seen.Add(personA, EMPTY);
      repeat
        current := next;
        SetLength(next, 0);
        Inc(result);
        for personC in current do
          for personD in adjacent[personC] do
            if not seen.ContainsKey(personD) then
              begin
                if personD = personB then
                  Exit();

                Insert(personD, next, Length(next));
                seen.Add(personD, EMPTY);
              end;

      until Length(next) = 0;
      result := -1;
    finally
      seen.Free;
    end;
  end;

begin
  adjacent := TFamilyTree.Create;
  try
    readFamilyTree;
    result := search;
  finally
    adjacent.Free;
  end;
end;

end.