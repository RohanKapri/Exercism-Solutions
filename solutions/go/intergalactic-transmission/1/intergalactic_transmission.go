package intergalactictransmission

import "fmt"

func writeBit(buffer []byte, bitIndex int, bit uint8) {
	byteIdx := bitIndex / 8
	bitInByte := bitIndex % 8
	buffer[byteIdx] &= ^(1 << bitInByte)
	buffer[byteIdx] |= (bit << bitInByte)
}

func readBit(buffer []byte, bitIndex int) uint8 {
	byteIdx := bitIndex / 8
	bitInByte := bitIndex % 8
	if (buffer[byteIdx] & (1 << bitInByte)) != 0 {
		return 1
	}
	return 0
}

func Transmit(message []byte) []byte {
	if len(message) == 0 {
		return []byte{}
	}

	inputBitCount := len(message) * 8
	bufferSize := (inputBitCount / 7)
	if inputBitCount%7 != 0 {
		bufferSize++
	}

	buffer := make([]byte, bufferSize)
	outputByteIndex := 0
	outputBitInByte := 7
	parityBit := uint8(0)
	bitsInCurrentByte := 0

	for i := 0; i < inputBitCount; i++ {
		inputByte := i / 8
		inputBit := 7 - (i % 8)
		bit := (message[inputByte] >> inputBit) & 1

		if bit != 0 {
			buffer[outputByteIndex] |= (1 << outputBitInByte)
		}
		outputBitInByte--
		bitsInCurrentByte++
		parityBit ^= bit

		if bitsInCurrentByte == 7 {
			if parityBit != 0 {
				buffer[outputByteIndex] |= 1
			}
			outputByteIndex++
			outputBitInByte = 7
			bitsInCurrentByte = 0
			parityBit = 0
		}
	}

	if bitsInCurrentByte > 0 {
		outputBitInByte = 0
		if parityBit != 0 {
			buffer[outputByteIndex] |= 1
		}
	}

	return buffer
}

func Decode(message []byte) ([]byte, error) {
	if len(message) == 0 {
		return []byte{}, nil
	}

	bufferSize := (len(message) * 8) / 9
	buffer := make([]byte, bufferSize)

	outputByteIndex := 0
	outputBitInByte := 7

	for byteIdx := 0; byteIdx < len(message); byteIdx++ {
		parity := uint8(0)

		parityBit := message[byteIdx] & 1

		for bitPos := 7; bitPos >= 1; bitPos-- {
			bit := (message[byteIdx] >> bitPos) & 1
			parity ^= bit
		}

		if parityBit != parity {
			return nil, fmt.Errorf("wrong parity")
		}

		for bitPos := 7; bitPos >= 1; bitPos-- {
			bit := (message[byteIdx] >> bitPos) & 1

			if bit != 0 {
				buffer[outputByteIndex] |= (1 << outputBitInByte)
			}
			outputBitInByte--
			if outputBitInByte < 0 {
				outputByteIndex++
				outputBitInByte = 7
			}
		}
	}

	return buffer, nil
}