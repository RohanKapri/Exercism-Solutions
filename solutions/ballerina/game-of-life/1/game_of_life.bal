class GameOfLife {

    private int[][] grid = [];

    function init(int[][] matrix) {
        self.grid = matrix.clone();
    }

    function tick() {
        int rowCount = self.grid.length();
        if rowCount == 0 {
            return;
        }

        int[][] nextGrid = [];
        foreach int rowIndex in 0 ..< rowCount {
            int[] currentRow = self.grid[rowIndex];
            int colCount = currentRow.length();
            int[] nextRow = [];

            foreach int colIndex in 0 ..< colCount {
                int liveNeighbors = self.countLiveNeighbors(rowIndex, colIndex);
                int currentCell = currentRow[colIndex];

                int nextCell = 0;
                if currentCell == 1 {
                    if liveNeighbors == 2 || liveNeighbors == 3 {
                        nextCell = 1;
                    }
                } else if liveNeighbors == 3 {
                    nextCell = 1;
                }

                nextRow.push(nextCell);
            }

            nextGrid.push(nextRow);
        }

        self.grid = nextGrid;
    }

    function matrix() returns int[][] {
        return self.grid.clone();
    }

    private function countLiveNeighbors(int rowIndex, int colIndex) returns int {
        int liveCount = 0;
        int rowCount = self.grid.length();

        int[] offsets = [-1, 0, 1];

        foreach int dRow in offsets {
            int neighborRowIndex = rowIndex + dRow;
            if neighborRowIndex < 0 || neighborRowIndex >= rowCount {
                continue;
            }

            int[] neighborRow = self.grid[neighborRowIndex];
            int colCount = neighborRow.length();

            foreach int dCol in offsets {
                int neighborColIndex = colIndex + dCol;
                if (dRow == 0 && dCol == 0) || neighborColIndex < 0 || neighborColIndex >= colCount {
                    continue;
                }

                liveCount += neighborRow[neighborColIndex];
            }
        }

        return liveCount;
    }
}