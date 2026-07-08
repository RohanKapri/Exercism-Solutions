unit uBankAccount;

interface

uses
  System.SysUtils, System.SyncObjs;

type

  EAccountNotOpen = Exception;

  IBankAccount = interface
  ['{F354A332-8B2A-4AF0-91E6-77AF9DA3E947}']
    function GetBalance: double;
    procedure SetBalance(const Value: double);

    procedure Open;
    procedure Close;
    procedure UpdateBalance(const AValue:double);
    property Balance:double read GetBalance write SetBalance;
  end;

  TAccountState = (aeOpen, aeClosed);

  TBankAccount = class(TInterfacedObject, IBankAccount)
  private
    FBalance: double;
    AccountState:TAccountState;
    LockAccount:TCriticalSection;
    function GetBalance: double;
    procedure SetBalance(const Value: double);
  public
    constructor Create;
    procedure UpdateBalance(const Value:double);
    procedure Open;
    procedure Close;
    property Balance:double read GetBalance write SetBalance;
  end;


implementation


{ TBankAccount }

procedure TBankAccount.Close;
begin
  AccountState := aeClosed;
end;

constructor TBankAccount.Create;
begin
  inherited;
  AccountState := aeClosed;
  LockAccount := TCriticalSection.Create;
end;

function TBankAccount.GetBalance: double;
begin
  if (AccountState <> aeOpen) then
    raise EAccountNotOpen.Create('Account closed.');
  Result := FBalance;
end;

procedure TBankAccount.Open;
begin
  AccountState := aeOpen;
end;

procedure TBankAccount.SetBalance(const Value: double);
begin
  FBalance := Value;
end;

procedure TBankAccount.UpdateBalance(const Value: double);
begin
  LockAccount.Acquire;
  try
    if (AccountState <> aeOpen) then
      raise EAccountNotOpen.Create('Account closed.');
    FBalance := FBalance + Value;
  finally
    LockAccount.Release;
  end;
end;

end.