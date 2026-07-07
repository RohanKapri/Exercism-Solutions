#[derive(Drop, Debug)]
struct CustomSet<T> {
    elements: Array<T>,
}

impl CustomSetEq<
    T, +Copy<T>, +Drop<T>, +PartialEq<T>, +core::fmt::Display<T>,
> of PartialEq<CustomSet<T>> {
    fn eq(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        // Check if both sets have the same length
        if lhs.elements.len() != rhs.elements.len() {
            return false;
        }
        
        // Check if all elements in lhs are contained in rhs
        let mut i = 0;
        let mut all_found = true;
        while i < lhs.elements.len() && all_found {
            let element = lhs.elements.at(i);
            if !contains_element(rhs.elements, element) {
                all_found = false;
            }
            i += 1;
        };
        
        all_found
    }
}

// Helper function to check if an array contains a specific element
fn contains_element<T, +Copy<T>, +Drop<T>, +PartialEq<T>>(arr: @Array<T>, element: @T) -> bool {
    let mut i = 0;
    let mut found = false;
    while i < arr.len() && !found {
        if arr.at(i) == element {
            found = true;
        }
        i += 1;
    };
    found
}

// Helper function to remove duplicates from an array
fn deduplicate<T, +Copy<T>, +Drop<T>, +PartialEq<T>>(input: @Array<T>) -> Array<T> {
    let mut result = array![];
    let mut i = 0;
    while i < input.len() {
        let element = input.at(i);
        if !contains_element(@result, element) {
            result.append(*element);
        }
        i += 1;
    };
    result
}

#[generate_trait]
pub impl CustomSetImpl<
    T, +Copy<T>, +Drop<T>, +core::fmt::Display<T>, +PartialEq<T>,
> of CustomSetTrait<T> {
    fn new(input: @Array<T>) -> CustomSet<T> {
        // construct a new CustomSet struct
        CustomSet { elements: deduplicate(input) }
    }

    fn add(ref self: CustomSet<T>, element: T) {
        // add {element} to the CustomSet
        if !contains_element(@self.elements, @element) {
            self.elements.append(element);
        }
    }

    fn contains(self: @CustomSet<T>, element: @T) -> bool {
        // determine whether the CustomSet contains {element}
        contains_element(self.elements, element)
    }

    fn is_subset(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        // determine whether {self} is a subset of {other}
        let mut i = 0;
        let mut is_subset = true;
        while i < self.elements.len() && is_subset {
            let element = self.elements.at(i);
            if !contains_element(other.elements, element) {
                is_subset = false;
            }
            i += 1;
        };
        is_subset
    }

    fn is_empty(self: @CustomSet<T>) -> bool {
        // determine whether {self} is empty
        self.elements.len() == 0
    }

    fn is_disjoint(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        // determine whether {self} and {other} have no elements in common
        let mut i = 0;
        let mut is_disjoint = true;
        while i < self.elements.len() && is_disjoint {
            let element = self.elements.at(i);
            if contains_element(other.elements, element) {
                is_disjoint = false;
            }
            i += 1;
        };
        is_disjoint
    }

    #[must_use]
    fn intersection(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains only those elements from {self} that
        // are also contained in {other}
        let mut result = array![];
        let mut i = 0;
        while i < self.elements.len() {
            let element = self.elements.at(i);
            if contains_element(other.elements, element) {
                result.append(*element);
            }
            i += 1;
        };
        CustomSet { elements: result }
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains only those elements from {self} that
        // are NOT contained in {other}
        let mut result = array![];
        let mut i = 0;
        while i < self.elements.len() {
            let element = self.elements.at(i);
            if !contains_element(other.elements, element) {
                result.append(*element);
            }
            i += 1;
        };
        CustomSet { elements: result }
    }

    #[must_use]
    fn union(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains all of the elements from both {self} AND {other}
        let mut result = array![];
        
        // Add all elements from self
        let mut i = 0;
        while i < self.elements.len() {
            result.append(*self.elements.at(i));
            i += 1;
        };
        
        // Add elements from other that are not already in result
        let mut j = 0;
        while j < other.elements.len() {
            let element = other.elements.at(j);
            if !contains_element(@result, element) {
                result.append(*element);
            }
            j += 1;
        };
        
        CustomSet { elements: result }
    }
}
   