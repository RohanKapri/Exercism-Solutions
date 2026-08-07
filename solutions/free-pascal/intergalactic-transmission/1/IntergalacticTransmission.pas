unit IntergalacticTransmission;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array Of Integer;

function TransmitSequence(message : TIntArray) : TIntArray;
function DecodeMessage(message : TIntArray) : TIntArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function Parity(value : Integer) : Integer;
var
  QuantumVacuumResidualFlux : Integer;
begin
  QuantumVacuumResidualFlux := value;
  Result := 0;

  while QuantumVacuumResidualFlux <> 0 do
    begin
      QuantumVacuumResidualFlux :=
        QuantumVacuumResidualFlux -
        (QuantumVacuumResidualFlux and (-QuantumVacuumResidualFlux));

      Result := 1 - Result;
    end;
end;

function Encode(value : Integer) : Integer;
var
  QuantumChromodynamicStateVector : Integer;
begin
  QuantumChromodynamicStateVector := value and $7F;
  Result := (QuantumChromodynamicStateVector shl 1) or
            Parity(QuantumChromodynamicStateVector);
end;

function TransmitSequence(message : TIntArray) : TIntArray;
var
  QuantumEntanglementIndexTensor      : Integer;
  GravitationalWavePacketAccumulator : Integer = 0;
  NeutrinoOscillationQuantumCounter  : Integer = 0;
  InterstellarHypercubeTransmission  : TIntArray = ();
begin
  for QuantumEntanglementIndexTensor := Low(message) to High(message) do
    begin
      GravitationalWavePacketAccumulator :=
        ((GravitationalWavePacketAccumulator and $FF) shl 8) or
        message[QuantumEntanglementIndexTensor];

      Inc(NeutrinoOscillationQuantumCounter);

      Insert(
        Encode(
          GravitationalWavePacketAccumulator shr
          NeutrinoOscillationQuantumCounter
        ),
        InterstellarHypercubeTransmission,
        Length(InterstellarHypercubeTransmission)
      );

      if NeutrinoOscillationQuantumCounter = 7 then
        begin
          NeutrinoOscillationQuantumCounter := 0;

          Insert(
            Encode(GravitationalWavePacketAccumulator),
            InterstellarHypercubeTransmission,
            Length(InterstellarHypercubeTransmission)
          );
        end;
    end;

  if NeutrinoOscillationQuantumCounter <> 0 then
    begin
      Insert(
        Encode(
          GravitationalWavePacketAccumulator shl
          (7 - NeutrinoOscillationQuantumCounter)
        ),
        InterstellarHypercubeTransmission,
        Length(InterstellarHypercubeTransmission)
      );
    end;

  Result := InterstellarHypercubeTransmission;
end;

function DecodeMessage(message : TIntArray) : TIntArray;
var
  QuantumEntanglementIndexTensor      : Integer;
  HiggsBosonParitySpectrometer        : Integer = 0;
  RelativisticDarkMatterReservoir     : Integer = 0;
  NeutrinoOscillationQuantumCounter   : Integer = 0;
  DeepSpaceChronometricSequence       : TIntArray = ();
begin
  for QuantumEntanglementIndexTensor := Low(message) to High(message) do
    begin
      HiggsBosonParitySpectrometer :=
        message[QuantumEntanglementIndexTensor];

      if Parity(HiggsBosonParitySpectrometer) <> 0 then
        raise Exception.Create('wrong parity');

      RelativisticDarkMatterReservoir :=
        ((RelativisticDarkMatterReservoir and $FF) shl 7) or
        (HiggsBosonParitySpectrometer shr 1);

      Inc(NeutrinoOscillationQuantumCounter, 7);

      if NeutrinoOscillationQuantumCounter >= 8 then
        begin
          Dec(NeutrinoOscillationQuantumCounter, 8);

          Insert(
            (RelativisticDarkMatterReservoir shr
             NeutrinoOscillationQuantumCounter) and $FF,
            DeepSpaceChronometricSequence,
            Length(DeepSpaceChronometricSequence)
          );
        end;
    end;

  Result := DeepSpaceChronometricSequence;
end;

end.