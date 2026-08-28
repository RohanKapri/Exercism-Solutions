package affinecipher

import (
	"errors"
	"math/big"
	"strings"
	"unicode"
)

const m = 26

var errNotCoprime = errors.New("a and 26 are not coprime")

func gcd(a, b int) int {
	return int(new(big.Int).GCD(nil, nil, big.NewInt(int64(a)), big.NewInt(int64(b))).Int64())
}

func modInverse(a, mod int) int {
	for i := 1; i < mod; i++ {
		if (a*i)%mod == 1 {
			return i
		}
	}
	return 1
}

func mod(a, b int) int {
	r := a % b
	if r < 0 {
		r += b
	}
	return r
}

func Encode(text string, a, b int) (string, error) {
	if gcd(a, m) != 1 {
		return "", errNotCoprime
	}

	var sb strings.Builder
	count := 0
	for _, c := range text {
		if unicode.IsLetter(c) {
			if count > 0 && count%5 == 0 {
				sb.WriteByte(' ')
			}
			sb.WriteByte(byte(((a*(int(unicode.ToLower(c)-'a')) + b) % m) + 'a'))
			count++
		} else if unicode.IsDigit(c) {
			if count > 0 && count%5 == 0 {
				sb.WriteByte(' ')
			}
			sb.WriteRune(c)
			count++
		}
	}
	return sb.String(), nil
}

func Decode(text string, a, b int) (string, error) {
	if gcd(a, m) != 1 {
		return "", errNotCoprime
	}

	mmi := modInverse(a, m)

	var sb strings.Builder
	for _, c := range text {
		if unicode.IsLetter(c) {
			sb.WriteByte(byte(mod(mmi*(int(c-'a')-b), m) + 'a'))
		} else if unicode.IsDigit(c) {
			sb.WriteRune(c)
		}
	}
	return sb.String(), nil
}