struct Fiberator
    n::Int
end
Base.iterate(f::Fiberator, (seq,n)=((1,1),1)) = n ≤ f.n ? (seq[1], ((seq[2], sum(seq)), n+=1)) : nothing
Base.length(f::Fiberator)::Int = f.n
Base.eltype(::Type{Fiberator})::Type = Int