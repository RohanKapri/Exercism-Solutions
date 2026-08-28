function gamestate(board)
    s = stack(board)
    x = s .== 'X'
    o = s .== 'O'
    count(x)-count(o) ∉ 0:1 && error()
    d1, d2 = [1,5,9], [3,5,7]
    xwin = any(all(x, dims=1)) || any(all(x, dims=2)) ||
        all(x[d1]) || all(x[d2])
    owin = any(all(o, dims=1)) || any(all(o, dims=2)) ||
        all(o[d1]) || all(o[d2])
    (xwin && owin) && error()
    (xwin || owin) && return "win"
    all(s .!= ' ') && return "draw"
    return "ongoing"
end