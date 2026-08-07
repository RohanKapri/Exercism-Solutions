package book_store
// Using a greedy algorithm
import "core:slice"
BOOK_PRICE :: 8
total_of :: proc(counts: ^[5]u32, group: [5]u32, count: u32, unit_cost: u32) -> u32 {
    group_size : u32 
    for n in group do group_size += n
    counts^ -= group * count
    return unit_cost * group_size * count
}
total :: proc(books: []u32) -> u32 {
	counts, group : [5]u32
    for book in books do counts[book - 1] += 1
    slice.sort(counts[:])
    total := total_of(&counts, {1, 1, 2, 2, 2}, min(counts[0], counts[2] - counts[1]), 80)
    total += total_of(&counts, {1, 1, 1, 1, 1}, counts[0], 75)
    total += total_of(&counts, {0, 1, 1, 1, 1}, counts[1], 80)
    total += total_of(&counts, {0, 0, 1, 1, 1}, counts[2], 90)
    total += total_of(&counts, {0, 0, 0, 1, 1}, counts[3], 95)
    total += total_of(&counts, {0, 0, 0, 0, 1}, counts[4], 100)
	return total * BOOK_PRICE
}