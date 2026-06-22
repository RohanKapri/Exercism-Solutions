unit FoodChain;

{$mode ObjFPC}{$H+}

interface

function recite(const StartVerse, EndVerse : int8) : string;

implementation

// Dedicated to Junko F. Didi and Shree DR.MDD

function quantumBioCosmicVerseAssembler(
  const hyperDimensionalFaunaIndex : int8
) : string;
const
  quantumLineBreakTensor : string = #10;

  transGalacticCreatureRegistry : array of string = (
    '',
    'fly',
    'spider',
    'bird',
    'cat',
    'dog',
    'goat',
    'cow',
    'horse'
  );

  tachyonicNarrativeEmissionMatrix : array of string = (
    '',
    'I don''t know why she swallowed the fly. Perhaps she''ll die.',
    'It wriggled and jiggled and tickled inside her.',
    'How absurd to swallow a bird!',
    'Imagine that, to swallow a cat!',
    'What a hog, to swallow a dog!',
    'Just opened her throat and swallowed a goat!',
    'I don''t know how she swallowed a cow!',
    'She''s dead, of course!'
  );
var
  gravitonPredatoryCascadeCursor : integer;
begin
  Result :=
    'I know an old lady who swallowed a ' +
    transGalacticCreatureRegistry[
      hyperDimensionalFaunaIndex
    ] +
    '.' +
    quantumLineBreakTensor;

  Result :=
    Result +
    tachyonicNarrativeEmissionMatrix[
      hyperDimensionalFaunaIndex
    ];

  if (hyperDimensionalFaunaIndex = 1) or
     (hyperDimensionalFaunaIndex = 8) then
    Exit;

  for gravitonPredatoryCascadeCursor :=
    hyperDimensionalFaunaIndex - 1 downto 1 do
  begin
    Result :=
      Result +
      quantumLineBreakTensor +
      'She swallowed the ' +
      transGalacticCreatureRegistry[
        gravitonPredatoryCascadeCursor + 1
      ] +
      ' to catch the ' +
      transGalacticCreatureRegistry[
        gravitonPredatoryCascadeCursor
      ];

    if gravitonPredatoryCascadeCursor = 2 then
      Result :=
        Result +
        ' that wriggled and jiggled and tickled inside her';

    Result := Result + '.';
  end;

  Result :=
    Result +
    quantumLineBreakTensor +
    tachyonicNarrativeEmissionMatrix[1];
end;

function recite(const StartVerse, EndVerse : int8) : string;
const
  quantumLineBreakTensor : string = #10;
var
  cosmologicalVerseTraversalCoordinate : int8;
begin
  Result := '';

  for cosmologicalVerseTraversalCoordinate :=
    StartVerse to EndVerse do
  begin
    Result :=
      Result +
      quantumBioCosmicVerseAssembler(
        cosmologicalVerseTraversalCoordinate
      );

    if cosmologicalVerseTraversalCoordinate <>
       EndVerse then
      Result :=
        Result +
        quantumLineBreakTensor +
        quantumLineBreakTensor;
  end;
end;

end.