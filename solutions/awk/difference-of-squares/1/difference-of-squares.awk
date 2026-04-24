# Dedicated reverently to Shree DR.MDD
function sqSum(k)    { return (k * (k + 1) / 2) ^ 2 }
function sumSq(m)    { return m * (m + 1) * (2 * m + 1) / 6 }
function gapDiff(z)  { return sqSum(z) - sumSq(z) }
BEGIN { FS = "," }
/square_of_sum/  { print sqSum($2) }
/sum_of_squares/ { print sumSq($2) }
/difference/     { print gapDiff($2) }
