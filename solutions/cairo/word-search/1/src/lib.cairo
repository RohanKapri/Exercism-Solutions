use core::array::{ArrayTrait, SpanTrait};
use core::byte_array::{ByteArray, ByteArrayTrait};

#[derive(Drop, Debug, PartialEq)]
pub struct Position {
    pub col: u32,
    pub row: u32,
}

#[derive(Debug, PartialEq, Drop)]
pub struct SearchResult {
    pub word: ByteArray,
    pub start: Position,
    pub end: Position,
}

fn search_direction(
    grid: Span<ByteArray>, 
    word: @ByteArray, 
    start_row: u32, 
    start_col: u32, 
    row_delta: i32, 
    col_delta: i32,
    rows: u32,
    cols: u32,
    results: Array<SearchResult>
) -> Array<SearchResult> {
    let len = word.len();
    let start_row_i32 = start_row.try_into().unwrap();
    let start_col_i32 = start_col.try_into().unwrap();
    
    let mut k: u32 = 0;
    loop {
        if k == len { 
            // Found the word, add result
            let word_len_i32 = len.try_into().unwrap();
            let end_row_i32 = start_row_i32 + row_delta * (word_len_i32 - 1);
            let end_col_i32 = start_col_i32 + col_delta * (word_len_i32 - 1);
            
            let mut new_results = results;
            new_results.append(SearchResult {
                word: word.clone(),
                start: Position { col: start_col + 1, row: start_row + 1 },
                end: Position { col: end_col_i32.try_into().unwrap() + 1, row: end_row_i32.try_into().unwrap() + 1 },
            });
            break new_results;
        }
        
        let k_i32 = k.try_into().unwrap();
        let current_row_i32 = start_row_i32 + row_delta * k_i32;
        let current_col_i32 = start_col_i32 + col_delta * k_i32;
        
        if current_row_i32 < 0 || current_col_i32 < 0 {
            break results;
        }
        
        let current_row = current_row_i32.try_into().unwrap();
        let current_col = current_col_i32.try_into().unwrap();
        
        if current_row >= rows || current_col >= cols {
            break results;
        }
        
        if grid.at(current_row)[current_col] != word[k] {
            break results;
        }
        
        k += 1;
    }
}

pub fn search(grid: Span<ByteArray>, words_to_search_for: Span<ByteArray>) -> Span<SearchResult> {
    let mut results: Array<SearchResult> = array![];
    let rows = grid.len();
    let cols = if rows > 0 { grid.at(0).len() } else { 0 };
    
    let directions = array![(0,1), (0,-1), (1,0), (-1,0), (1,1), (-1,-1), (1,-1), (-1,1)];
    
    let mut word_idx = 0;
    loop {
        if word_idx >= words_to_search_for.len() { break; }
        
        let word_ref = words_to_search_for.at(word_idx);
        
        let mut row = 0;
        loop {
            if row >= rows { break; }
            
            let mut col = 0;
            loop {
                if col >= cols { break; }
                
                let mut dir_idx = 0;
                loop {
                    if dir_idx >= directions.len() { break; }
                    
                    let (row_delta, col_delta) = *directions.at(dir_idx);
                    results = search_direction(grid, word_ref, row, col, row_delta, col_delta, rows, cols, results);
                    
                    dir_idx += 1;
                };
                
                col += 1;
            };
            
            row += 1;
        };
        
        word_idx += 1;
    };
    
    results.span()
}
                 