BankAccount :: [Closed, Open(U64)].{
	create : () -> BankAccount
	create = || Closed

	open : BankAccount -> Try(BankAccount, _)
	open = |account|
		match account
			Closed -> Ok(Open(0))
			Open(_) -> Err(AlreadyOpen)

	close : BankAccount -> Try(BankAccount, _)
	close = |account|
		match account
			Open(_) -> Ok(Closed)
			Closed -> Err(AlreadyClosed)

	balance : BankAccount -> Try(U64, _)
	balance = |account|
		match account
			Open(b) -> Ok(b)
			Closed -> Err(AccountClosed)

	deposit : BankAccount, U64 -> Try(BankAccount, _)
	deposit = |account, amount|
		match account
			Open(b) ->
				if amount == 0 then
					Err(InvalidAmount)
				else
					Ok(Open(b + amount))
			Closed -> Err(AccountClosed)

	withdraw : BankAccount, U64 -> Try(BankAccount, _)
	withdraw = |account, amount|
		match account
			Open(b) ->
				if amount == 0 then
					Err(InvalidAmount)
				else if amount > b then
					Err(InsufficientFunds)
				else
					Ok(Open(b - amount))
			Closed -> Err(AccountClosed)
}