using LinearAlgebra

function orientrobot(vecs)
    balance = norm.(vecs)
    len = length(vecs)
    base = Vector{Vector{Number}}(undef,len)
    for i in 1:len
        base[i] = vecs[i] ./ balance[i]
    end
    return reduce(hcat,base)
end

function rotaterobot(orientation, θ)
    pivot = [cos(θ) -sin(θ); sin(θ) cos(θ)]
    return pivot * orientation
end

function robotoriented(orientation, direction)
    treated = direction ./ norm(direction)
    return orientation[:, 2] ≈ treated
end

function bodylocation(orientation, position)
    return orientation .+ position
end