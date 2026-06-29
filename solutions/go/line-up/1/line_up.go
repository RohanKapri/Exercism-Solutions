package lineup

import "fmt"

func ordinal(number int) string {
	if number%100 != 11 && number%10 == 1 {
		return fmt.Sprintf("%dst", number)
	}

	if number%100 != 12 && number%10 == 2 {
		return fmt.Sprintf("%dnd", number)
	}

	if number%100 != 13 && number%10 == 3 {
		return fmt.Sprintf("%drd", number)
	}

	return fmt.Sprintf("%dth", number)
}

func Format(name string, number int) string {
	return fmt.Sprintf("%s, you are the %s customer we serve today. Thank you!", name, ordinal(number))
}