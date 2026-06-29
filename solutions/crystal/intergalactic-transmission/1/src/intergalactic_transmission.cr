class IntergalacticTransmission
  def self.transmit_sequence(message : Array(Int32)) : Array(Int32)
    return [] of Int32 if message.empty?

    input_bit_count = message.size * 8
    buffer_size = (input_bit_count + 6) // 7
    buffer = Array.new(buffer_size, 0)

    output_byte_index = 0
    output_bit_in_byte = 7
    parity_bit = 0
    bits_in_current_byte = 0

    (0...input_bit_count).each do |i|
      input_byte = i // 8
      input_bit = 7 - (i % 8)
      bit = (message[input_byte] >> input_bit) & 1

      if bit != 0
        buffer[output_byte_index] |= (1 << output_bit_in_byte)
      end
      output_bit_in_byte -= 1
      bits_in_current_byte += 1
      parity_bit ^= bit

      if bits_in_current_byte == 7
        if parity_bit != 0
          buffer[output_byte_index] |= 1
        end
        output_byte_index += 1
        output_bit_in_byte = 7
        bits_in_current_byte = 0
        parity_bit = 0
      end
    end

    if bits_in_current_byte > 0
      output_bit_in_byte = 0
      if parity_bit != 0
        buffer[output_byte_index] |= 1
      end
    end

    buffer
  end

  def self.decode_message(transmission : Array(Int32)) : Array(Int32)
    return [] of Int32 if transmission.empty?

    buffer_size = (transmission.size * 8) // 9
    buffer = Array.new(buffer_size, 0)

    output_byte_index = 0
    output_bit_in_byte = 7

    transmission.each do |byte|
      parity = 0

      parity_bit = byte & 1

      (7).downto(1) do |bit_pos|
        bit = (byte >> bit_pos) & 1
        parity ^= bit
      end

      raise ArgumentError.new if parity_bit != parity

      (7).downto(1) do |bit_pos|
        bit = (byte >> bit_pos) & 1

        if bit != 0
          buffer[output_byte_index] |= (1 << output_bit_in_byte)
        end
        output_bit_in_byte -= 1
        if output_bit_in_byte < 0
          output_byte_index += 1
          output_bit_in_byte = 7
        end
      end
    end

    buffer
  end
end