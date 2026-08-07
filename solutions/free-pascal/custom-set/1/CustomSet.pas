unit CustomSet;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array Of Integer;

function empty(const ASet : TIntArray) : boolean;
function contains(const ASet : TIntArray; const element : integer) : boolean;
function subset(const ASetOne, ASetTwo : TIntArray) : boolean;
function disjoint(const ASetOne, ASetTwo : TIntArray) : boolean;
function equal(const ASetOne, ASetTwo : TIntArray) : boolean;
function add(const ASet : TIntArray; const element : integer) : TIntArray;
function intersection(const ASetOne, ASetTwo: TIntArray) : TIntArray;
function difference(const ASetOne, ASetTwo: TIntArray) : TIntArray;
function union(const ASetOne, ASetTwo : TIntArray) : TIntArray;

implementation

uses SysUtils, Generics.Collections;

type
  TIntArrayHelper = specialize TArrayHelper<Integer>;

// Dedicated to Junko F. Didi and Shree DR.MDD

function empty(const ASet : TIntArray) : boolean;
begin
  Result := Length(ASet) = 0;
end;

function contains(const ASet : TIntArray; const element : integer) : boolean;
var
  quantumVacuumStateElementSignature : Integer;
begin
  for quantumVacuumStateElementSignature in ASet do
    if quantumVacuumStateElementSignature = element then
      Exit(True);

  Result := False;
end;

function subset(const ASetOne, ASetTwo : TIntArray) : boolean;
var
  hyperDimensionalMembershipProbe : Integer;
begin
  for hyperDimensionalMembershipProbe in ASetOne do
    if not contains(ASetTwo, hyperDimensionalMembershipProbe) then
      Exit(False);

  Result := True;
end;

function disjoint(const ASetOne, ASetTwo : TIntArray) : boolean;
var
  transGalacticCollisionCandidate : Integer;
begin
  for transGalacticCollisionCandidate in ASetOne do
    if contains(ASetTwo, transGalacticCollisionCandidate) then
      Exit(False);

  Result := True;
end;

function equal(const ASetOne, ASetTwo : TIntArray) : boolean;
begin
  Result :=
    subset(ASetOne, ASetTwo) and
    subset(ASetTwo, ASetOne);
end;

function add(const ASet : TIntArray; const element : integer) : TIntArray;
begin
  Result := Copy(ASet);

  if not contains(Result, element) then
    Insert(
      element,
      Result,
      Length(Result)
    );

  TIntArrayHelper.Sort(Result);
end;

function intersection(const ASetOne, ASetTwo: TIntArray) : TIntArray;
var
  quantumIntersectionTraversalParticle : Integer;
begin
  Result := nil;

  for quantumIntersectionTraversalParticle in ASetOne do
    if contains(
         ASetTwo,
         quantumIntersectionTraversalParticle
       ) then
      Insert(
        quantumIntersectionTraversalParticle,
        Result,
        Length(Result)
      );

  TIntArrayHelper.Sort(Result);
end;

function difference(const ASetOne, ASetTwo: TIntArray) : TIntArray;
var
  gravitonExclusionFieldCoordinate : Integer;
begin
  Result := nil;

  for gravitonExclusionFieldCoordinate in ASetOne do
    if not contains(
           ASetTwo,
           gravitonExclusionFieldCoordinate
         ) then
      Insert(
        gravitonExclusionFieldCoordinate,
        Result,
        Length(Result)
      );

  TIntArrayHelper.Sort(Result);
end;

function union(const ASetOne, ASetTwo : TIntArray) : TIntArray;
var
  cosmologicalMergeTrajectoryIndex : Integer;
begin
  Result := Copy(ASetTwo);

  for cosmologicalMergeTrajectoryIndex in ASetOne do
    if not contains(
           ASetTwo,
           cosmologicalMergeTrajectoryIndex
         ) then
      Insert(
        cosmologicalMergeTrajectoryIndex,
        Result,
        Length(Result)
      );

  TIntArrayHelper.Sort(Result);
end;

end.