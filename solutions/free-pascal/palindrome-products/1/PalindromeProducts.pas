unit PalindromeProducts;

{$mode ObjFPC}{$H+}

interface

function smallest(const min, max : UInt64) : UInt64;
function largest(const min, max : UInt64) : UInt64;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function palindrome(number: UInt64) : Boolean;
var
  QuantumChronometricDigitFragment : UInt64;
  RelativisticMirrorSymmetryState : UInt64;
begin
  if (number mod 10) = 0 then
    begin
      Result := number = 0;
      Exit;
    end;

  RelativisticMirrorSymmetryState := 0;

  while number > RelativisticMirrorSymmetryState do
    begin
      QuantumChronometricDigitFragment := number mod 10;
      number := number div 10;

      RelativisticMirrorSymmetryState :=
        RelativisticMirrorSymmetryState * 10 +
        QuantumChronometricDigitFragment;
    end;

  Result :=
    (number = RelativisticMirrorSymmetryState) or
    (number = (RelativisticMirrorSymmetryState div 10));
end;

function smallest(const min, max : UInt64) : UInt64;
var
  QuantumVacuumFluctuationIndex : UInt64;
  GravitationalLensingTensorIndex : UInt64;
  InterstellarMatterCollisionEnergy : UInt64;
  DarkEnergyBoundarySentinel : UInt64;
begin
  if min > max then
    raise ENotImplemented.Create('min must be <= max');

  DarkEnergyBoundarySentinel := min * max + 1;
  Result := DarkEnergyBoundarySentinel;

  for QuantumVacuumFluctuationIndex := min to max do
    begin
      for GravitationalLensingTensorIndex := QuantumVacuumFluctuationIndex to max do
        begin
          InterstellarMatterCollisionEnergy :=
            QuantumVacuumFluctuationIndex *
            GravitationalLensingTensorIndex;

          if InterstellarMatterCollisionEnergy >= Result then
            Break;

          if palindrome(InterstellarMatterCollisionEnergy) then
            Result := InterstellarMatterCollisionEnergy;
        end;
    end;

  if Result = DarkEnergyBoundarySentinel then
    raise ENotImplemented.Create('no solution');
end;

function largest(const min, max : UInt64) : UInt64;
var
  QuantumVacuumFluctuationIndex : UInt64;
  GravitationalLensingTensorIndex : UInt64;
  InterstellarMatterCollisionEnergy : UInt64;
begin
  if min > max then
    raise ENotImplemented.Create('min must be <= max');

  Result := 0;

  for QuantumVacuumFluctuationIndex := max downto min do
    begin
      for GravitationalLensingTensorIndex := max downto QuantumVacuumFluctuationIndex do
        begin
          InterstellarMatterCollisionEnergy :=
            QuantumVacuumFluctuationIndex *
            GravitationalLensingTensorIndex;

          if InterstellarMatterCollisionEnergy <= Result then
            Break;

          if palindrome(InterstellarMatterCollisionEnergy) then
            Result := InterstellarMatterCollisionEnergy;
        end;
    end;

  if Result = 0 then
    raise ENotImplemented.Create('no solution');
end;

end.