package forth

import "base:runtime"

Error :: enum {
	None,
	Cant_Nest_Definitions,
	Cant_Redefine_Compilation_Word,
	Cant_Redefine_Number,
	Divide_By_Zero,
	Incomplete_Definition,
	Stack_Underflow,
	Unknown_Word,
	Unimplemented,
}

Builtin :: enum u8 {
	Add,
	Sub,
	Mul,
	Div,
	Dup,
	Drop,
	Swap,
	Over,
}

Op_Kind :: enum u8 { Push, Builtin }

Op :: struct #raw_union {
	push:    int,
	builtin: Builtin,
}

Word_Body :: struct {
	kinds: []Op_Kind,
	ops:   []Op,
}

Dict_Entry :: struct {
	name: string,
	body: Word_Body,
}

@(private="file")
ascii_lower_byte :: #force_inline proc(b: byte) -> byte {
	if b >= 'A' && b <= 'Z' do return b + 32
	return b
}

@(private="file")
token_eq_lower :: #force_inline proc(token, lower_ref: string) -> bool {
	if len(token) != len(lower_ref) do return false
	for i in 0..<len(token) {
		if ascii_lower_byte(token[i]) != lower_ref[i] do return false
	}
	return true
}

@(private="file")
parse_int_fast :: #force_inline proc(s: string) -> (val: int, ok: bool) {
	if len(s) == 0 do return 0, false
	neg := false
	i := 0
	if s[0] == '-' {
		neg = true
		i = 1
		if i >= len(s) do return 0, false
	}
	for ; i < len(s); i += 1 {
		d := s[i]
		if d < '0' || d > '9' do return 0, false
		val = val * 10 + int(d - '0')
	}
	if neg do val = -val
	return val, true
}

@(private="file")
is_number_token :: #force_inline proc(s: string) -> bool {
	_, ok := parse_int_fast(s)
	return ok
}

@(private="file")
dict_lookup :: proc(dict: []Dict_Entry, token: string) -> (Word_Body, bool) {
	for i := len(dict) - 1; i >= 0; i -= 1 {
		if token_eq_lower(token, dict[i].name) {
			return dict[i].body, true
		}
	}
	return {}, false
}

@(private="file")
builtin_for_lower :: #force_inline proc(s: string) -> (Builtin, bool) {
	switch s {
	case "+":    return .Add,  true
	case "-":    return .Sub,  true
	case "*":    return .Mul,  true
	case "/":    return .Div,  true
	case "dup":  return .Dup,  true
	case "drop": return .Drop, true
	case "swap": return .Swap, true
	case "over": return .Over, true
	}
	return .Add, false
}

STACK_CAP :: 256

@(private="file")
VM :: struct {
	data:  [STACK_CAP]int,
	top:   int, // number of live elements
}

@(private="file")
vm_push :: #force_inline proc(vm: ^VM, v: int) {
	vm.data[vm.top] = v
	vm.top += 1
}

@(private="file")
vm_pop :: #force_inline proc(vm: ^VM) -> int {
	vm.top -= 1
	return vm.data[vm.top]
}

@(private="file")
execute_body :: proc(body: Word_Body, vm: ^VM) -> Error {
	for i in 0..<len(body.kinds) {
		switch body.kinds[i] {
		case .Push:
			if vm.top >= STACK_CAP do return .Stack_Underflow // reuse for overflow safety
			vm_push(vm, body.ops[i].push)
		case .Builtin:
			switch body.ops[i].builtin {
			case .Add:
				if vm.top < 2 do return .Stack_Underflow
				b := vm_pop(vm); a := vm_pop(vm)
				vm_push(vm, a + b)
			case .Sub:
				if vm.top < 2 do return .Stack_Underflow
				b := vm_pop(vm); a := vm_pop(vm)
				vm_push(vm, a - b)
			case .Mul:
				if vm.top < 2 do return .Stack_Underflow
				b := vm_pop(vm); a := vm_pop(vm)
				vm_push(vm, a * b)
			case .Div:
				if vm.top < 2 do return .Stack_Underflow
				b := vm_pop(vm); a := vm_pop(vm)
				if b == 0 do return .Divide_By_Zero
				vm_push(vm, a / b)
			case .Dup:
				if vm.top < 1 do return .Stack_Underflow
				vm_push(vm, vm.data[vm.top - 1])
			case .Drop:
				if vm.top < 1 do return .Stack_Underflow
				vm.top -= 1
			case .Swap:
				if vm.top < 2 do return .Stack_Underflow
				vm.data[vm.top-1], vm.data[vm.top-2] = vm.data[vm.top-2], vm.data[vm.top-1]
			case .Over:
				if vm.top < 2 do return .Stack_Underflow
				vm_push(vm, vm.data[vm.top - 2])
			}
		}
	}
	return .None
}

@(private="file")
Token_Iterator :: struct {
	s:   string,
	pos: int,
}

@(private="file")
next_token :: proc(it: ^Token_Iterator) -> (token: string, ok: bool) {
	s := it.s
	n := len(s)
	
	for it.pos < n && (s[it.pos] == ' ' || s[it.pos] == '\t' || s[it.pos] == '\r' || s[it.pos] == '\n') {
		it.pos += 1
	}
	if it.pos >= n do return "", false
	start := it.pos
	for it.pos < n && s[it.pos] != ' ' && s[it.pos] != '\t' && s[it.pos] != '\r' && s[it.pos] != '\n' {
		it.pos += 1
	}
	return s[start:it.pos], true
}

LOWER_BUF_CAP :: 64

@(private="file")
token_to_lower_buf :: proc(token: string, buf: []byte) -> string {
	n := min(len(token), len(buf))
	for i in 0..<n {
		buf[i] = ascii_lower_byte(token[i])
	}
	return string(buf[:n])
}

@(private="file")
compile_token :: proc(
	token:    string,
	dict:     []Dict_Entry,
	out_k:    ^[dynamic]Op_Kind,
	out_op:   ^[dynamic]Op,
	lower_buf: []byte,
) -> Error {
	lower := token_to_lower_buf(token, lower_buf)

	if val, ok := parse_int_fast(lower); ok {
		op: Op; op.push = val
		append(out_k, Op_Kind.Push)
		append(out_op, op)
		return .None
	}

	if body, ok := dict_lookup(dict, lower); ok {
		for i in 0..<len(body.kinds) {
			append(out_k, body.kinds[i])
			append(out_op, body.ops[i])
		}
		return .None
	}

	if b, ok := builtin_for_lower(lower); ok {
		op: Op; op.builtin = b
		append(out_k, Op_Kind.Builtin)
		append(out_op, op)
		return .None
	}

	return .Unknown_Word
}

evaluate :: proc(input: ..string) -> (output: []int, error: Error) {
	dict := make([dynamic]Dict_Entry)
	defer {
		for entry in dict {
			delete(entry.name)
			delete(entry.body.kinds)
			delete(entry.body.ops)
		}
		delete(dict)
	}

	vm: VM

	lower_buf: [LOWER_BUF_CAP]byte

	for line in input {
		it := Token_Iterator{s = line}

		for {
			token, ok := next_token(&it)
			if !ok do break

			lower := token_to_lower_buf(token, lower_buf[:])

			if lower == ":" {
				name_tok, name_ok := next_token(&it)
				if !name_ok do return nil, .Incomplete_Definition

				name_lower := make([]byte, len(name_tok))
				for i in 0..<len(name_tok) {
					name_lower[i] = ascii_lower_byte(name_tok[i])
				}
				word_name := string(name_lower)

				if is_number_token(word_name) {
					delete(name_lower)
					return nil, .Cant_Redefine_Number
				}

				body_k  := make([dynamic]Op_Kind)
				body_op := make([dynamic]Op)
				found_semi := false

				for {
					btok, bok := next_token(&it)
					if !bok do break
					if token_eq_lower(btok, ";") {
						found_semi = true
						break
					}
					err := compile_token(btok, dict[:], &body_k, &body_op, lower_buf[:])
					if err != .None {
						delete(name_lower)
						delete(body_k)
						delete(body_op)
						return nil, err
					}
				}

				if !found_semi {
					delete(name_lower)
					delete(body_k)
					delete(body_op)
					return nil, .Incomplete_Definition
				}

				append(&dict, Dict_Entry{
					name = word_name,
					body = Word_Body{kinds = body_k[:], ops = body_op[:]},
				})
			} else {
				local_k:  [8]Op_Kind
				local_op: [8]Op
				k_raw  := runtime.Raw_Dynamic_Array{data = &local_k[0],  len = 0, cap = 8, allocator = context.allocator}
				op_raw := runtime.Raw_Dynamic_Array{data = &local_op[0], len = 0, cap = 8, allocator = context.allocator}
				k_dyn  := transmute([dynamic]Op_Kind)(k_raw)
				op_dyn := transmute([dynamic]Op)     (op_raw)

				err := compile_token(token, dict[:], &k_dyn, &op_dyn, lower_buf[:])
				if err != .None do return nil, err

				body := Word_Body{kinds = k_dyn[:], ops = op_dyn[:]}
				err = execute_body(body, &vm)
				if err != .None do return nil, err
			}
		}
	}

	output = make([]int, vm.top)
	copy(output, vm.data[:vm.top])
	return output, .None
}
            