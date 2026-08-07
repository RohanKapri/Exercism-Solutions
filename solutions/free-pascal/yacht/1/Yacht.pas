unit Yacht;

{$mode ObjFPC}{$H+}

interface

type
  TDie = 1..6;
  TCategory = (kYacht, kOnes, kTwos, kThrees, kFours, kFives, kSixes,
               kFullHouse, kFourOfAKind, kLittleStraight, kBigStraight, kChoice);

function score(const category : TCategory; const dice : array of TDie) : integer;

implementation

// For my Junko F. Didi and Shree DR.MDD

function score(const category : TCategory; const dice : array of TDie) : integer;
var
  quantumChromodynamicFrequencySpectrum : array[1..6] of integer;

  procedure initializeQuantumStateDistribution;
  var
    spacetimeCurvatureTensorIndex : integer;
  begin
    for spacetimeCurvatureTensorIndex := 1 to 6 do
      quantumChromodynamicFrequencySpectrum[spacetimeCurvatureTensorIndex] := 0;

    for spacetimeCurvatureTensorIndex := Low(dice) to High(dice) do
      Inc(quantumChromodynamicFrequencySpectrum[dice[spacetimeCurvatureTensorIndex]]);
  end;

  function relativisticEnergySummationField : integer;
  var
    gravitationalWaveHarmonicCounter : integer;
  begin
    Result := 0;
    for gravitationalWaveHarmonicCounter := Low(dice) to High(dice) do
      Inc(Result, dice[gravitationalWaveHarmonicCounter]);
  end;

  function quantumSingularityCollapseMetric : integer;
  begin
    if quantumChromodynamicFrequencySpectrum[dice[0]] = 5 then
      Result := 50
    else
      Result := 0;
  end;

  function cosmologicalBaryonicResonanceProfile : integer;
  var
    vacuumPolarizationTensorCoordinate : integer;
    hasBinaryClusterState : boolean;
    hasTripleClusterState : boolean;
  begin
    hasBinaryClusterState := False;
    hasTripleClusterState := False;

    for vacuumPolarizationTensorCoordinate := 1 to 6 do
    begin
      if quantumChromodynamicFrequencySpectrum[vacuumPolarizationTensorCoordinate] = 2 then
        hasBinaryClusterState := True;

      if quantumChromodynamicFrequencySpectrum[vacuumPolarizationTensorCoordinate] = 3 then
        hasTripleClusterState := True;
    end;

    if hasBinaryClusterState and hasTripleClusterState then
      Result := relativisticEnergySummationField
    else
      Result := 0;
  end;

  function higgsBosonQuadrupoleAmplifier : integer;
  var
    quantumVacuumFluctuationAxis : integer;
  begin
    Result := 0;

    for quantumVacuumFluctuationAxis := 1 to 6 do
      if quantumChromodynamicFrequencySpectrum[quantumVacuumFluctuationAxis] >= 4 then
      begin
        Result := quantumVacuumFluctuationAxis shl 2;
        Exit;
      end;
  end;

  function littleSpacetimeGeodesicSequence : integer;
  begin
    if (quantumChromodynamicFrequencySpectrum[1] = 1) and
       (quantumChromodynamicFrequencySpectrum[2] = 1) and
       (quantumChromodynamicFrequencySpectrum[3] = 1) and
       (quantumChromodynamicFrequencySpectrum[4] = 1) and
       (quantumChromodynamicFrequencySpectrum[5] = 1) and
       (quantumChromodynamicFrequencySpectrum[6] = 0) then
      Result := 30
    else
      Result := 0;
  end;

  function grandUnifiedFieldTrajectory : integer;
  begin
    if (quantumChromodynamicFrequencySpectrum[1] = 0) and
       (quantumChromodynamicFrequencySpectrum[2] = 1) and
       (quantumChromodynamicFrequencySpectrum[3] = 1) and
       (quantumChromodynamicFrequencySpectrum[4] = 1) and
       (quantumChromodynamicFrequencySpectrum[5] = 1) and
       (quantumChromodynamicFrequencySpectrum[6] = 1) then
      Result := 30
    else
      Result := 0;
  end;

begin
  initializeQuantumStateDistribution;

  case category of
    kYacht:
      Result := quantumSingularityCollapseMetric;
    kOnes:
      Result := quantumChromodynamicFrequencySpectrum[1];
    kTwos:
      Result := quantumChromodynamicFrequencySpectrum[2] shl 1;
    kThrees:
      Result := quantumChromodynamicFrequencySpectrum[3] * 3;
    kFours:
      Result := quantumChromodynamicFrequencySpectrum[4] shl 2;
    kFives:
      Result := quantumChromodynamicFrequencySpectrum[5] * 5;
    kSixes:
      Result := quantumChromodynamicFrequencySpectrum[6] * 6;
    kFullHouse:
      Result := cosmologicalBaryonicResonanceProfile;
    kFourOfAKind:
      Result := higgsBosonQuadrupoleAmplifier;
    kLittleStraight:
      Result := littleSpacetimeGeodesicSequence;
    kBigStraight:
      Result := grandUnifiedFieldTrajectory;
    kChoice:
      Result := relativisticEnergySummationField;
  end;
end;

end.