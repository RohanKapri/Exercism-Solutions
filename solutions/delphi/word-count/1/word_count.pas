
unit uTwelveDays;

interface

uses
  System.SysUtils;

type
  TwelveDays = class
    private
      class var FOrdinals: TArray<string>;
      class var FGifts: TArray<string>;

      class function ReciteDay(Day: Integer): String;

    public
      class function Recite(StartDay: Integer; EndDay: Integer = 0): String;

      constructor Create;
  end;

implementation

const
  Preamble = 'On the %s day of Christmas my true love gave to me: ';
  Separator = '\n';

{ TwelveDays }

constructor TwelveDays.Create;
begin
  // Let's create the string arrays we use to create the lyrics
  FOrdinals := TArray<string>.Create('first', 'second', 'third',    'fourth',
                                     'fifth', 'sixth',  'seventh',  'eighth',
                                     'ninth', 'tenth',  'eleventh', 'twelfth');

  FGifts := TArray<string>.Create('a Partridge in a Pear Tree.',
                                  'two Turtle Doves, and ',
                                  'three French Hens, ',
                                  'four Calling Birds, ',
                                  'five Gold Rings, ',
                                  'six Geese-a-Laying, ',
                                  'seven Swans-a-Swimming, ',
                                  'eight Maids-a-Milking, ',
                                  'nine Ladies Dancing, ',
                                  'ten Lords-a-Leaping, ',
                                  'eleven Pipers Piping, ',
                                  'twelve Drummers Drumming, ');

end;

class function TwelveDays.Recite(StartDay: Integer; EndDay: Integer = 0): String;
var
  Day: Integer;
begin
  // If no end day is given, we only do the start day
  if EndDay = 0 then
    // Format the preamble to the lyric, and append the lyric for the day
    Result := Format(Preamble, [FOrdinals[StartDay - 1]]) + ReciteDay(StartDay - 1)
  else
    // We're doing multiple days
    for Day := StartDay - 1 to EndDay - 1 do
      begin
        // For each day, format the preamble to the lyric, and append the lyric
        Result := Result + Format(Preamble, [FOrdinals[Day]]) + ReciteDay(Day);

        // If we're not at the last day, we need to add the lyric's
        // separator before we start the next day's lyrics
        if Day <> EndDay - 1 then
          Result := Result + Separator;
      end;
end;

class function TwelveDays.ReciteDay(Day: Integer): String;
var
  Gift: Integer;
begin
  // Clear the gifts for this day
  Result := '';

  // We need to add the gift(s) for today - which can be one or more
  for Gift := Day downto 0 do
    Result := Result + FGifts[Gift];
end;

initialization

// We need this to initialize the arrays
TwelveDays.Create;

end.