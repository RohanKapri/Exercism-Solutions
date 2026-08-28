/**
 * Processes a string input based on specific criteria and handles errors appropriately.
 * 
 * @param {*} input - The input value to process.
 * @returns {string|null} The uppercase version of the input string, or null if empty.
 * @throws {TypeError|RangeError|SyntaxError} Appropriate errors depending on validation criteria.
 */
export const processString = (input) => {
  try {
    // 1. Check if the input is a valid string type
    if (typeof input !== 'string') {
      throw new TypeError('Input must be a string.');
    }

    // 2. Check for empty strings
    if (input === '') {
      return null;
    }

    // 3. Verify length boundary constraints
    if (input.length < 10 || input.length > 100) {
      throw new RangeError('Input length must be between 10 and 100 characters.');
    }

    // 4. Check for mixed letters and numbers using regular expressions
    const hasLetters = /[a-zA-Z]/.test(input);
    const hasNumbers = /[0-9]/.test(input);
    if (hasLetters && hasNumbers) {
      throw new SyntaxError('Input must not contain a mix of letters and numbers.');
    }

    // 5. If it passes all validation steps, return uppercase
    return input.toUpperCase();

  } catch (error) {
    // Log the message cleanly to the console
    console.log(error.message);
    
    // Re-throw the exact error instance so the test framework can assert its specific class type
    throw error;
  }
};