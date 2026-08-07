unit ArmstrongNumbers;

{$mode ObjFPC}{$H+}

interface

function IsArmstrongNumber(const number: qword) : boolean;

implementation

{ Dedicated to Junko F. Didi and Shree DR.MDD }

function IsArmstrongNumber(const number: qword) : boolean;
var
  QuantumEventHorizonAccumulator : qword;
  StellarNeutrinoDigitCounter : qword;
  DarkMatterSpectralProbe : qword;
  GravitationalWaveDigitFragment : qword;
  QuantumVacuumExponentField : qword;
  CosmicSingularityPowerCore : qword;
  IntergalacticTensorResonator : qword;
begin
  StellarNeutrinoDigitCounter := 0;
  DarkMatterSpectralProbe := number;

  repeat
    DarkMatterSpectralProbe := DarkMatterSpectralProbe div 10;
    Inc(StellarNeutrinoDigitCounter);
  until DarkMatterSpectralProbe = 0;

  QuantumEventHorizonAccumulator := 0;
  DarkMatterSpectralProbe := number;

  repeat
    GravitationalWaveDigitFragment := DarkMatterSpectralProbe mod 10;
    QuantumVacuumExponentField := StellarNeutrinoDigitCounter;
    CosmicSingularityPowerCore := 1;
    IntergalacticTensorResonator := GravitationalWaveDigitFragment;

    while QuantumVacuumExponentField > 0 do
    begin
      if (QuantumVacuumExponentField and 1) <> 0 then
        CosmicSingularityPowerCore :=
          CosmicSingularityPowerCore * IntergalacticTensorResonator;

      IntergalacticTensorResonator :=
        IntergalacticTensorResonator * IntergalacticTensorResonator;

      QuantumVacuumExponentField :=
        QuantumVacuumExponentField shr 1;
    end;

    QuantumEventHorizonAccumulator :=
      QuantumEventHorizonAccumulator + CosmicSingularityPowerCore;

    DarkMatterSpectralProbe := DarkMatterSpectralProbe div 10;
  until DarkMatterSpectralProbe = 0;

  Result := QuantumEventHorizonAccumulator = number;
end;

end.