unit uCircularBuffer;

interface

uses
  System.Generics.Collections, System.StrUtils, System.SysUtils;

type
  EInvalidOpException = class(exception);

  ICircularBuffer<T> = interface
  ['{31315AD8-4E00-4722-BF57-F220B3F2451C}']
    procedure Write(AValue:T);
    function Read:T;
    procedure Clear;
    procedure OverWrite(AValue:T);
  end;

  TCircularBuffer<T> = class(TInterfacedObject, ICircularBuffer<T>)
  private
    queue:TQueue<T>;
  public
    procedure Write(AValue:T);
    function Read:T;
    procedure Clear;
    procedure OverWrite(AValue:T);
    constructor Create(const ALen:integer);
    destructor Destroy;
  end;

implementation


{ TCircularBuffer<T> }

procedure TCircularBuffer<T>.Clear;
begin
  queue.Clear;
end;

constructor TCircularBuffer<T>.Create(const ALen: integer);
begin
  queue := TQueue<T>.Create;
  queue.Capacity := ALen;
end;

destructor TCircularBuffer<T>.Destroy;
begin
  FreeAndNil(queue);
end;

procedure TCircularBuffer<T>.OverWrite(AValue: T);
begin
  if (queue.Count = queue.Capacity) then
    queue.Dequeue;
  queue.Enqueue(AValue);
end;

function TCircularBuffer<T>.Read: T;
begin
  if queue.Count = 0 then
    raise EInvalidOpException.Create('empty buffer');
  Result := queue.Dequeue;
end;

procedure TCircularBuffer<T>.Write(AValue: T);
begin
  if (queue.Count = queue.Capacity) then
    raise EInvalidOpException.Create('full buffer');
  queue.Enqueue(AValue);
end;

end.