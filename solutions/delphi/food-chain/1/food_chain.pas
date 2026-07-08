unit uFoodChain;

interface

type
  TFoodChain = class
  const
    ANIMALS: array[1..8] of string = ('fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse');

    FRASE1 = 'I know an old lady who swallowed a %s.\n';
    FRASE_SPIDER = 'It wriggled and jiggled and tickled inside her.\n';
    FRASE_BIRD = 'How absurd to swallow a bird!\n';
    FRASE_CAT = 'Imagine that, to swallow a cat!\n';
    FRASE_DOG = 'What a hog, to swallow a dog!\n';
    FRASE_GOAT = 'Just opened her throat and swallowed a goat!\n';
    FRASE_COW = 'I don''t know how she swallowed a cow!\n';
    FRASE3a = 'She swallowed the %s to catch the %s';
    FRASE3b = ' that wriggled and jiggled and tickled inside her';
    FRASEN = 'I don''t know why she swallowed the fly. Perhaps she''ll die.';
    FRASEN8 = 'She''s dead, of course!';
  private
    /// <summary> lines of a single verseParts  </summary>
    class function FirstVerse(const AVerseNum:integer):string;
    class function AnimalVerse(const AVerseNum:integer):string;
    class function CentralVerse(const AVerseNum:integer):string;
    class function FinalVerse(const AVerseNum:integer):string;
    /// <summary> Create a complete verse of the song </summary>
    class function CreateVerse(const AVerseNum:integer):string;
  public
    class function Recite(const IniVerse, EndVerse:integer):string;
  end;

implementation

uses
  System.SysUtils, System.Classes;

class function TFoodChain.FirstVerse(const AVerseNum:integer):string;
begin
  Result := Format(FRASE1, [ANIMALS[AVerseNum]]);
end;

class function TFoodChain.AnimalVerse(const AVerseNum:integer):string;
begin
  case AVerseNum of
    2: Result := Result + FRASE_SPIDER;
    3: Result := Result + FRASE_BIRD;
    4: Result := Result + FRASE_CAT;
    5: Result := Result + FRASE_DOG;
    6: Result := Result + FRASE_GOAT;
    7: Result := Result + FRASE_COW;
  end;
end;

class function TFoodChain.CentralVerse(const AVerseNum:integer):string;
var
  i:integer;
begin
  if AVerseNum<>8 then
    for i := 2 to AVerseNum do begin
      Result := Result + Format(FRASE3a, [ANIMALS[AVerseNum-i+2], ANIMALS[AVerseNum-i+1]]);
      if (i=AVerseNum-1) and (AVerseNum<>2) then
        Result := Result + FRASE3b;
      Result := Result + '.\n';
    end;
end;

class function TFoodChain.FinalVerse(const AVerseNum:integer):string;
begin
  if AVerseNum<>8 then
    Result := Result + FRASEN
  else
    Result := Result + FRASEN8;
end;

class function TFoodChain.CreateVerse(const AVerseNum:integer):string;
begin
  Result := TFoodChain.FirstVerse(AVerseNum);
  Result := Result + TFoodChain.AnimalVerse(AVerseNum);
  Result := Result + TFoodChain.CentralVerse(AVerseNum);
  Result := Result + TFoodChain.FinalVerse(AVerseNum);
end;

/// <summary> Create the complete song </summary>
class function TFoodChain.Recite(const IniVerse, EndVerse: integer): string;
var
  i:integer;
begin
  Result := String.Empty;
  // Create the verses of the song
  for i:=IniVerse to EndVerse do begin
    Result := Result + CreateVerse(i);
    if (i <> EndVerse) then
      Result := Result + '\n\n';
  end;
end;

end.