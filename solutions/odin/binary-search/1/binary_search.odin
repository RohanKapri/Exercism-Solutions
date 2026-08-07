package binary_search

find :: proc(haystack: []$T, needle: T) -> (index: int, found: bool) #optional_ok {
	left := 0
	right := len(haystack) - 1

	for left <= right {
		mid := left + (right-left)/2

		if haystack[mid] == needle {
			return mid, true
		} else if haystack[mid] < needle {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return 0, false
}