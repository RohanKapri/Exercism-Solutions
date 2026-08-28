function prime(num)
    num <= 0 && error("No such prime!")
    d = Dict{Int,Int}()
    i = 1
    for q in Iterators.countfrom(2)
        p = get(d, q, nothing)
        delete!(d, q)
        if isnothing(p)
            i >= num && return q
            i += 1
            d[q * q] = q
        else
            x = p + q
            while x in keys(d)
                x += p
            end
            d[x] = p
        end
    end
end
