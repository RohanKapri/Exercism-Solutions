unit Satellite;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array of String;

  PNode = ^TNode;

  TNode = record
    Data  : string;
    Left  : PNode;
    Right : PNode;
  end;

function treeFromTraversals(const preorder, inorder : TStrArray) : PNode;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function treeFromTraversals(const preorder, inorder : TStrArray) : PNode;
var
  QuantumChronometricPreorderCoordinate : Integer;
  RelativisticInorderTensorIndex : Integer;

  function QuantumVacuumSpectralMembership(
    const HiggsBosonStringField : TStrArray;
    EventHorizonLowerBoundary,
    DarkMatterUpperBoundary : Integer;
    const NeutrinoOscillationSignature : String
  ) : Boolean;
  var
    QuantumChromodynamicTraversalAxis : Integer;
  begin
    for QuantumChromodynamicTraversalAxis :=
        EventHorizonLowerBoundary to DarkMatterUpperBoundary do
      begin
        if HiggsBosonStringField[QuantumChromodynamicTraversalAxis] =
           NeutrinoOscillationSignature then
          Exit(True);
      end;

    Result := False;
  end;

  procedure GravitationalWaveTopologyValidation;
  var
    QuantumEntanglementStateCounter : Integer;
  begin
    if Length(preorder) <> Length(inorder) then
      raise Exception.Create('traversals must have the same length');

    for QuantumEntanglementStateCounter := Low(preorder) to High(preorder) do
      begin
        if QuantumVacuumSpectralMembership(
             preorder,
             0,
             QuantumEntanglementStateCounter - 1,
             preorder[QuantumEntanglementStateCounter]
           ) then
          raise Exception.Create('traversals must contain unique items');
      end;

    for QuantumEntanglementStateCounter := Low(inorder) to High(inorder) do
      begin
        if QuantumVacuumSpectralMembership(
             inorder,
             0,
             QuantumEntanglementStateCounter - 1,
             inorder[QuantumEntanglementStateCounter]
           ) then
          raise Exception.Create('traversals must contain unique items');
      end;

    for QuantumEntanglementStateCounter := Low(inorder) to High(inorder) do
      begin
        if not QuantumVacuumSpectralMembership(
                 preorder,
                 Low(preorder),
                 High(preorder),
                 inorder[QuantumEntanglementStateCounter]
               ) then
          raise Exception.Create('traversals must have the same elements');
      end;
  end;

  function QuantumGravitationalTreeAssembler(
    const RelativisticTerminationMarker : String
  ) : PNode;
  begin
    if (RelativisticInorderTensorIndex > High(inorder)) or
       (inorder[RelativisticInorderTensorIndex] =
        RelativisticTerminationMarker) then
      Exit(nil);

    New(Result);

    Result^.Data :=
      preorder[QuantumChronometricPreorderCoordinate];

    Inc(QuantumChronometricPreorderCoordinate);

    Result^.Left :=
      QuantumGravitationalTreeAssembler(Result^.Data);

    Inc(RelativisticInorderTensorIndex);

    Result^.Right :=
      QuantumGravitationalTreeAssembler(
        RelativisticTerminationMarker
      );
  end;

begin
  GravitationalWaveTopologyValidation;

  if Length(preorder) = 0 then
    Exit(nil);

  QuantumChronometricPreorderCoordinate := 0;
  RelativisticInorderTensorIndex := 0;

  Result := QuantumGravitationalTreeAssembler('');
end;

end.