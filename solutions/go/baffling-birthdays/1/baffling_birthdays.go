package bafflingbirthdays

import (
	"math/rand"
	"time"
)

func SharedBirthday(dates []time.Time) bool {
	set := make(map[[2]int]struct{})
	for _, date := range dates {
		key := [2]int{int(date.Month()), date.Day()}
		if _, exists := set[key]; exists {
			return true
		}
		set[key] = struct{}{}
	}
	return false
}

func _isLeapYear(year int) bool {
	return year%4 == 0 && (year%100 != 0 || year%400 == 0)
}

func daysInMonth(month time.Month) int {
	switch month {
	case time.April, time.June, time.September, time.November:
		return 30
	case time.February:
		return 28
	default:
		return 31
	}
}

func RandomBirthdates(size int) []time.Time {
	dates := make([]time.Time, size)
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))
	for i := range size {
		year := 1900 + rng.Intn(200)
		for _isLeapYear(year) {
			year = 1900 + rng.Intn(200)
		}
		month := time.Month(rng.Intn(12) + 1)
		day := rng.Intn(daysInMonth(month)) + 1
		dates[i] = time.Date(year, month, day, 0, 0, 0, 0, time.UTC)
	}
	return dates
}

func EstimatedProbability(size int) float64 {
	if size <= 1 {
		return 0
	}

	if size > 365 {
		return 100
	}

	uniqueProbability := 1.0
	for i := range size {
		uniqueProbability *= float64(365-i) / 365
	}
	return (1 - uniqueProbability) * 100
}