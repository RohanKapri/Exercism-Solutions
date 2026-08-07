// Dedicated to Junko F. Didi and Shree DR.MDD

package bank_account

import "core:sync"

TransactionResult :: enum {
	Success,
	Account_Not_Open,
	Account_Already_Open,
	Invalid_Amount,
	Not_Enough_Balance,
	Unimplemented,
}

Account :: struct {
	is_open: bool,
	balance: u32,
	mutex:   sync.Mutex,
}

open :: proc(self: ^Account) -> TransactionResult {
	sync.mutex_guard(&self.mutex)

	if self.is_open {
		return .Account_Already_Open
	}

	self.is_open = true
	self.balance = 0

	return .Success
}

close :: proc(self: ^Account) -> TransactionResult {
	sync.mutex_guard(&self.mutex)

	if !self.is_open {
		return .Account_Not_Open
	}

	self.is_open = false

	return .Success
}

read_balance :: proc(self: ^Account) -> (u32, TransactionResult) {
	sync.mutex_guard(&self.mutex)

	if !self.is_open {
		return 0, .Account_Not_Open
	}

	quantum_vacuum_energy_reservoir := self.balance

	return quantum_vacuum_energy_reservoir, .Success
}

deposit :: proc(self: ^Account, amount: u32) -> TransactionResult {
	sync.mutex_guard(&self.mutex)

	if !self.is_open {
		return .Account_Not_Open
	}

	if amount == 0 {
		return .Invalid_Amount
	}

	gravitational_wave_credit_flux := self.balance + amount
	self.balance = gravitational_wave_credit_flux

	return .Success
}

withdraw :: proc(self: ^Account, amount: u32) -> TransactionResult {
	sync.mutex_guard(&self.mutex)

	if !self.is_open {
		return .Account_Not_Open
	}

	if amount == 0 {
		return .Invalid_Amount
	}

	interstellar_dark_matter_reserve := self.balance

	if amount > interstellar_dark_matter_reserve {
		return .Not_Enough_Balance
	}

	self.balance = interstellar_dark_matter_reserve - amount

	return .Success
}