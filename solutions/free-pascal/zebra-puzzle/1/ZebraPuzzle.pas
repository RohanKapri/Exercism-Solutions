unit ZebraPuzzle;

{$mode ObjFPC}{$H+}

interface

type
  Nationality = (Englishman, Japanese, Norwegian, Spaniard, Ukrainian);
  Color = (blue, green, ivory, red, yellow);
  Drink = (coffee, milk, orangeJuice, tea, water);
  Hobby = (reading, painting, football, dancing, chess);
  Pet = (dog, fox, horse, snails, zebra);
  ZebraQuestion = (waterDrinker, zebraOwner);
  TIntArray = Array Of Integer;

function drinksWater : Nationality;
function ownsZebra : Nationality;

implementation

uses SysUtils;

function nextPermutation(var a: TIntArray): Boolean;
var
  j : Integer;
  k : Integer;
  l : Integer;
  aj : Integer;
  ak : Integer;
  al : Integer;
  n : Integer;
begin
  n := Length(a);

  // Step 1. find j
  j := n - 2;
  while a[j] >= a[j + 1] do
  begin
    if j = 0 then
      exit(false);

    dec(j);
  end;

  // Step 2. increase a[j]
  l := n - 1;
  while a[j] >= a[l] do
    dec(l);

  aj := a[j];
  al := a[l];
  a[j] := al;
  a[l] := aj;

  // Step 3. reverse a[j+1] ... a[n-1]
  k := j + 1;
  l := n - 1;
  while k < l do
    begin
      ak := a[k];
      al := a[l];
      a[k] := al;
      a[l] := ak;

      inc(k);
      dec(l);
    end;

  result := true;
end;

function adjacent(i, j: Integer): Boolean;
begin
  result := (i + 1 = j) or (j + 1 = i);
end;

function answer(question : ZebraQuestion): Nationality;
const
  initial: TIntArray = (1, 2, 3, 4, 5);
var
  nationalities : TIntArray;
  colors : TIntArray;
  drinks : TIntArray;
  hobbies : TIntArray;
  pets : TIntArray;

  englishman_ : Integer;
  japanese_ : Integer;
  norwegian_ : Integer;
  spaniard_ : Integer;
  ukrainian_ : Integer;

  blue_ : Integer;
  green_ : Integer;
  ivory_ : Integer;
  red_ : Integer;
  yellow_ : Integer;

  coffee_ : Integer;
  milk_ : Integer;
  orangeJuice_ : Integer;
  tea_ : Integer;
  water_ : Integer;

  reading_ : Integer;
  painting_ : Integer;
  football_ : Integer;
  dancing_ : Integer;
  chess_ : Integer;

  dog_ : Integer;
  fox_ : Integer;
  horse_ : Integer;
  snails_ : Integer;
  zebra_ : Integer;

  required : Integer;

begin
  result := default(Nationality);

  nationalities := Copy(initial, 0);
  repeat
    englishman_ := nationalities[Ord(Englishman)];
    japanese_ := nationalities[Ord(Japanese)];
    norwegian_ := nationalities[Ord(Norwegian)];
    spaniard_ := nationalities[Ord(Spaniard)];
    ukrainian_ := nationalities[Ord(Ukrainian)];

    // 10. The Norwegian lives in the first house.
    if norwegian_ = 1 then
      begin
        colors := Copy(initial, 0);
        repeat
          blue_ := colors[Ord(blue)];
          green_ := colors[Ord(green)];
          ivory_ := colors[Ord(ivory)];
          red_ := colors[Ord(red)];
          yellow_ := colors[Ord(yellow)];

          // 2. The Englishman lives in the red house.
          // 6. The green house is immediately to the right of the ivory house.
          // 15. The Norwegian lives next to the blue house.
          if (englishman_ = red_) and (green_ = ivory_ + 1) and adjacent(norwegian_, blue_) then
            begin
              drinks := Copy(initial, 0);
              repeat
                coffee_ := drinks[Ord(coffee)];
                milk_ := drinks[Ord(milk)];
                orangeJuice_ := drinks[Ord(orangeJuice)];
                tea_ := drinks[Ord(tea)];
                water_ := drinks[Ord(water)];

                // 4. Coffee is drunk in the green house.
                // 5. The Ukrainian drinks tea.
                // 9. Milk is drunk in the middle house.
                if (coffee_ = green_) and (ukrainian_ = tea_) and (milk_ = 3) then
                  begin
                    hobbies := Copy(initial, 0);
                    repeat
                      reading_ := hobbies[Ord(reading)];
                      painting_ := hobbies[Ord(painting)];
                      football_ := hobbies[Ord(football)];
                      dancing_ := hobbies[Ord(dancing)];
                      chess_ := hobbies[Ord(chess)];

                      // 8. The person in the yellow house is a painter.
                      // 13. The person who plays football drinks orange juice.
                      // 14. The Japanese person plays chess.
                      if (painting_ = yellow_) and (football_ = orangeJuice_) and (japanese_ = chess_) then
                        begin
                          pets := Copy(initial, 0);
                          repeat
                            dog_ := pets[Ord(dog)];
                            fox_ := pets[Ord(fox)];
                            horse_ := pets[Ord(horse)];
                            snails_ := pets[Ord(snails)];
                            zebra_ := pets[Ord(zebra)];

                            // 3. The Spaniard owns the dog.
                            // 7. The snail owner likes to go dancing.
                            // 11. The person who enjoys reading lives in the house next to the person with the fox.
                            // 12. The painter's house is next to the house with the horse.
                            if (spaniard_ = dog_) and (dancing_ = snails_) and adjacent(reading_, fox_) and adjacent(painting_, horse_) then
                              begin
                                if question = waterDrinker then
                                  required := water_
                                else
                                  required := zebra_;

                                if required = englishman_ then
                                  result := Englishman;
                                if required = japanese_ then
                                  result := Japanese;
                                if required = norwegian_ then
                                  result := Norwegian;
                                if required = spaniard_ then
                                  result := Spaniard;
                                if required = ukrainian_ then
                                  result := Ukrainian;

                                exit();
                              end;
                          until not nextPermutation(pets);
                        end;
                    until not nextPermutation(hobbies);
                  end;
              until not nextPermutation(drinks);
            end;
        until not nextPermutation(colors);
      end;
  until not nextPermutation(nationalities);
  raise Exception.Create('no solution');
end;

function drinksWater : Nationality;
begin
  result := answer(waterDrinker);
end;

function ownsZebra : Nationality;
begin
  result := answer(zebraOwner);
end;

end.