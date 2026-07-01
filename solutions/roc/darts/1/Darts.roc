module [score]

score : F64, F64 -> U64
score = |x, y|
    # Calculate the distance from the origin (0, 0)
    distance = Num.sqrt(x * x + y * y)
    
    # Determine the score based on the distance
    when distance is
        d if d <= 1.0 -> 10
        d if d <= 5.0 -> 5
        d if d <= 10.0 -> 1
        _ -> 0
    