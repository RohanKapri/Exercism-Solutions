all_15(ratings) = all(r -> r ∈ (1, 5), ratings)

emphatics(customers) = filter(c -> all_15(c.second), customers)

tobinary(ratings) = map(r -> r == 1 ? 0 : 1, ratings)

tobinarymatrix(ratings) = mapreduce(row -> tobinary(row), hcat, ratings) |> transpose