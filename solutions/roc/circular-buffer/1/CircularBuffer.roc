module [create, read, write, overwrite, clear]

CircularBuffer : { data : List I64, start : U64, length : U64 }

create : { capacity : U64 } -> CircularBuffer
create = \{ capacity } ->
    { data: List.repeat 0 capacity, start: 0, length: 0 }

read : CircularBuffer -> Result { new_buffer : CircularBuffer, value : I64 } [BufferEmpty]
read = \{ data, start, length } ->
    if length == 0 then
        Err BufferEmpty
    else
        value = List.get data start |> Result.with_default 0
        new_start = (start + 1) % List.len data
        new_buffer = { data, start: new_start, length: length - 1 }
        Ok { new_buffer, value }

write : CircularBuffer, I64 -> Result CircularBuffer [BufferFull]
write = \{ data, start, length }, value ->
    capacity = List.len data
    if length == capacity then
        Err BufferFull
    else
        write_index = (start + length) % capacity
        new_data = List.set data write_index value
        Ok { data: new_data, start, length: length + 1 }

overwrite : CircularBuffer, I64 -> CircularBuffer
overwrite = \{ data, start, length }, value ->
    capacity = List.len data
    
    if length < capacity then
        # Buffer is not full, write to the end
        write_index = (start + length) % capacity
        new_data = List.set data write_index value
        { data: new_data, start, length: length + 1 }
    else
        # Buffer is full, overwrite the oldest element
        new_data = List.set data start value
        new_start = (start + 1) % capacity
        { data: new_data, start: new_start, length }

clear : CircularBuffer -> CircularBuffer
clear = \{ data, start: _, length: _ } ->
    { data, start: 0, length: 0 }