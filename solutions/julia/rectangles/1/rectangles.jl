function connectedcorners(strmatrix, invalid = " |")
    corners = []
    for column in 1:size(strmatrix, 2)
        connected = Set()
        for row_a in 1:size(strmatrix, 1)-1
            if strmatrix[row_a, column] == '+'
                for row_b in row_a+1:size(strmatrix, 1)
                    occursin(strmatrix[row_b, column], invalid) && break
                    strmatrix[row_b, column] == '+' && push!(connected, (row_a, row_b))
                end
            end
        end
        push!(corners, connected)
    end
    corners
end

function rectangles(strings)
    isempty(strings) && return 0
    strmatrix = stack(strings, dims=1)
    horiz = connectedcorners(permutedims(strmatrix))
    vert = connectedcorners(strmatrix, " -")

    n = 0
    for col_a in 1:length(vert)-1
        for col_b in col_a+1:length(vert)
            sides = intersect(vert[col_a], vert[col_b])
            if !isempty(sides)
                n += sum((col_a, col_b) ∈ intersect(horiz[row_a], horiz[row_b]) for (row_a, row_b) in sides)
            end
        end
    end
    n
end