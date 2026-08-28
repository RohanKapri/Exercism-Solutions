export function annotate(field: string[]): string[] {
  const rowCount = field.length;
  if (rowCount === 0) return [];
  
  const colCount = field[0].length;
  if (colCount === 0) return [''];

  const annotatedField: string[] = [];

  // Relative positions of the 8 neighbors (diagonals, horizontals, verticals)
  const directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],          [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1]
  ];

  for (let r = 0; r < rowCount; r++) {
    let annotatedRow = '';

    for (let c = 0; c < colCount; c++) {
      // If it's already a flower, leave it as is
      if (field[r][c] === '*') {
        annotatedRow += '*';
        continue;
      }

      // Count adjacent flowers
      let flowerCount = 0;
      for (const [dr, dc] of directions) {
        const nr = r + dr;
        const nc = c + dc;

        // Verify boundary limits before checking for a flower
        if (nr >= 0 && nr < rowCount && nc >= 0 && nc < colCount) {
          if (field[nr][nc] === '*') {
            flowerCount++;
          }
        }
      }

      // If count is greater than 0, use the number string; otherwise, keep it empty
      annotatedRow += flowerCount > 0 ? flowerCount.toString() : ' ';
    }

    annotatedField.push(annotatedRow);
  }

  return annotatedField;
}