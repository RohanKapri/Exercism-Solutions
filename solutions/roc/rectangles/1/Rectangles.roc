module [rectangles]

rectangles : Str -> U64
rectangles = \diagram ->
    # Split into lines and remove empty lines
    lines = 
        diagram
        |> Str.split_on "\n"
        |> List.drop_if Str.is_empty
    
    if List.is_empty lines then
        0
    else
        # Find all '+' positions
        plusPositions = findPlusPositions lines
        
        # Count valid rectangles
        countRectangles lines plusPositions

findPlusPositions : List Str -> List (U64, U64)
findPlusPositions = \lines ->
    List.walk_with_index lines [] \positions, line, rowIndex ->
        line
        |> Str.to_utf8
        |> List.walk_with_index positions \innerPositions, byte, colIndex ->
            if byte == '+' then
                List.append innerPositions (Num.to_u64 rowIndex, Num.to_u64 colIndex)
            else
                innerPositions

countRectangles : List Str, List (U64, U64) -> U64
countRectangles = \lines, positions ->
    List.walk positions 0 \count, (r1, c1) ->
        List.walk positions count \innerCount, (r2, c2) ->
            if r2 > r1 && c2 > c1 && isValidRectangle lines r1 c1 r2 c2 then
                innerCount + 1
            else
                innerCount

isValidRectangle : List Str, U64, U64, U64, U64 -> Bool
isValidRectangle = \lines, topRow, leftCol, bottomRow, rightCol ->
    # Check all four corners are '+'
    topLeftOk = checkChar lines topRow leftCol '+'
    topRightOk = checkChar lines topRow rightCol '+'
    bottomLeftOk = checkChar lines bottomRow leftCol '+'
    bottomRightOk = checkChar lines bottomRow rightCol '+'
    
    if topLeftOk && topRightOk && bottomLeftOk && bottomRightOk then
        # Check edges
        topEdge = checkHorizontalEdge lines topRow leftCol rightCol
        bottomEdge = checkHorizontalEdge lines bottomRow leftCol rightCol
        leftEdge = checkVerticalEdge lines topRow bottomRow leftCol
        rightEdge = checkVerticalEdge lines topRow bottomRow rightCol
        
        topEdge && bottomEdge && leftEdge && rightEdge
    else
        Bool.false

checkChar : List Str, U64, U64, U8 -> Bool
checkChar = \lines, row, col, expectedChar ->
    rowNat = Num.int_cast row
    colNat = Num.int_cast col
    when List.get lines rowNat is
        Ok line ->
            when List.get (Str.to_utf8 line) colNat is
                Ok char -> char == expectedChar
                Err _ -> Bool.false
        Err _ -> Bool.false

checkHorizontalEdge : List Str, U64, U64, U64 -> Bool
checkHorizontalEdge = \lines, row, startCol, endCol ->
    startNat = Num.int_cast (startCol + 1)
    endNat = Num.int_cast endCol
    List.range { start: At startNat, end: Before endNat }
    |> List.all \colNat ->
        col = Num.to_u64 colNat
        checkChar lines row col '-' || checkChar lines row col '+'

checkVerticalEdge : List Str, U64, U64, U64 -> Bool
checkVerticalEdge = \lines, startRow, endRow, col ->
    startNat = Num.int_cast (startRow + 1)
    endNat = Num.int_cast endRow
    List.range { start: At startNat, end: Before endNat }
    |> List.all \rowNat ->
        row = Num.to_u64 rowNat
        checkChar lines row col '|' || checkChar lines row col '+'
             