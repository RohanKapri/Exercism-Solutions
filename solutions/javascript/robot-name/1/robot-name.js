// The Master Ledger
let takenNames = new Set(); 

export class Robot {
  constructor() {
    this.reset();
  }
  get name() {
    return this._name;
  }

  reset() {
    let newName = generateName();
    while (takenNames.has(newName)) {
      newName = generateName();
    }
    takenNames.add(newName);
    this._name = newName; 
  }
}
const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

function getRandomLetter() {
  const randomIndex = Math.floor(Math.random() * alphabet.length);
  return alphabet[randomIndex];
}

function getRandomNumber() {
  return Math.floor(Math.random() * 10);
}

function generateName() {
  const letter1 = getRandomLetter();
  const letter2 = getRandomLetter();
  const num1 = getRandomNumber();
  const num2 = getRandomNumber();
  const num3 = getRandomNumber();

  return `${letter1}${letter2}${num1}${num2}${num3}`;
}

Robot.releaseNames = () => {
  takenNames.clear();
};