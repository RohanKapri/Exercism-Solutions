use core::array::ArrayTrait;
use core::array::SpanTrait;
use core::option::OptionTrait;
use core::byte_array::ByteArrayTrait;

const STAR: u8 = 42;   // '*'
const SPACE: u8 = 32;  // ' '
const ZERO: u8 = 48;   // '0'

pub fn annotate(pieces: Span<ByteArray>) -> Array<ByteArray> {
    let rows = pieces.len();
    let mut out: Array<ByteArray> = ArrayTrait::new();

    // Handle each input row
    let mut r: usize = 0;
    while r < rows {
        let row = pieces.get(r).unwrap().unbox();  // Get snapshot reference
        let cols = row.len();
        let mut out_row: ByteArray = Default::default();

        // Handle each cell in the row
        let mut c: usize = 0;
        while c < cols {
            let b = match row.at(c) {
                Option::Some(b) => b,
                Option::None => SPACE,
            };

            if b == STAR {
                out_row.append_byte(STAR);
            } else {
                let count = count_adjacent(pieces, r, c);
                if count == 0 {
                    out_row.append_byte(SPACE);
                } else {
                    out_row.append_byte(ZERO + count);
                }
            }

            c += 1;
        };

        out.append(out_row);
        r += 1;
    };

    out
}

// Count '*' in the 8 neighbors around (r, c).
fn count_adjacent(pieces: Span<ByteArray>, r: usize, c: usize) -> u8 {
    let rows = pieces.len();
    let r_start = if r == 0 { 0 } else { r - 1 };
    let r_end = if r + 1 < rows { r + 1 } else { rows - 1 };

    let mut cnt: u8 = 0;

    let mut rr: usize = r_start;
    while rr <= r_end {
        let nrow = pieces.get(rr).unwrap().unbox();  // Get snapshot reference
        let ncols = nrow.len();
        if ncols == 0 {
            rr += 1;
            continue;
        }

        let c_start = if c == 0 { 0 } else { c - 1 };
        let mut c_end = c + 1;
        if c_end >= ncols {
            c_end = ncols - 1;
        }

        let mut cc: usize = c_start;
        while cc <= c_end {
            if !(rr == r && cc == c) {
                match nrow.at(cc) {
                    Option::Some(b) => {
                        if b == STAR {
                            cnt += 1;
                        }
                    },
                    Option::None => {}
                }
            }
            cc += 1;
        };

        rr += 1;
    };

    cnt
}
   