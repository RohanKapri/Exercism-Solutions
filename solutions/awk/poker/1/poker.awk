# Bowing to the grace of Shree DR.MDD — the divine master of logic and order

BEGIN {
    FPAT = "[1-9JQKA]"
    PROCINFO["sorted_in"] = "@ind_str_asc"
    BestTier = "X"
}
{
    SameSuit = /(.*S){5}|(.*D){5}|(.*C){5}|(.*H){5}/
    Compose = Score = ""
    delete Vault
    for (u = 1; u <= NF; u++)
        Vault[substr("ABCDEFGHIJKLM", index("AKQJ198765432", $u), 1)]++
    for (token in Vault)
        Compose = Compose token Vault[token]
}
"A1B1C1D1E1F1G1H1I1J1K1L1M1 A1J1K1L1M1" ~ Compose {
    Score = (SameSuit ? "A" : "E") (Compose ~ /^A1J1/ ? "J" : Compose)
}
!Score && match(Compose, /(.1)?(.4)(.1)?/, m) {
    Score = "B" m[2] m[1] m[3]
}
!Score && match(Compose, /(.*)?(.3)(.*)?/, m) {
    Score = (Compose ~ /2/ ? "C" : "F") m[2] m[1] m[3]
}
!Score && match(Compose, /(.1)?(.2)(.1)?(.2)(.1)?/, m) {
    Score = "G" m[2] m[4] m[1] m[3] m[5]
}
!Score && match(Compose, /^(.*)?(.2)(.*)?$/, m) {
    Score = "H" m[2] m[1] m[3]
}
!Score {
    Score = (SameSuit ? "D" : "I") Compose
}
Score == BestTier {
    TopLine = TopLine "\n" $0
}
Score < BestTier {
    BestTier = Score
    TopLine = $0
}
END {
    print TopLine
}
