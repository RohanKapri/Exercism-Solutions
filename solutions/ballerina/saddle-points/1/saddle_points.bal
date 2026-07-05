# Returns the saddle points in the given matrix.
#
# A saddle point is an value that is:
# - equal to the maximum value in its row, and
# - equal to the minimum value in its column.
#
# + matrix - an array of int arrays (i.e. two-dimensional matrix)
# + return - an array of maps [{"row": x, "column": y}, ...]
public function saddlePoints(int[][] matrix) returns map<int>[] {
    if matrix.length() == 0 || matrix[0].length() == 0 {
        return [];
    }

    map<int>[] saddlePoints = [];
    int rowCount = matrix.length();
    int colCount = matrix[0].length();

    foreach int i in 0..<rowCount {
        int rowMax = max(matrix[i]);
        foreach int j in 0..<colCount {
            if (matrix[i][j] == rowMax && matrix[i][j] == minColumnValue(matrix, j)) {
                map<int> point = {"row": i + 1, "column": j + 1};
                saddlePoints.push(point);
            }
        }
    }
    return saddlePoints;
}

function max(int[] arr) returns int {
    int max = arr[0];
    foreach int num in arr {
        if (num > max) {
            max = num;
        }
    }
    return max;
}

function minColumnValue(int[][] matrix, int col) returns int {
    int min = matrix[0][col];
    foreach int[] row in matrix {
        if (row[col] < min) {
            min = row[col];
        }
    }
    return min;
}