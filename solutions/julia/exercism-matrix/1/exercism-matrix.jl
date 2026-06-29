const E = [
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
    0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
    0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
]

function frown!(E)
    E[7,:],E[9,:]=E[9,:],E[7,:]
    return E
end

function frown(E)
    E_frown=copy(E)
    E_frown[7,:],E_frown[9,:]=E[9,:],E[7,:]
    return E_frown
end

function stickerwall(E)
    wall=ones(1,36)
    sticker=[E frown(E);wall;frown(E) E]
    return sticker
end

function colpixelcount(E)
    EE=copy(E).*sum(E,dims=1)
    return EE
end

function render(E)
    vec=[]
    for i in eachrow(E)
        for j in eachindex(i)
            if i[j] == 0
                push!(vec,' ')
            else
                push!(vec,'X')
            end
        end
        push!(vec,'\n')
    end
    pop!(vec)
    return join(vec)
end