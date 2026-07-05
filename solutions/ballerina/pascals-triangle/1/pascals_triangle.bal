function rows(int count) returns int[][] {
    int[][] triangle = [];
    
    foreach int i in 0..<count {
        int[] row = [];
        row[0] = 1;
        
        foreach int j in 1..<i {
            row[j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
        }
        
        if i > 0 {
            row[i] = 1;
        }
        
        triangle.push(row);
    }
    
    return triangle;
}