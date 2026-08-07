package intergalactic_transmission

import "core:math/bits"

transmit_sequence :: proc(msg: []u8) -> (seq: []u8) {
	if len(msg) == 0 {
		return make([]u8, 0)
	}

	total_data_bits := len(msg) * 8
	num_transmissions := (total_data_bits + 6) / 7
	result := make([]u8, num_transmissions)

	buf: u32 = 0
	buf_len: uint = 0 // number of valid bits currently in buf (at the top)
	out_idx: int = 0
	msg_idx: int = 0

	for out_idx < num_transmissions {
		for buf_len < 7 && msg_idx < len(msg) {
			buf |= u32(msg[msg_idx]) << (24 - buf_len)
			buf_len += 8
			msg_idx += 1
		}

		chunk_bits := min(buf_len, 7)
		data7 := u8(buf >> 25) // top 7 bits → positions 6..0
		buf <<= chunk_bits
		buf_len -= chunk_bits

		if chunk_bits < 7 {
			data7 &= ~(u8(0x7f) >> chunk_bits)
		}

		val := data7 << 1
		parity := u8(bits.count_ones(val) % 2)
		result[out_idx] = val | parity
		out_idx += 1
	}

	return result
}

decode_message :: proc(seq: []u8) -> (msg: []u8, okay: bool) {
	if len(seq) == 0 {
		return make([]u8, 0), true
	}

	for b in seq {
		if bits.count_ones(b) % 2 != 0 {
			return nil, false
		}
	}

	num_bytes := (len(seq) * 7) / 8
	result := make([]u8, num_bytes)

	buf: u32 = 0
	buf_len: uint = 0
	out_idx: int = 0

	for b in seq {
		data7 := u32(b >> 1) // 7 data bits, right-aligned
		buf = (buf << 7) | data7
		buf_len += 7

		for buf_len >= 8 && out_idx < num_bytes {
			buf_len -= 8
			result[out_idx] = u8(buf >> buf_len)
			out_idx += 1
		}
	}

	return result, true
}
                 