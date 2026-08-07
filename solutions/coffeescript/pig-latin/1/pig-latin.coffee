class PigLatin
  @translate: (phrase) =>
    words = phrase.split(' ')
    pigLatinWords = words.map (word) => @translateWord(word)
    pigLatinWords.join(' ')

    
  @translateWord: (word) ->
    vowels = ['a', 'e', 'i', 'o', 'u']
    specialVowelStarts = ['xr', 'yt']
    consonantClusters = ['thr', 'sch', 'squ', 'ch', 'qu', 'th']

    # Rule 1: Word starts with a vowel or special clusters treated as vowels
    if vowels.includes(word[0]) or specialVowelStarts.some((cluster) -> word.startsWith(cluster))
      return word + 'ay'

    # Rule 3: Words with 'qu' after initial consonants
    if word.indexOf('qu') > 0
      quIndex = word.indexOf('qu')
      if word[0..quIndex-1].split('').every((char) -> not vowels.includes(char))
        return word.substring(quIndex + 2) + word.substring(0, quIndex + 2) + 'ay'

    # Rule 2: Words starting with consonant clusters
    for cluster in consonantClusters
      if word.startsWith(cluster)
        return word.substring(cluster.length) + cluster + 'ay'

    # Rule 4: Words with 'y' as the first vowel
    if word.indexOf('y') > 0
      yIndex = word.indexOf('y')
      return word.substring(yIndex) + word.substring(0, yIndex) + 'ay'

    # Handle words starting with single consonants
    consonants = ''
    for index, letter of word
      if not vowels.includes(letter) and not (letter == 'y' and index > 0 and vowels.includes(word[index - 1]))
        consonants += letter
      else
        break
    return word.substring(consonants.length) + consonants + 'ay'

module.exports = PigLatin