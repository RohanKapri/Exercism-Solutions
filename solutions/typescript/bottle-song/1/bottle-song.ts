// Helper array to convert numbers 0-10 into their corresponding lyric words
const NUMBER_WORDS: string[] = [
  'no', 'one', 'two', 'three', 'four', 
  'five', 'six', 'seven', 'eight', 'nine', 'ten'
];

/**
 * Capitalizes the first letter of a string.
 */
const capitalize = (str: string): string => {
  return str.charAt(0).toUpperCase() + str.slice(1);
};

/**
 * Generates a single verse of the song based on the current number of bottles.
 */
const generateVerse = (count: number): string[] => {
  const currentWord = NUMBER_WORDS[count];
  const nextWord = NUMBER_WORDS[count - 1];
  
  // Handle plural vs singular grammar
  const currentPlural = count === 1 ? 'bottle' : 'bottles';
  const nextPlural = (count - 1) === 1 ? 'bottle' : 'bottles';

  return [
    `${capitalize(currentWord)} green ${currentPlural} hanging on the wall,`,
    `${capitalize(currentWord)} green ${currentPlural} hanging on the wall,`,
    `And if one green bottle should accidentally fall,`,
    `There'll be ${nextWord} green ${nextPlural} hanging on the wall.`
  ];
};

export const recite = (
  initialBottleCount: number,
  takeDownCount: number
): string[] => {
  const lyrics: string[] = [];

  for (let i = 0; i < takeDownCount; i++) {
    const currentCount = initialBottleCount - i;
    
    // Generate the lines for the current verse
    const verseLines = generateVerse(currentCount);
    lyrics.push(...verseLines);

    // If this is not the last verse requested, add an empty line separator
    if (i < takeDownCount - 1) {
      lyrics.push('');
    }
  }

  return lyrics;
};