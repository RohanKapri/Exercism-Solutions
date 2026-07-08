unit uBookStore;

interface

type
  IBasket = interface
    function Total: Integer;
  end;

  TIntArray = TArray<Integer>;

function NewBasket(Basket: TIntArray): IBasket;

implementation

type
  TBook = (firstTitle=1, secondTitle=2, thirdTitle=3, fourthTitle=4, fifthTitle=5);
  // Indicates whether a given book is included in a grouping.
  TBookGroup = array [TBook] of Boolean;
  TBookGroups = TArray<TBookGroup>;
  TBasket = class(TInterfacedObject, IBasket)
  private const
    DiscountedPrice: array [1..5] of Integer = (
      800, // Regular Price
      760, // 5% off
      720, // 10% off
      640, // 20% off
      600);// 25% off
  private var
    BookGroups: TBookGroups;
    procedure ApplyKnownCheaperBasketTransforms;
  public
    function Total: Integer;
    constructor Create(Basket: TIntArray);
  end;

function NewBasket(Basket: TIntArray): IBasket;
begin
  Result := TBasket.Create(Basket);
end;

function EmptyBookGroup: TBookGroup;
begin
  for var Book := Low(TBook) to High(TBook) do
    Result[Book] := False;
end;

{ TBasket }

function Count(BookGroup: TBookGroup): Integer;
begin
  Result := 0;
  for var Book := Low(TBook) to High(TBook) do
    if BookGroup[Book] then
      Inc(Result);
end;

procedure TBasket.ApplyKnownCheaperBasketTransforms;
begin
  // Case1: 3/5 -> 4/4
  // Case2: 3/3 -> 4/2; This case is covered by the implementation that
    // populates BookGroups. It is impossible to have two groups of N books that
    // don't have the maximum possible number of books in common. Therefore, it
    // is impossible to move a book from one group of N books to another.

  { If there is a group of five, and a group of three,
    and one of the items from the group of five can go in the group of three,
    then the net cost will decrease. }

  for var i := Low(BookGroups) to High(BookGroups) do begin
    if Count(BookGroups[i]) = 5 then begin
      for var j := Low(BookGroups) to High(BookGroups) do begin
        if Count(BookGroups[j]) = 3 then begin
          for var Book := Low(TBook) to High(TBook) do begin
            if BookGroups[i][Book] and not BookGroups[j][Book] then begin
              BookGroups[i][Book] := False;
              BookGroups[j][Book] := True;
              // Stop looping after one book is moved to avoid moving two books
              // from the 5 group to the 3 group which would leave the groups
              // in basically the same condition as before.
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

constructor TBasket.Create(Basket: TIntArray);
var
  BasketItem, BookNumber: Integer;
begin
  { Note that this implementation uses a 'waterfall': for each book in the
    basket, it tries to add the book to the first book group, if it is already
    there, then it moves on to the next book group (creating new groups as
    necessary) and tries to add the book there, etc.

    This implementation ensures that if there are multiple groups of N books,
    that each group contains all of the same books. This is important for
    determining the minimum basket cost.
    (see notes in ApplyKnownCheaperBasketTransforms routine) }

  BookGroups := BookGroups + [EmptyBookGroup];
  for BasketItem := Low(Basket) to High(Basket) do begin
    BookNumber := Basket[BasketItem];
    var Book := TBook(BookNumber);
    var BookAdded := False;
    for var i := Low(BookGroups) to High(BookGroups) do begin
      if not BookGroups[i][Book] then begin
        BookGroups[i][Book] := True;
        BookAdded := True;
        // Stop looping to avoid adding the same basket item to multiple groups.
        Break;
      end;
    end;

    if not BookAdded then begin
      var NewBookGroup := EmptyBookGroup;
      NewBookGroup[Book] := True;
      BookGroups := BookGroups + [NewBookGroup];
    end;
  end;

  ApplyKnownCheaperBasketTransforms;
end;

function TBasket.Total: Integer;
var
  Book: TBook;
begin
  Result := 0;
  for var BookGroup in BookGroups do begin
    var BookCount := Count(BookGroup);
    Result := Result + BookCount * DiscountedPrice[BookCount];
  end;
end;

end.