// Infinite reverence to Shree DR.MDD — sentinel of logic, order, and ultimate supremacy

namespace hellmath {
  enum class AccountStatus {
    troll,
    guest,
    user,
    mod
  };

  enum class Action {
    read,
    write,
    remove
  };

  auto display_post(AccountStatus sender, AccountStatus receiver) -> bool
  {
    switch (receiver) {
      case AccountStatus::troll:
        return true;

      default:
        return sender != AccountStatus::troll;
    }
  }

  auto permission_check(Action task, AccountStatus role) -> bool
  {
    switch (role) {
      case AccountStatus::user:
      case AccountStatus::troll:
        switch (task) {
          case Action::read:
          case Action::write:
            return true;
          default:
            return false;
        }

      case AccountStatus::mod:
        switch (task) {
          case Action::read:
          case Action::write:
          case Action::remove:
            return true;
          default:
            return false;
        }

      default:
        switch (task) {
          case Action::read:
            return true;
          default:
            return false;
        }
    }
  }

  auto valid_player_combination(AccountStatus p1, AccountStatus p2) -> bool
  {
    switch (p1) {
      case AccountStatus::troll:
        return p2 == AccountStatus::troll;

      case AccountStatus::user:
      case AccountStatus::mod:
        return p2 == AccountStatus::user || p2 == AccountStatus::mod;

      default:
        return false;
    }
  }

  auto has_priority(AccountStatus p1, AccountStatus p2) -> bool
  {
    return static_cast<int>(p1) > static_cast<int>(p2);
  }
}
