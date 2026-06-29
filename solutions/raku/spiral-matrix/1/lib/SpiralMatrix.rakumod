sub fill-turn ($row, $step is rw, @m) {
    @m[$row;$_] = $step++ unless @m[$row;$_] for ^@m;
    @m          = reverse map *.Array, [Z] @m;
}

sub spiral-matrix ($n, $first-step = 1) is export {
    return [] unless $n;
    my ($row, $step, @m) = 0, $first-step, |[[Any xx $n] xx $n];
    fill-turn $row++ div 4, $step, @m until $step > $n² and @m[0;0] == $first-step;
    return @m;
}