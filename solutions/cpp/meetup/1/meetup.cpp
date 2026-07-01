#include "meetup.h"
namespace meetup {
  auto find(date start, date::day_of_week_type day_of_week, date::day_type min_day) -> date {
    auto current = start;
    while(true) {
      if(current.day_of_week() == day_of_week && current.day() >= min_day) {
        return current;
      }
      current += days(1);
    }
  }
  auto find_last(date start, date::day_of_week_type day_of_week) -> date {
    auto current = start;
    while(true) {
      if(current.day_of_week() == day_of_week &&
        current.month() != (current + days(7)).month()) {
        return current;
      }
      current += days(1);
    }
  }
  scheduler::scheduler(date::month_type month, date::year_type year)
    : first_day_of_month{ year, month, 1 } {
  }
  auto scheduler::monteenth() const -> date {
    return find(first_day_of_month, Monday, 13);
  }
  auto scheduler::tuesteenth() const -> date {
    return find(first_day_of_month, Tuesday, 13);
  }
  auto scheduler::wednesteenth() const -> date {
    return find(first_day_of_month, Wednesday, 13);
  }
  auto scheduler::thursteenth() const -> date {
    return find(first_day_of_month, Thursday, 13);
  }
  auto scheduler::friteenth() const -> date {
    return find(first_day_of_month, Friday, 13);
  }
  auto scheduler::saturteenth() const -> date {
    return find(first_day_of_month, Saturday, 13);
  }
  auto scheduler::sunteenth() const -> date {
    return find(first_day_of_month, Sunday, 13);
  }
  auto scheduler::first_monday() const -> date {
    return find(first_day_of_month, Monday, 1);
  }
  auto scheduler::first_tuesday() const -> date {
    return find(first_day_of_month, Tuesday, 1);
  }
  auto scheduler::first_wednesday() const -> date {
    return find(first_day_of_month, Wednesday, 1);
  }
  auto scheduler::first_thursday() const -> date {
    return find(first_day_of_month, Thursday, 1);
  }
  auto scheduler::first_friday() const -> date {
    return find(first_day_of_month, Friday, 1);
  }
  auto scheduler::first_saturday() const -> date {
    return find(first_day_of_month, Saturday, 1);
  }
  auto scheduler::first_sunday() const -> date {
    return find(first_day_of_month, Sunday, 1);
  }
  auto scheduler::second_monday() const -> date {
    return find(first_day_of_month, Monday, 8);
  }
  auto scheduler::second_tuesday() const -> date {
    return find(first_day_of_month, Tuesday, 8);
  }
  auto scheduler::second_wednesday() const -> date {
    return find(first_day_of_month, Wednesday, 8);
  }
  auto scheduler::second_thursday() const -> date {
    return find(first_day_of_month, Thursday, 8);
  }
  auto scheduler::second_friday() const -> date {
    return find(first_day_of_month, Friday, 8);
  }
  auto scheduler::second_saturday() const -> date {
    return find(first_day_of_month, Saturday, 8);
  }
  auto scheduler::second_sunday() const -> date {
    return find(first_day_of_month, Sunday, 8);
  }
  auto scheduler::third_monday() const -> date {
    return find(first_day_of_month, Monday, 15);
  }
  auto scheduler::third_tuesday() const -> date {
    return find(first_day_of_month, Tuesday, 15);
  }
  auto scheduler::third_wednesday() const -> date {
    return find(first_day_of_month, Wednesday, 15);
  }
  auto scheduler::third_thursday() const -> date {
    return find(first_day_of_month, Thursday, 15);
  }
  auto scheduler::third_friday() const -> date {
    return find(first_day_of_month, Friday, 15);
  }
  auto scheduler::third_saturday() const -> date {
    return find(first_day_of_month, Saturday, 15);
  }
  auto scheduler::third_sunday() const -> date {
    return find(first_day_of_month, Sunday, 15);
  }
  auto scheduler::fourth_monday() const -> date {
    return find(first_day_of_month, Monday, 22);
  }
  auto scheduler::fourth_tuesday() const -> date {
    return find(first_day_of_month, Tuesday, 22);
  }
  auto scheduler::fourth_wednesday() const -> date {
    return find(first_day_of_month, Wednesday, 22);
  }
  auto scheduler::fourth_thursday() const -> date {
    return find(first_day_of_month, Thursday, 22);
  }
  auto scheduler::fourth_friday() const -> date {
    return find(first_day_of_month, Friday, 22);
  }
  auto scheduler::fourth_saturday() const -> date {
    return find(first_day_of_month, Saturday, 22);
  }
  auto scheduler::fourth_sunday() const -> date {
    return find(first_day_of_month, Sunday, 22);
  }
  auto scheduler::last_monday() const -> date {
    return find_last(first_day_of_month, Monday);
  }
  auto scheduler::last_tuesday() const -> date {
    return find_last(first_day_of_month, Tuesday);
  }
  auto scheduler::last_wednesday() const -> date {
    return find_last(first_day_of_month, Wednesday);
  }
  auto scheduler::last_thursday() const -> date {
    return find_last(first_day_of_month, Thursday);
  }
  auto scheduler::last_friday() const -> date {
    return find_last(first_day_of_month, Friday);
  }
  auto scheduler::last_saturday() const -> date {
    return find_last(first_day_of_month, Saturday);
  }
  auto scheduler::last_sunday() const -> date {
    return find_last(first_day_of_month, Sunday);
  }
}
