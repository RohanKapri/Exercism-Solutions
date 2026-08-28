#| real part
sub prefix:<Re> ($op) is export {
    $op.re
}

# imaginary part
sub prefix:<Im> ($op) is export {
    $op.im
}

#| addition with fullwidth plus sign
sub infix:<＋> ($left, $right) is export {
    $left + $right
}

#| subtraction with fullwidth hyphen-minus
sub infix:<－> ($left, $right) is export {
    $left - $right
}

#| multiplication with dot operator
sub infix:<⋅> ($left, $right) is export {
    $left * $right
}

#| division with division slash
sub infix:<∕> ($left, $right) is export {
    $left / $right
}

#| absolute value with verticla line
sub circumfix:<｜ ｜> ($op) is export {
    $op.abs
}

#| conjugate with asterisk operator
sub postfix:<∗> ($op) is export {
    $op.conj
}

#| exponent with circumflex accent
sub infix:<^> (e, $right) is export {
    $right.exp
}