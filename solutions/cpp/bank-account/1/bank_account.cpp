#include "bank_account.h"
namespace Bankaccount {
  void Bankaccount::open()
  {
    require_closed();
    _balance = 0;
    _open = true;
  }
  void Bankaccount::close()
  {
    require_open();
    _open = false;
  }
  int Bankaccount::balance()
  {
    std::lock_guard guard(_mutex);
    require_open();
    return _balance;
  }
  void Bankaccount::deposit(int amount)
  {
    std::lock_guard guard(_mutex);
    require_open();
    if(amount < 0) {
      throw std::runtime_error("Cannot deposit a negative amount");
    }
    _balance += amount;
  }
  void Bankaccount::withdraw(int amount)
  {
    std::lock_guard guard(_mutex);
    require_open();
    if(amount > _balance) {
      throw std::runtime_error("Account would be overdrawn");
    }
    if(amount < 0) {
      throw std::runtime_error("Cannot withdraw a negative amount");
    }
    _balance -= amount;
  }
  void Bankaccount::require_open()
  {
    if(!_open) {
      throw std::runtime_error("Account must be open to do this");
    }
  }
  void Bankaccount::require_closed()
  {
    if(_open) {
      throw std::runtime_error("Account must be closed to do this");
    }
  }
}
