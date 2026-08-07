type Player = 'X' | 'O';
export type BoardState = 'ongoing' | 'draw' | 'win';

export const gamestate = (board: string[]): BoardState => {
  // 1. Basic validation of board shape
  if (!board || board.length !== 3 || board.some(row => row.length !== 3)) {
    throw new Error('Invalid board dimensions');
  }

  // Count X and O placements
  let xCount = 0;
  let oCount = 0;
  for (const row of board) {
    for (const cell of row) {
      if (cell === 'X') xCount++;
      else if (cell === 'O') oCount++;
    }
  }

  // 2. Validate Turn Order with precise error messages
  if (xCount > oCount + 1) {
    throw new Error('Wrong turn order: X went twice');
  }
  if (xCount < oCount) {
    throw new Error('Wrong turn order: O started');
  }

  // 3. Helper to check if a specific player has 3-in-a-row
  const checkWin = (player: Player): boolean => {
    // Rows
    if (board.some(row => row.split('').every(c => c === player))) return true;
    
    // Columns
    for (let col = 0; col < 3; col++) {
      if (board[0][col] === player && board[1][col] === player && board[2][col] === player) {
        return true;
      }
    }
    
    // Diagonals
    if (board[0][0] === player && board[1][1] === player && board[2][2] === player) return true;
    if (board[0][2] === player && board[1][1] === player && board[2][0] === player) return true;

    return false;
  };

  const xWon = checkWin('X');
  const oWon = checkWin('O');

  // 4. Validate Continued Play After Win
  // Both winning or a player winning with incorrect turn counts mean game continued past a win
  if ((xWon && oWon) || (xWon && xCount !== oCount + 1) || (oWon && xCount !== oCount)) {
    throw new Error('Impossible board: game should have ended after the game was won');
  }

  // 5. Determine and Return State
  if (xWon || oWon) {
    return 'win';
  }

  // If no one won and the board is full
  if (xCount + oCount === 9) {
    return 'draw';
  }

  return 'ongoing';
};