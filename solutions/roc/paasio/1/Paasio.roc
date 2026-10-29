Paasio(state, err) :: {
	backend : Backend(state, err),
	read_bytes : U64,
	read_operations : U64,
	write_bytes : U64,
	write_operations : U64,
}.{
	Outcome(state, value, err) : { state : state, result : Try(value, err) }
	Backend(state, err) : {
		state : state,
		read! : state, U64 => Outcome(state, List(U8), err),
		write! : state, List(U8) => Outcome(state, U64, err),
	}
	Stats : {
		read_bytes : U64,
		read_operations : U64,
		write_bytes : U64,
		write_operations : U64,
	}

	create : Backend(state, err) -> Paasio(state, err)
	create = |backend| {
		Paasio({
			backend,
			read_bytes: 0,
			read_operations: 0,
			write_bytes: 0,
			write_operations: 0,
		})
	}

	stats : Paasio(state, err) -> Stats
	stats = |io| {
		{
			read_bytes: io.read_bytes,
			read_operations: io.read_operations,
			write_bytes: io.write_bytes,
			write_operations: io.write_operations,
		}
	}

	get_state : Paasio(state, err) -> state
	get_state = |io| {
		io.backend.state
	}

	read! : Paasio(state, err), U64 => { io : Paasio(state, err), result : Try(List(U8), err) }
	read! = |io, max_bytes| {
		outcome = (io.backend.read!)(io.backend.state, max_bytes)

		read_bytes = when outcome.result is
			Ok(bytes) => io.read_bytes + U64.from_nat(bytes |> List.len)
			Err(_) => io.read_bytes

		{
			io: Paasio({
				backend: { ..io.backend, state: outcome.state },
				read_bytes,
				read_operations: io.read_operations + 1,
				write_bytes: io.write_bytes,
				write_operations: io.write_operations,
			}),
			result: outcome.result,
		}
	}

	write! : Paasio(state, err), List(U8) => { io : Paasio(state, err), result : Try(U64, err) }
	write! = |io, bytes| {
		outcome = (io.backend.write!)(io.backend.state, bytes)

		write_bytes = when outcome.result is
			Ok(count) => io.write_bytes + count
			Err(_) => io.write_bytes

		{
			io: Paasio({
				backend: { ..io.backend, state: outcome.state },
				read_bytes: io.read_bytes,
				read_operations: io.read_operations,
				write_bytes,
				write_operations: io.write_operations + 1,
			}),
			result: outcome.result,
		}
	}
}
