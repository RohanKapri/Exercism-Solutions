#[derive(Drop, Debug, PartialEq)]
pub enum Plant {
    Radishes,
    Clover,
    Grass,
    Violets,
}

#[derive(Drop)]
pub enum Student {
    Alice,
    Bob,
    Charlie,
    David,
    Eve,
    Fred,
    Ginny,
    Harriet,
    Ileana,
    Joseph,
    Kincaid,
    Larry,
}

fn student_index(student: Student) -> u32 {
    match student {
        Student::Alice => 0,
        Student::Bob => 1,
        Student::Charlie => 2,
        Student::David => 3,
        Student::Eve => 4,
        Student::Fred => 5,
        Student::Ginny => 6,
        Student::Harriet => 7,
        Student::Ileana => 8,
        Student::Joseph => 9,
        Student::Kincaid => 10,
        Student::Larry => 11,
    }
}

fn char_to_plant(c: u8) -> Plant {
    if c == 71 {       // 'G'
        Plant::Grass
    } else if c == 67 { // 'C'
        Plant::Clover
    } else if c == 82 { // 'R'
        Plant::Radishes
    } else if c == 86 { // 'V'
        Plant::Violets
    } else {
        panic!("Invalid plant character")
    }
}

fn parse_diagram(diagram: ByteArray) -> (ByteArray, ByteArray) {
    let mut row1 = "";
    let mut row2 = "";
    let mut found_newline = false;
    let mut i = 0;
    
    while i < diagram.len() {
        let byte = diagram.at(i).unwrap();
        if byte == 10 {  // '\n' character
            found_newline = true;
            i += 1;
            continue;
        }
        
        if !found_newline {
            row1.append_byte(byte);
        } else {
            row2.append_byte(byte);
        }
        i += 1;
    };
    
    (row1, row2)
}

pub fn plants(diagram: ByteArray, student: Student) -> Array<Plant> {
    let student_idx = student_index(student);
    let (row1, row2) = parse_diagram(diagram);
    
    // Each student gets 2 consecutive positions, starting at position student_idx * 2
    let start_pos = student_idx * 2;
    
    let mut result = ArrayTrait::new();
    
    // Get plants from row 1 (positions start_pos and start_pos + 1)
    if let Option::Some(plant1_char) = row1.at(start_pos) {
        result.append(char_to_plant(plant1_char));
    }
    if let Option::Some(plant2_char) = row1.at(start_pos + 1) {
        result.append(char_to_plant(plant2_char));
    }
    
    // Get plants from row 2 (positions start_pos and start_pos + 1)
    if let Option::Some(plant3_char) = row2.at(start_pos) {
        result.append(char_to_plant(plant3_char));
    }
    if let Option::Some(plant4_char) = row2.at(start_pos + 1) {
        result.append(char_to_plant(plant4_char));
    }
    
    result
}
    