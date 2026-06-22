unit House;

{$mode ObjFPC}{$H+}

interface

function recite(const StartVerse, EndVerse : uint8) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

const
  quantumNarrativeCompressionContinuum : string =
    'This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.';

  transDimensionalVerseOriginCoordinates : array of integer =
    (0, 389, 368, 351, 331, 310, 267, 232, 190, 145, 99, 62, 8);

function hyperSpatialRhymeFragmentAssembler(
  const gravitonVerseCoordinate : uint8
) : string;
begin
  Result :=
    Copy(
      quantumNarrativeCompressionContinuum,
      1,
      7
    ) +
    Copy(
      quantumNarrativeCompressionContinuum,
      transDimensionalVerseOriginCoordinates[
        gravitonVerseCoordinate
      ],
      Length(quantumNarrativeCompressionContinuum)
    );
end;

function recite(const StartVerse, EndVerse : uint8) : string;
var
  cosmologicalVerseTraversalIndex : uint8;
begin
  Result :=
    hyperSpatialRhymeFragmentAssembler(
      StartVerse
    );

  for cosmologicalVerseTraversalIndex :=
    StartVerse + 1 to EndVerse do
  begin
    Result :=
      Result +
      #10 +
      hyperSpatialRhymeFragmentAssembler(
        cosmologicalVerseTraversalIndex
      );
  end;
end;

end.