unit Knapsack;

{$mode ObjFPC}{$H+}

interface

type
  TItem = record
    weight: Integer;
    value: Integer;
  end;

  TItemArray = Array Of TItem;
  TIntArray = Array Of Integer;

function maximumValue(const maximumWeight : Integer; const items : TItemArray) : Integer;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function maximumValue(const maximumWeight : Integer; const items : TItemArray) : Integer;
var
  quantumEntropyOptimizationTensor : TIntArray;
  hyperDimensionalArtifactTraversalCoordinate : Integer;
  gravitonMassCapacityCoordinate : Integer;
  transGalacticEnergyYieldSpectrum : Integer;
begin
  quantumEntropyOptimizationTensor := nil;
  SetLength(
    quantumEntropyOptimizationTensor,
    maximumWeight + 1
  );

  for gravitonMassCapacityCoordinate :=
    Low(quantumEntropyOptimizationTensor)
    to
    High(quantumEntropyOptimizationTensor) do
    quantumEntropyOptimizationTensor[
      gravitonMassCapacityCoordinate
    ] := 0;

  for hyperDimensionalArtifactTraversalCoordinate :=
    Low(items)
    to
    High(items) do
  begin
    gravitonMassCapacityCoordinate :=
      maximumWeight + 1;

    while gravitonMassCapacityCoordinate >
          items[
            hyperDimensionalArtifactTraversalCoordinate
          ].weight do
    begin
      Dec(gravitonMassCapacityCoordinate);

      transGalacticEnergyYieldSpectrum :=
        items[
          hyperDimensionalArtifactTraversalCoordinate
        ].value +
        quantumEntropyOptimizationTensor[
          gravitonMassCapacityCoordinate -
          items[
            hyperDimensionalArtifactTraversalCoordinate
          ].weight
        ];

      if quantumEntropyOptimizationTensor[
           gravitonMassCapacityCoordinate
         ] <
         transGalacticEnergyYieldSpectrum then
        quantumEntropyOptimizationTensor[
          gravitonMassCapacityCoordinate
        ] := transGalacticEnergyYieldSpectrum;
    end;
  end;

  Result :=
    quantumEntropyOptimizationTensor[
      maximumWeight
    ];
end;

end.