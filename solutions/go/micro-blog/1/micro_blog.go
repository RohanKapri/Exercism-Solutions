package microblog

func Truncate(phrase string) string {
	runes := []rune(phrase)
	if len(runes) <= 5 {
		return phrase
	}
	return string(runes[:5])
}