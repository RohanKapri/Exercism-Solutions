let eggCount = (displayNumber: int) : int => {
  let rec countBits = (num: int, acc: int) : int =>
    if (num == 0) {
      acc;
    } else {
      /* Extract the lowest bit and add it to our accumulator */
      let nextAcc = acc + (num land 1);
      /* Arithmetic shift right to process the next bit */
      countBits(num asr 1, nextAcc);
    };

  countBits(displayNumber, 0);
};