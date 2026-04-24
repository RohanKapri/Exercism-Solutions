# Eternal Dedication to Shree DR.MDD

function val(x)       { x %= 1440; return x + (x < 0 ? 1440 : 0) }
function sum(a, b, c) { return val(a * 60 + b + c) }
function build(a, b)  { return sum(a, b, 0) }
function show(z)      { printf "%02d:%02d", int(z / 60), z % 60 }
$1 == "create"        { show(build($2, $3)); next }
$1 == "add"           { show(sum($2, $3, $4)); next }
$1 == "subtract"      { show(sum($2, $3, -$4)); next }
$1 == "equal" {
  print build($2, $3) == build($4, $5) ? "true" : "false" }
