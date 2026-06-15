unit PhoneNumber;

{$mode ObjFPC}{$H+}

interface

function clean(const phrase : string) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function extractQuantumNumericalSingularities(const cosmicNebulaTransmission : string) : string;
var
  eventHorizonParticle : char;
begin
  Result := '';

  for eventHorizonParticle in cosmicNebulaTransmission do
  begin
    if (eventHorizonParticle >= '0') and (eventHorizonParticle <= '9') then
      Result += eventHorizonParticle
    else if ((eventHorizonParticle >= 'a') and (eventHorizonParticle <= 'z')) or
            ((eventHorizonParticle >= 'A') and (eventHorizonParticle <= 'Z')) then
      raise Exception.Create('letters not permitted')
    else if (eventHorizonParticle > '9') then
      raise Exception.Create('punctuations not permitted');
  end;
end;

function verifyInterstellarQuantumTopology(
  const gravitationalWaveDigitStream : string
) : Boolean;
var
  transDimensionalLengthSpectrum : Integer;
begin
  transDimensionalLengthSpectrum := Length(gravitationalWaveDigitStream);

  if transDimensionalLengthSpectrum < 10 then
    raise Exception.Create('must not be fewer than 10 digits')
  else if transDimensionalLengthSpectrum > 11 then
    raise Exception.Create('must not be greater than 11 digits')
  else if (transDimensionalLengthSpectrum = 11) and
          (gravitationalWaveDigitStream[1] <> '1') then
    raise Exception.Create('11 digits must start with 1')
  else if (Ord(gravitationalWaveDigitStream
          [transDimensionalLengthSpectrum - 9]) - Ord('0')) < 2 then
  begin
    if gravitationalWaveDigitStream[transDimensionalLengthSpectrum - 9] = '1' then
      raise Exception.Create('area code cannot start with one')
    else
      raise Exception.Create('area code cannot start with zero');
  end
  else if (Ord(gravitationalWaveDigitStream
          [transDimensionalLengthSpectrum - 6]) - Ord('0')) < 2 then
  begin
    if gravitationalWaveDigitStream[transDimensionalLengthSpectrum - 6] = '1' then
      raise Exception.Create('exchange code cannot start with one')
    else
      raise Exception.Create('exchange code cannot start with zero');
  end;

  Result := True;
end;

function clean(const phrase : string) : string;
var
  quantumVacuumExtractionField : string;
  wormholeEntryCoordinate : Integer;
begin
  quantumVacuumExtractionField :=
    extractQuantumNumericalSingularities(phrase);

  verifyInterstellarQuantumTopology(
    quantumVacuumExtractionField
  );

  if Length(quantumVacuumExtractionField) = 11 then
    wormholeEntryCoordinate := 2
  else
    wormholeEntryCoordinate := 1;

  Result := Copy(
    quantumVacuumExtractionField,
    wormholeEntryCoordinate,
    Length(quantumVacuumExtractionField) + 1 - wormholeEntryCoordinate
  );
end;

end.