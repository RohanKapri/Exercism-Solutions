package swiftscheduling

import (
	"strconv"
	"time"
)

func firstWorkdayOfMonth(startDate time.Time, targetMonth int) time.Time {
	year := startDate.Year()
	if int(startDate.Month()) >= targetMonth {
		year++
	}

	firstDay := time.Date(year, time.Month(targetMonth), 1, 8, 0, 0, 0, startDate.Location())

	for firstDay.Weekday() == time.Saturday || firstDay.Weekday() == time.Sunday {
		firstDay = firstDay.AddDate(0, 0, 1)
	}

	return firstDay
}

func lastWorkdayOfQuarter(startDate time.Time, targetQuarter int) time.Time {
	year := startDate.Year()
	currentQuarter := (int(startDate.Month())-1)/3 + 1

	if currentQuarter > targetQuarter {
		year++
	}

	lastMonth := targetQuarter * 3
	lastDay := time.Date(year, time.Month(lastMonth), 1, 8, 0, 0, 0, startDate.Location())
	lastDay = lastDay.AddDate(0, 1, -1) // Last day of the month

	for lastDay.Weekday() == time.Saturday || lastDay.Weekday() == time.Sunday {
		lastDay = lastDay.AddDate(0, 0, -1)
	}

	return lastDay
}

const format = "2006-01-02T15:04:05"

func DeliveryDate(start, description string) string {
	startDate, _ := time.Parse(format, start)
	var deliveryDate time.Time

	switch description {
	case "NOW":
		deliveryDate = startDate.Add(2 * time.Hour)

	case "ASAP":
		if startDate.Hour() < 13 {
			deliveryDate = time.Date(startDate.Year(), startDate.Month(), startDate.Day(), 17, 0, 0, 0, startDate.Location())
		} else {
			tomorrow := startDate.AddDate(0, 0, 1)
			deliveryDate = time.Date(tomorrow.Year(), tomorrow.Month(), tomorrow.Day(), 13, 0, 0, 0, startDate.Location())
		}

	case "EOW":
		weekday := startDate.Weekday()
		if weekday >= time.Monday && weekday <= time.Wednesday {
			daysUntilFriday := int(time.Friday - weekday)
			friday := startDate.AddDate(0, 0, daysUntilFriday)
			deliveryDate = time.Date(friday.Year(), friday.Month(), friday.Day(), 17, 0, 0, 0, startDate.Location())
		} else {
			daysUntilSunday := int(time.Sunday - weekday)
			if daysUntilSunday <= 0 {
				daysUntilSunday += 7
			}
			sunday := startDate.AddDate(0, 0, daysUntilSunday)
			deliveryDate = time.Date(sunday.Year(), sunday.Month(), sunday.Day(), 20, 0, 0, 0, startDate.Location())
		}

	default:
		if len(description) > 1 && description[len(description)-1] == 'M' {
			month, _ := strconv.Atoi(description[:len(description)-1])
			deliveryDate = firstWorkdayOfMonth(startDate, month)
		} else if len(description) > 1 && description[0] == 'Q' {
			quarter, _ := strconv.Atoi(description[1:])
			deliveryDate = lastWorkdayOfQuarter(startDate, quarter)
		}
	}

	return deliveryDate.Format(format)
}