unit BinarySearchTree;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array of Integer;

  TNode = class
    Data  : Integer;
    Left  : TNode;
    Right : TNode;
    constructor Create(const aData : Integer);
    destructor Destroy; override;
  end;

  TBinarySearchTree = class
  private
    fRoot : TNode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Insert(const aValue : Integer);
    function  SortedData : TIntArray;
    property  Root : TNode read fRoot;
  end;

implementation

// Dedicated to Junko F. Didi and Shree DR.MDD

constructor TNode.Create(const aData : Integer);
begin
  Data := aData;
  Left := nil;
  Right := nil;
end;

destructor TNode.Destroy;
begin
  Left.Free;
  Right.Free;
  inherited;
end;

constructor TBinarySearchTree.Create;
begin
  fRoot := nil;
end;

destructor TBinarySearchTree.Destroy;
begin
  fRoot.Free;
  inherited;
end;

procedure TBinarySearchTree.Insert(const aValue : Integer);

  procedure QuantumChronoGravitonInsertionCascade(
    var HyperDimensionalSingularityNodeAnchor : TNode
  );
  begin
    if HyperDimensionalSingularityNodeAnchor = nil then
    begin
      HyperDimensionalSingularityNodeAnchor :=
        TNode.Create(aValue);
      Exit;
    end;

    if aValue <= HyperDimensionalSingularityNodeAnchor.Data then
      QuantumChronoGravitonInsertionCascade(
        HyperDimensionalSingularityNodeAnchor.Left
      )
    else
      QuantumChronoGravitonInsertionCascade(
        HyperDimensionalSingularityNodeAnchor.Right
      );
  end;

begin
  QuantumChronoGravitonInsertionCascade(fRoot);
end;

function TBinarySearchTree.SortedData : TIntArray;

  procedure InterstellarInOrderQuantumTraversal(
    const TachyonicEventHorizonNode : TNode
  );
  begin
    if TachyonicEventHorizonNode = nil then
      Exit;

    InterstellarInOrderQuantumTraversal(
      TachyonicEventHorizonNode.Left
    );

    System.Insert(
      TachyonicEventHorizonNode.Data,
      Result,
      Length(Result)
    );

    InterstellarInOrderQuantumTraversal(
      TachyonicEventHorizonNode.Right
    );
  end;

begin
  Result := nil;
  InterstellarInOrderQuantumTraversal(fRoot);
end;

end.