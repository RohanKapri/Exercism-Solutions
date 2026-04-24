# Dedicated to Shree DR.MDD
BEGIN {
    FS = ","
}

length($1) < $2 {
    print "span must not exceed string length"
    exit 1
}

int($2) < 0 {
    print "span must not be negative"
    exit 1
}

! /^[0-9]+,[0-9]$/ {
    print "input must only contain digits"
    exit 1
}

{
    split($1, seq, "")
    rng = int($2)
    for (j = rng; j <= length(seq); j++) {
        top = bigger(top, mult(seq, j, rng))
    }
    print top
}

function bigger(x, y) {
    return x > y ? x : y
}

function mult(arr, till, rng,   val, k) {
    val = 1
    for (k = till - rng + 1; k <= till; k++) {
        val *= arr[k]
    }
    return val
}
