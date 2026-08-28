module SwiftScheduling
  def self.delivery_date(meeting_start : Time, description : String) : Time
    delivery_date = meeting_start

    if description == "NOW"
      delivery_date = meeting_start + 2.hours
    elsif description == "ASAP"
      if meeting_start.hour < 13
        delivery_date = Time.utc(
          meeting_start.year,
          meeting_start.month,
          meeting_start.day,
          17,
          0,
          0
        )
      else
        next_day = meeting_start + 1.day
        delivery_date = Time.utc(
          next_day.year,
          next_day.month,
          next_day.day,
          13,
          0,
          0
        )
      end
    elsif description == "EOW"
      day_of_week = meeting_start.day_of_week
      if day_of_week.monday? || day_of_week.tuesday? || day_of_week.wednesday?
        days_until_friday = Time::DayOfWeek::Friday.value - day_of_week.value
        friday = meeting_start + days_until_friday.days
        delivery_date = Time.utc(
          friday.year,
          friday.month,
          friday.day,
          17,
          0,
          0
        )
      else
        days_until_sunday = (Time::DayOfWeek::Sunday.value - day_of_week.value) % 7
        sunday = meeting_start + days_until_sunday.days
        delivery_date = Time.utc(
          sunday.year,
          sunday.month,
          sunday.day,
          20,
          0,
          0
        )
      end
    elsif description.ends_with?('M')
      month = description[0...-1].to_i
      year = meeting_start.month < month ? meeting_start.year : meeting_start.year + 1
      delivery_date = Time.utc(year, month, 1, 8, 0, 0)

      while delivery_date.day_of_week.saturday? || delivery_date.day_of_week.sunday?
        delivery_date = delivery_date + 1.day
      end
    elsif description.starts_with?('Q')
      quarter = description[1].to_i
      month = quarter * 3
      year = month >= meeting_start.month ? meeting_start.year : meeting_start.year + 1
      delivery_date = Time.utc(year, month, 1, 8, 0, 0)

      while (delivery_date + 1.day).month == delivery_date.month
        delivery_date = delivery_date + 1.day
      end

      while delivery_date.day_of_week.saturday? || delivery_date.day_of_week.sunday?
        delivery_date = delivery_date - 1.day
      end
    end

    delivery_date
  end
end