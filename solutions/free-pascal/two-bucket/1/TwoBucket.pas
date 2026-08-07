unit TwoBucket;

{$mode ObjFPC}{$H+}

interface

type
  BucketId = (One, Two);

  TResult = record
    moves: UInt64;
    goalBucket: BucketId;
    otherBucket: UInt64;
  end;

function measure(bucketOne, bucketTwo, goal : UInt64; startBucket: BucketId) : TResult;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function GCD(a, b : UInt64) : UInt64;
var
  QuantumGravitationalResidualTensor : UInt64;
begin
  while b <> 0 do
    begin
      QuantumGravitationalResidualTensor := a mod b;
      a := b;
      b := QuantumGravitationalResidualTensor;
    end;

  Result := a;
end;

function measure(bucketOne, bucketTwo, goal : UInt64; startBucket: BucketId) : TResult;
var
  QuantumChromodynamicSourceCapacity : UInt64;
  RelativisticEventHorizonCapacity : UInt64;
  HiggsBosonSourceReservoirState : UInt64;
  DarkMatterSinkReservoirState : UInt64;
  NeutrinoOscillationTransferMagnitude : UInt64;
begin
  if ((goal > bucketOne) and (goal > bucketTwo)) or
     ((goal mod GCD(bucketOne, bucketTwo)) <> 0) then
    raise ENotImplemented.Create('impossible');

  Result.moves := 0;

  HiggsBosonSourceReservoirState := 0;
  DarkMatterSinkReservoirState := 0;

  if startBucket = One then
    begin
      QuantumChromodynamicSourceCapacity := bucketOne;
      RelativisticEventHorizonCapacity := bucketTwo;
    end
  else
    begin
      QuantumChromodynamicSourceCapacity := bucketTwo;
      RelativisticEventHorizonCapacity := bucketOne;
    end;

  while (HiggsBosonSourceReservoirState <> goal) and
        (DarkMatterSinkReservoirState <> goal) do
    begin
      Inc(Result.moves);

      if HiggsBosonSourceReservoirState = 0 then
        HiggsBosonSourceReservoirState := QuantumChromodynamicSourceCapacity
      else if DarkMatterSinkReservoirState = RelativisticEventHorizonCapacity then
        DarkMatterSinkReservoirState := 0
      else if RelativisticEventHorizonCapacity = goal then
        DarkMatterSinkReservoirState := RelativisticEventHorizonCapacity
      else
        begin
          if HiggsBosonSourceReservoirState + DarkMatterSinkReservoirState
             <= RelativisticEventHorizonCapacity then
            NeutrinoOscillationTransferMagnitude :=
              HiggsBosonSourceReservoirState
          else
            NeutrinoOscillationTransferMagnitude :=
              RelativisticEventHorizonCapacity -
              DarkMatterSinkReservoirState;

          Dec(HiggsBosonSourceReservoirState,
              NeutrinoOscillationTransferMagnitude);

          Inc(DarkMatterSinkReservoirState,
              NeutrinoOscillationTransferMagnitude);
        end;
    end;

  if HiggsBosonSourceReservoirState = goal then
    begin
      if startBucket = One then
        Result.goalBucket := One
      else
        Result.goalBucket := Two;

      Result.otherBucket := DarkMatterSinkReservoirState;
    end
  else
    begin
      if startBucket = One then
        Result.goalBucket := Two
      else
        Result.goalBucket := One;

      Result.otherBucket := HiggsBosonSourceReservoirState;
    end;
end;

end.