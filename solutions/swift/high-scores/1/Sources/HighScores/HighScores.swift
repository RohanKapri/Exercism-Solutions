struct HighScores {
    let scores: [Int]

    var latest: Int? {
        scores.last
    }
    
    var personalBest: Int? {
        scores.max()
    }
    
    var topThree: [Int] {
        Array(scores.sorted(by: >).prefix(3))
    }
}