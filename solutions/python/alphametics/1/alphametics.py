""""Solve the alphametics puzzle."""
from itertools import permutations

def check_solution(lhs, rhs, solution):
    """Check if the solution is correct for the given puzzle."""
    for letter, value in solution.items():
        lhs = lhs.replace(letter, str(value))

    #exit early if any of the operands has a leading zero
    ops = [int(op) for op in lhs.split("+") if len(op) > 1 and op.strip()[0] != '0']
    if not ops:
        return False

    for letter, value in solution.items():
        rhs = rhs.replace(letter, str(value))

    #exit early if the result has a leading zero
    if len(rhs) > 1 and rhs[0] == '0':
        return False

    result = sum(ops) == int(rhs) #test validity of the solution

    return result

def solve(puzzle):
    """Solve the alphametic puzzle and return the solution as a mapping of letters to digits."""
    letters = { c for c in puzzle if c.isalpha() }
    lhs, rhs = puzzle.split("==")
    rhs = rhs.strip()

    for comb in permutations(range(10), len(letters)):
        if check_solution(lhs, rhs, dict(zip(letters, comb))):
            #return as soon as valid solution is found
            return dict(zip(letters, comb))

    return None