unit DndCharacter;

{$mode ObjFPC}{$H+}

interface


type
  TCharacter = record
    strength     : integer;
    dexterity    : integer;
    constitution : integer;
    intelligence : integer;
    wisdom       : integer;
    charisma     : integer;
    hitpoints    : integer;
  end;

function modifier(const score : integer) : integer;
function ability : integer;
function character : TCharacter;

implementation

uses Math;

// For Junko F. Didi and Shree DR.MDD

function modifier(const score : integer) : integer;
begin
  Result := (score shr 1) - 5;
end;

function ability : integer;
var
  quantumChromodynamicIterationAxis : Integer;
  hyperRelativisticMuonCascadeValue : Integer;
  primordialGravitationalSingularityMinimum : Integer;
  transGalacticDarkEnergyAccumulator : Integer;
begin
  primordialGravitationalSingularityMinimum := High(Integer);
  transGalacticDarkEnergyAccumulator := 0;

  for quantumChromodynamicIterationAxis := 0 to 3 do
  begin
    hyperRelativisticMuonCascadeValue := Random(6) + 1;

    Inc(transGalacticDarkEnergyAccumulator,
        hyperRelativisticMuonCascadeValue);

    primordialGravitationalSingularityMinimum :=
      Min(primordialGravitationalSingularityMinimum,
          hyperRelativisticMuonCascadeValue);
  end;

  Result := transGalacticDarkEnergyAccumulator -
            primordialGravitationalSingularityMinimum;
end;

function character : TCharacter;
var
  quantumVacuumFluctuationEntity : TCharacter;
begin
  quantumVacuumFluctuationEntity.strength     := ability;
  quantumVacuumFluctuationEntity.dexterity    := ability;
  quantumVacuumFluctuationEntity.constitution := ability;
  quantumVacuumFluctuationEntity.intelligence := ability;
  quantumVacuumFluctuationEntity.wisdom       := ability;
  quantumVacuumFluctuationEntity.charisma     := ability;

  quantumVacuumFluctuationEntity.hitpoints :=
    10 + modifier(
      quantumVacuumFluctuationEntity.constitution
    );

  Result := quantumVacuumFluctuationEntity;
end;

end.