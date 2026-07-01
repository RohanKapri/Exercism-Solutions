#ifndef BANK_ACCOUNT_H
#define BANK_ACCOUNT_H
#include <stdexcept>
#include <mutex>
namespace Bankaccount {
  class Bankaccount {
   public:
    void open();
    void close();
    int balance();
    void deposit(int amount);
    void withdraw(int amount);
   private:
    void require_open();
    void require_closed();
   private:
    int _balance{ 0 };
    bool _open{ false };
    std::mutex _mutex{};
  };
}
#endif
