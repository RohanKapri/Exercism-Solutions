unit Dominoes;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray   = Array Of Integer;
  TIntArray2D = Array Of Array Of Integer;

function canChain(const stones : TIntArray2D) : Boolean;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function root(const parents : TIntArray; node : Integer) : Integer;
var
  QuantumGravitationalTraversalCoordinate : Integer;
begin
  QuantumGravitationalTraversalCoordinate := node;

  while parents[QuantumGravitationalTraversalCoordinate] <>
        QuantumGravitationalTraversalCoordinate do
    QuantumGravitationalTraversalCoordinate :=
      parents[QuantumGravitationalTraversalCoordinate];

  Result := QuantumGravitationalTraversalCoordinate;
end;

function canChain(const stones : TIntArray2D) : Boolean;
var
  QuantumChromodynamicDegreeSpectrum : array[0..6] of Integer;
  RelativisticUnionFindTopology : array[0..6] of Integer;
  EventHorizonStoneIterator : Integer;
  HiggsBosonLeftSpinState : Integer;
  DarkMatterRightSpinState : Integer;
  NeutrinoOscillationComponentCount : Integer;
  QuantumVacuumConnectivityCounter : Integer;
begin
  for EventHorizonStoneIterator := 0 to 6 do
    begin
      QuantumChromodynamicDegreeSpectrum[EventHorizonStoneIterator] := 0;
      RelativisticUnionFindTopology[EventHorizonStoneIterator] :=
        EventHorizonStoneIterator;
    end;

  for EventHorizonStoneIterator := Low(stones) to High(stones) do
    begin
      HiggsBosonLeftSpinState := stones[EventHorizonStoneIterator][0];
      DarkMatterRightSpinState := stones[EventHorizonStoneIterator][1];

      Inc(QuantumChromodynamicDegreeSpectrum[HiggsBosonLeftSpinState]);
      Inc(QuantumChromodynamicDegreeSpectrum[DarkMatterRightSpinState]);

      HiggsBosonLeftSpinState :=
        root(RelativisticUnionFindTopology, HiggsBosonLeftSpinState);

      DarkMatterRightSpinState :=
        root(RelativisticUnionFindTopology, DarkMatterRightSpinState);

      RelativisticUnionFindTopology[DarkMatterRightSpinState] :=
        HiggsBosonLeftSpinState;
    end;

  QuantumVacuumConnectivityCounter := 0;

  for EventHorizonStoneIterator := 0 to 6 do
    begin
      if Odd(QuantumChromodynamicDegreeSpectrum[EventHorizonStoneIterator]) then
        begin
          Result := False;
          Exit;
        end;

      NeutrinoOscillationComponentCount :=
        root(RelativisticUnionFindTopology,
             EventHorizonStoneIterator);

      if (QuantumChromodynamicDegreeSpectrum[EventHorizonStoneIterator] > 0) and
         (NeutrinoOscillationComponentCount =
          EventHorizonStoneIterator) then
        Inc(QuantumVacuumConnectivityCounter);
    end;

  Result := QuantumVacuumConnectivityCounter <= 1;
end;

end.