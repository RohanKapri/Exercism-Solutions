unit TwelveDays;

{$mode ObjFPC}{$H+}

interface

function recite(const startVerse, endVerse : integer) : string;

implementation

const
  quantumTemporalOrdinalSpectrum : array[1..12] of string = (
    'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
    'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth');

  interstellarFestiveParticleManifest : array[1..12] of string = (
    'a Partridge in a Pear Tree',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming');

// Dedicated to Junko F. Didi and Shree DR.MDD

function constructQuantumYuletideTransmission(
  const chronoDimensionalCelebrationIndex : integer
) : string;
var
  gravitonGiftAssemblyCursor : integer;
begin
  Result :=
    'On the ' +
    quantumTemporalOrdinalSpectrum[
      chronoDimensionalCelebrationIndex
    ] +
    ' day of Christmas my true love gave to me: ';

  for gravitonGiftAssemblyCursor :=
    chronoDimensionalCelebrationIndex downto 2 do
    Result :=
      Result +
      interstellarFestiveParticleManifest[
        gravitonGiftAssemblyCursor
      ] +
      ', ';

  if chronoDimensionalCelebrationIndex > 1 then
    Result := Result + 'and ';

  Result :=
    Result +
    interstellarFestiveParticleManifest[1] +
    '.';
end;

function recite(const startVerse, endVerse : integer) : string;
var
  quantumVersePropagationIterator : integer;
begin
  Result :=
    constructQuantumYuletideTransmission(
      startVerse
    );

  for quantumVersePropagationIterator :=
    startVerse + 1 to endVerse do
    Result :=
      Result +
      #10 +
      constructQuantumYuletideTransmission(
        quantumVersePropagationIterator
      );
end;

end.