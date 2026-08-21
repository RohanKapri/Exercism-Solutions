# alphametics.awk

{
    puzzle = $0
    gsub(/==/, "=", puzzle)
    
    # Reset tracking arrays for each puzzle line
    delete words
    delete no_zero
    delete weights
    delete letters
    delete assignment
    delete used_digits
    delete seen_letter
    
    # 1. Extract all unique words and identify leading characters
    n_words = 0
    clean_line = puzzle
    gsub(/[^A-Z ]/, " ", clean_line)
    split(clean_line, words_array, / +/)
    for (i in words_array) {
        if (words_array[i] != "") {
            n_words++
            words[n_words] = words_array[i]
        }
    }
    
    for (i = 1; i <= n_words; i++) {
        lead = substr(words[i], 1, 1)
        no_zero[lead] = 1
    }
    
    # 2. Extract every unique letter present in the puzzle
    n_letters = 0
    for (i = 1; i <= n_words; i++) {
        len = length(words[i])
        for (j = 1; j <= len; j++) {
            char = substr(words[i], j, 1)
            if (!seen_letter[char]) {
                seen_letter[char] = 1
                n_letters++
                letters[n_letters] = char
            }
        }
    }
    
    # Alphametics puzzles cannot have more than 10 unique digits
    if (n_letters > 10) {
        print ""
        next
    }
    
    # 3. Calculate algebraic weights for LHS and RHS expressions
    split(puzzle, equations, "=")
    
    # Process left-hand side words (positive weights)
    split(equations[1], lhs_parts, "+")
    for (p in lhs_parts) {
        add_weights(lhs_parts[p], 1)
    }
    
    # Process right-hand side words (negative weights)
    split(equations[2], rhs_parts, "+")
    for (p in rhs_parts) {
        add_weights(rhs_parts[p], -1)
    }
    
    # 4. Sort letters by absolute weight size to maximize backtracking branch-pruning
    for (i = 1; i < n_letters; i++) {
        for (j = i + 1; j <= n_letters; j++) {
            if (abs(weights[letters[i]]) < abs(weights[letters[j]])) {
                tmp = letters[i]
                letters[i] = letters[j]
                letters[j] = tmp
            }
        }
    }
    
    # 5. Initialize digit pool and solve via DFS Backtracking
    for (i = 0; i <= 9; i++) used_digits[i] = 0
    
    found = backtrack(1, 0)
    
    # 6. Print space-separated format sorted alphabetically (A-Z)
    if (found) {
        out = ""
        for (c = 65; c <= 90; c++) {
            char = sprintf("%c", c)
            if (char in assignment) {
                out = out char "=" assignment[char] " "
            }
        }
        sub(/ $/, "", out) # Clean trailing space
        print out
    } else {
        print ""
    }
}

# Helper to precompute character decimal coefficients
function add_weights(word, sign,    w, len, i, char, multiplier) {
    gsub(/[^A-Z]/, "", word)
    len = length(word)
    multiplier = 1
    for (i = len; i >= 1; i--) {
        char = substr(word, i, 1)
        weights[char] += sign * multiplier
        multiplier *= 10
    }
}

function abs(x) {
    return x < 0 ? -x : x
}

# Backtracking search function
function backtrack(idx, current_sum,    char, weight, d) {
    if (idx > n_letters) {
        return (current_sum == 0)
    }
    
    char = letters[idx]
    weight = weights[char]
    
    for (d = 0; d <= 9; d++) {
        if (!used_digits[d]) {
            # Prevent leading zeroes
            if (d == 0 && no_zero[char]) {
                continue
            }
            
            # Prune at the final leaf index
            if (idx == n_letters) {
                if (current_sum + d * weight == 0) {
                    assignment[char] = d
                    return 1
                }
                continue
            }
            
            used_digits[d] = 1
            assignment[char] = d
            
            if (backtrack(idx + 1, current_sum + d * weight)) {
                return 1
            }
            
            # Backtrack
            used_digits[d] = 0
            delete assignment[char]
        }
    }
    return 0
}