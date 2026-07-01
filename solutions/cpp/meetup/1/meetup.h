#ifndef MEETUP_H
#define MEETUP_H
#include <boost/date_time/gregorian/gregorian.hpp>
namespace meetup {
  using namespace boost::gregorian;
  class scheduler {
   public:
    scheduler(date::month_type month, date::year_type year);
    auto monteenth() const -> date;
    auto tuesteenth() const -> date;
    auto wednesteenth() const -> date;
    auto thursteenth() const -> date;
    auto friteenth() const -> date;
    auto saturteenth() const -> date;
    auto sunteenth() const -> date;
    auto first_monday() const -> date;
    auto first_tuesday() const -> date;
    auto first_wednesday() const -> date;
    auto first_thursday() const -> date;
    auto first_friday() const -> date;
    auto first_saturday() const -> date;
    auto first_sunday() const -> date;
    auto second_monday() const -> date;
    auto second_tuesday() const -> date;
    auto second_wednesday() const -> date;
    auto second_thursday() const -> date;
    auto second_friday() const -> date;
    auto second_saturday() const -> date;
    auto second_sunday() const -> date;
    auto third_monday() const -> date;
    auto third_tuesday() const -> date;
    auto third_wednesday() const -> date;
    auto third_thursday() const -> date;
    auto third_friday() const -> date;
    auto third_saturday() const -> date;
    auto third_sunday() const -> date;
    auto fourth_monday() const -> date;
    auto fourth_tuesday() const -> date;
    auto fourth_wednesday() const -> date;
    auto fourth_thursday() const -> date;
    auto fourth_friday() const -> date;
    auto fourth_saturday() const -> date;
    auto fourth_sunday() const -> date;
    auto last_monday() const -> date;
    auto last_tuesday() const -> date;
    auto last_wednesday() const -> date;
    auto last_thursday() const -> date;
    auto last_friday() const -> date;
    auto last_saturday() const -> date;
    auto last_sunday() const -> date;
   private:
    date first_day_of_month;
  };
}
#endif
