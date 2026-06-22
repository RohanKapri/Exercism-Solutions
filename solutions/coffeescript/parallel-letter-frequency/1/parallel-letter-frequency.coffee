class ParallelLetterFrequency
  @parallelLetterFrequency: (texts) ->
    Promise.resolve().then ->
      freq = {}

      for text in texts
        for ch in text.toLowerCase()
          # Ignore whitespace, digits and punctuation
          if /\p{L}/u.test ch
            freq[ch] ?= 0
            freq[ch]++

      freq

module.exports = ParallelLetterFrequency