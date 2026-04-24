!NF { exit }

NR == 1 { for (i = NF; i > 0; --i) x[i] = $i }

{ y[NR] = $1; for (i = NF; i > 0; --i) {
    if ($i > y[NR]) y[NR] = $i; if ($i < x[i]) x[i] = $i } }

END { for (i = 1; i <= NF; ++i) for (j = 1; j <= NR; ++j)
        if (x[i] == y[j]) print j " " i }