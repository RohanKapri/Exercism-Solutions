#[derive(Drop)]
pub struct HighScores {
    scores: Array<u32>,
}

#[generate_trait]
pub impl HighScoresImpl of HighScoresTrait {
    fn new(scores: Array<u32>) -> HighScores {
        HighScores { scores }
    }

    fn scores(self: @HighScores) -> Span<u32> {
        self.scores.span()
    }

    fn latest(self: @HighScores) -> Option<u32> {
        if self.scores.is_empty() {
            Option::None
        } else {
            let last_index = self.scores.len() - 1;
            Option::Some(*self.scores.at(last_index))
        }
    }

    fn personal_best(self: @HighScores) -> Option<u32> {
        if self.scores.is_empty() {
            return Option::None;
        }
        
        let mut max_score = *self.scores.at(0);
        let mut i = 1;
        while i < self.scores.len() {
            let current_score = *self.scores.at(i);
            if current_score > max_score {
                max_score = current_score;
            }
            i += 1;
        };
        Option::Some(max_score)
    }

    fn personal_top_three(self: @HighScores) -> Span<u32> {
        if self.scores.is_empty() {
            return array![].span();
        }

        // Create a mutable copy of scores for sorting
        let mut sorted_scores = ArrayTrait::new();
        let mut i = 0;
        while i < self.scores.len() {
            sorted_scores.append(*self.scores.at(i));
            i += 1;
        };

        // Simple bubble sort in descending order
        let mut n = sorted_scores.len();
        while n > 1 {
            let mut i = 0;
            while i < n - 1 {
                if *sorted_scores.at(i) < *sorted_scores.at(i + 1) {
                    // Swap elements - we need to rebuild the array
                    let mut new_array = ArrayTrait::new();
                    let mut j = 0;
                    while j < sorted_scores.len() {
                        if j == i {
                            new_array.append(*sorted_scores.at(i + 1));
                        } else if j == i + 1 {
                            new_array.append(*sorted_scores.at(i));
                        } else {
                            new_array.append(*sorted_scores.at(j));
                        }
                        j += 1;
                    };
                    sorted_scores = new_array;
                }
                i += 1;
            };
            n -= 1;
        };

        // Return top 3 (or fewer if less than 3 scores)
        let mut result = ArrayTrait::new();
        let mut i = 0;
        let limit = if sorted_scores.len() < 3 { sorted_scores.len() } else { 3 };
        while i < limit {
            result.append(*sorted_scores.at(i));
            i += 1;
        };
        
        result.span()
    }
}