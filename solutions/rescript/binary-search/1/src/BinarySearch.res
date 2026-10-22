let rec search = (haystack, needle, begin, end) =>
    if begin === end {
        None
    } else {
        let middle = (begin + end) / 2
        switch (haystack[middle]) {
            | None => None
            | Some(entry) if needle < entry => search(haystack, needle, begin, middle)
            | Some(entry) if needle > entry => search(haystack, needle, middle + 1, end)
            | Some(entry) => Some(middle)
        }
    }
let find = (haystack, needle) => search(haystack, needle, 0, Array.length(haystack))
