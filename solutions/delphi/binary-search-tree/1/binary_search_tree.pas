unit uBinarySearchTree;

interface

type
  TDatum = string;
  TData = TArray<TDatum>;
  TNode = class
  public
    Data: TDatum;
    Right, Left: TNode;
  private
    procedure AddDatum(Datum: TDatum);
    procedure GetData(var SortedData: TData);
  end;

  TBinarySearchTree = class(TNode)
  public
    function SortedData: TData;
    constructor Create(Data: TData);
  end;

implementation

uses
  SysUtils;

{ TBinarySearchTree }

constructor TBinarySearchTree.Create(Data: TData);
var
  Datum: TDatum;
begin
  for Datum in Data do
    Self.AddDatum(Datum);
end;

function TBinarySearchTree.SortedData: TData;
begin
  Self.GetData(Result);
end;

{ TNode }

procedure TNode.AddDatum(Datum: TDatum);

  procedure CreateIfNil(var Node: TNode);
  begin
    if not Assigned(Node) then
      Node := TNode.Create;
  end;

begin
  if Data.IsEmpty then begin
    Data := Datum;
  end else if Data < Datum then begin
    CreateIfNil(Right);
    Right.AddDatum(Datum);
  end else if Data >= Datum then begin
    CreateIfNil(Left);
    Left.AddDatum(Datum);
  end;
end;

procedure TNode.GetData(var SortedData: TData);

  procedure GetDataIfAssigned(Node: TNode; var SortedData: TData);
  begin
    if Assigned(Node) then
      Node.GetData(SortedData);
  end;

begin
  GetDataIfAssigned(Left, SortedData);
  SortedData := SortedData + [Data];
  GetDataIfAssigned(Right, SortedData);;
end;

end.