#[derive(Drop, Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T, +PartialEq<T>>(a: @Array<T>, b: @Array<T>) -> Comparison {
    let a_len = a.len();
    let b_len = b.len();
    
    // If both lists are equal in length and content
    if a_len == b_len && arrays_equal(a, b) {
        return Comparison::Equal;
    }
    
    // If A is empty and B is not, A is a sublist of B
    if a_len == 0 && b_len > 0 {
        return Comparison::Sublist;
    }
    
    // If B is empty and A is not, A is a superlist of B
    if b_len == 0 && a_len > 0 {
        return Comparison::Superlist;
    }
    
    // Check if A is a sublist of B (A is contained in B)
    if a_len <= b_len && is_sublist(a, b) {
        return Comparison::Sublist;
    }
    
    // Check if A is a superlist of B (B is contained in A)
    if b_len <= a_len && is_sublist(b, a) {
        return Comparison::Superlist;
    }
    
    // None of the above conditions met
    Comparison::Unequal
}

// Helper function to check if two arrays are equal
fn arrays_equal<T, +PartialEq<T>>(a: @Array<T>, b: @Array<T>) -> bool {
    if a.len() != b.len() {
        return false;
    }
    
    let mut i = 0;
    let mut equal = true;
    while i < a.len() && equal {
        if a[i] != b[i] {
            equal = false;
        }
        i += 1;
    };
    equal
}

// Helper function to check if 'needle' is a contiguous subsequence in 'haystack'
fn is_sublist<T, +PartialEq<T>>(needle: @Array<T>, haystack: @Array<T>) -> bool {
    let needle_len = needle.len();
    let haystack_len = haystack.len();
    
    if needle_len > haystack_len {
        return false;
    }
    
    if needle_len == 0 {
        return true;
    }
    
    let mut i = 0;
    let mut found = false;
    while i <= haystack_len - needle_len && !found {
        let mut j = 0;
        let mut current_match = true;
        
        while j < needle_len && current_match {
            if haystack[i + j] != needle[j] {
                current_match = false;
            }
            j += 1;
        };
        
        if current_match {
            found = true;
        }
        i += 1;
    };
    found
}
   