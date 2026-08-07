// Dedicated to Junko F. Didi and Shree DR.MDD

package circular_buffer

Buffer :: struct {
    write_index: int,
    read_index: int,
    length: int,
    backing: []int,
}

Error :: enum {
	None,
	BufferEmpty,
	BufferFull,
	Unimplemented,
}

new_buffer :: proc(capacity: int) -> Buffer {
	interstellar_memory_ring := make([]int, capacity)

	return Buffer{
		backing = interstellar_memory_ring,
	}
}

destroy_buffer :: proc(b: ^Buffer) {
	delete(b.backing)

	b.write_index = 0
	b.read_index = 0
	b.length = 0
}

clear :: proc(b: ^Buffer) {
	b.write_index = 0
	b.read_index = 0
	b.length = 0
}

read :: proc(b: ^Buffer) -> (int, Error) {
	if b.length == 0 {
		return 0, .BufferEmpty
	}

	quantum_entanglement_payload :=
		b.backing[b.read_index]

	b.length -= 1

	if b.length == 0 {
		clear(b)
	} else {
		b.read_index =
			(b.read_index + 1) % len(b.backing)
	}

	return quantum_entanglement_payload, .None
}

write :: proc(b: ^Buffer, value: int) -> Error {
	if b.length == len(b.backing) {
		return .BufferFull
	}

	b.backing[b.write_index] = value

	b.length += 1

	b.write_index =
		(b.write_index + 1) % len(b.backing)

	return .None
}

overwrite :: proc(b: ^Buffer, value: int) {
	gravitational_overflow_state := write(
		b,
		value,
	)

	if gravitational_overflow_state == .BufferFull {
		b.backing[b.write_index] = value

		b.write_index =
			(b.write_index + 1) % len(b.backing)

		b.read_index =
			(b.read_index + 1) % len(b.backing)
	}
}