class ParallelLetterFrequency
  def self.calculate_frequencies(input : Array(String)) : Hash(String, Int32)
    channel = Channel(Hash(String, Int32)).new

    input.each do |text|
      spawn do
        counts = Hash(String, Int32).new(0)

        text.each_char do |char|
          counts[char.downcase.to_s] += 1 if char.letter?
        end

        channel.send(counts)
      end
    end

    totals = Hash(String, Int32).new(0)

    input.size.times do
      channel.receive.each do |letter, count|
        totals[letter] += count
      end
    end

    totals
  end
end