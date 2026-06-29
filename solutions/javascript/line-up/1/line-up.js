/**
 * Determines the correct English ordinal suffix for a given number.
 * Supported range: 1 to 999.
 */
const getOrdinalSuffix = (num) => {
  const hundredRemainder = num % 100;
  const tenRemainder = num % 10;

  // Rule exception: Numbers ending in 11, 12, or 13 always use "th"
  if (hundredRemainder >= 11 && hundredRemainder <= 13) {
    return 'th';
  }

  switch (tenRemainder) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
};

/**
 * Formats the customer greeting sentence with an ordinal number.
 */
export const format = (name, number) => {
  const suffix = getOrdinalSuffix(number);
  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`;
};