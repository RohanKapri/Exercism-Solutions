package change

import "core:fmt"
import "core:slice"

Error :: enum {
	None,
	No_Solution_With_Given_Coins,
	Target_Cant_Be_Negative,
	Coins_Cant_Be_Negative_Or_Zero,
	Unimplemented,
}

find_fewest_coins :: proc(coins: []int, target: int) -> ([]int, Error) {
	if target < 0 do return nil, .Target_Cant_Be_Negative
	if target == 0 do return nil, .None
	if len(coins) == 0 do return nil, .No_Solution_With_Given_Coins

	// We will try the highest coin denominations first
	slice.reverse_sort(coins[:])
	if slice.last(coins) <= 0 do return nil, .Coins_Cant_Be_Negative_Or_Zero 

    // We use backtracking to solve this problem
	backtrack :: proc(coins: []int, target: int, path: ^[dynamic]int, change: ^[]int) {
		
		when ODIN_DEBUG do fmt.printfln("coins: %v  target: %d  path: %v  change: %v", coins, target, path^, change^)
		
		if target < 0 {
			// The actual path sum is overflowing the target.
			// There is no need to search further.
			return
		}
		if len(change^) > 0 && len(path^) >= len(change^) {
			// The actual path length is not better than the one already found.
			// There is no need to search for more.
			return
		}
		if target == 0 {
			// Ok we found a new or better(shorter) solution
			if len(change^) == 0 {
				change^ = slice.clone(path[:])
			} else {
				copy(change^, path[:])
				change^ = change[:len(path^)]
			}
			return
		}
		// Let's add more coins on the table (the path) to match the target
		for coin, i in coins {
			append(path, coin)
			defer pop(path)
			backtrack(coins[i:], target - coin, path, change)
		}
	}

	change : []int          // This holds the solution found
	path : [dynamic]int		// This holds the coins on the table trying to find à solution (stack of coins)
	defer delete(path)
	backtrack(coins, target, &path, &change)

	if len(change) == 0 do return nil, .No_Solution_With_Given_Coins	

	// The test needs coins ordered in ascending order
	// Since they are ordered in descending, we only need to reverse
	slice.reverse(change)
	return change, .None
}