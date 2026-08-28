function get_transmit_sequence(message)
    isempty(message) && return []
    v = _stream(identity, message, word=8, pad=7)
    UInt8[evalpoly(2, reverse([x; isodd(count(x))]))
        for x in Iterators.partition(v, 7)]
end

function decode_sequence(received_seq)
    isempty(received_seq) && return []
    v = _stream(received_seq, word=7) do x
        c, x = x & 1, x >> 1
        isodd(count_ones(x)) != c && error()
        return x
    end
    UInt8[evalpoly(2, reverse(x))
        for x in Iterators.partition(v, 8) if length(x) == 8]
end

function _stream(f, v::AbstractVector{UInt8}; word=8, pad=0)
    r = BitVector()
    for x in v
        append!(r, reverse(digits(f(x), base=2, pad=word)))
    end
    pad != 0 && append!(r, zeros(mod(pad-length(v), 0:pad-1)))
    return r
end