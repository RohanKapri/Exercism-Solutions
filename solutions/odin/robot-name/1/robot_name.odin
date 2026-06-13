package robotname

import "core:fmt"
import "core:math/rand"
import "core:strings"

NUMBER_COUNT :: 1000
LETTERED_NUMBER_COUNT :: 26 * NUMBER_COUNT
NAME_COUNT :: 26 * LETTERED_NUMBER_COUNT
NAME_ALLOC :: NAME_COUNT + 1
NAME_SIZE :: 5

Robot_Storage :: struct {
    name_bytes : []byte,
    names : []string,
    next_name_pos : int,
    after_last_name_pos : int,
}

Robot :: struct {
	name: string,
}

Error :: enum {
	None,
	Could_Not_Create_Name,
	Unimplemented,
}

make_storage :: proc() -> Robot_Storage {
    // Preallocate all the possible strings
    // The first slice contains all the letters
	name_bytes := make([]byte, NAME_COUNT * NAME_SIZE)
    // The second contains the strings
    names := make([]string, NAME_ALLOC)
    for n in 0..<NAME_COUNT {
        name := name_bytes[n * NAME_SIZE:][:NAME_SIZE]
        init_name(name, n)
        names[n] = string(name)
    }
    // Shuffle the strings
    rand.shuffle(names[:NAME_COUNT])
    return {name_bytes, names, 0, NAME_COUNT}
}

init_name :: proc(name: []byte, n: int) {
    // Fill up the name string bytes 
    // for example, name 0 will be AA000 
    // and the last name will be ZZ999.
    sb := strings.builder_from_bytes(name)
    first_letter := 'A' + n / LETTERED_NUMBER_COUNT
    nn := n % LETTERED_NUMBER_COUNT
    second_letter := 'A' + nn / NUMBER_COUNT
    nnn := nn % NUMBER_COUNT
    fmt.sbprintf(&sb, "%c%c%03d", first_letter, second_letter, nnn)
}

delete_storage :: proc(storage: ^Robot_Storage) {
    delete(storage.names)
    delete(storage.name_bytes)
}

new_name:: proc(storage: ^Robot_Storage) -> (string, Error) {
    // The names is a circular queue
    if storage.next_name_pos == storage.after_last_name_pos {
        return "", .Could_Not_Create_Name
    }
    defer storage.next_name_pos = (storage.next_name_pos + 1) % NAME_ALLOC
    return storage.names[storage.next_name_pos], .None
}

new_robot :: proc(storage: ^Robot_Storage) -> (r: Robot, e: Error) {
	r.name, e = new_name(storage)
	return
}

reset :: proc(storage: ^Robot_Storage, r: ^Robot) {
    if r.name != "" {
        // Return name to the name pool, at the end of the circular queue, 
        // which is not completely "random"
        // We assume the name is correct and comes from the storage.
        storage.names[storage.after_last_name_pos] = r.name
        storage.after_last_name_pos = (storage.after_last_name_pos + 1) % NAME_ALLOC
    }
    // This should not fail if the name was fine and returned to the pool
    r.name, _ = new_name(storage)
}
