#[derive(Drop)]
struct DoublyLinkedList<T> {
    data: Array<T>,
}

#[generate_trait]
pub impl DoublyLinkedListImpl<T, +Drop<T>, +Clone<T>, +PartialEq<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        DoublyLinkedList {
            data: ArrayTrait::new(),
        }
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        self.data.len()
    }

    fn push(ref self: DoublyLinkedList<T>, station: T) {
        self.data.append(station);
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        if self.data.len() == 0 {
            return Option::None;
        }
        
        let last_idx = self.data.len() - 1;
        let last_element = self.data.at(last_idx).clone();
        
        // Create new array without the last element
        let mut new_data = ArrayTrait::new();
        let mut i = 0;
        while i < last_idx {
            new_data.append(self.data.at(i).clone());
            i += 1;
        };
        
        self.data = new_data;
        Option::Some(last_element)
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        if self.data.len() == 0 {
            return Option::None;
        }
        
        let first_element = self.data.at(0).clone();
        
        // Create new array without the first element
        let mut new_data = ArrayTrait::new();
        let mut i = 1;
        while i < self.data.len() {
            new_data.append(self.data.at(i).clone());
            i += 1;
        };
        
        self.data = new_data;
        Option::Some(first_element)
    }

    fn unshift(ref self: DoublyLinkedList<T>, station: T) {
        // Create new array with the new element at the beginning
        let mut new_data = ArrayTrait::new();
        new_data.append(station);
        
        let mut i = 0;
        while i < self.data.len() {
            new_data.append(self.data.at(i).clone());
            i += 1;
        };
        
        self.data = new_data;
    }

    fn delete(ref self: DoublyLinkedList<T>, station: T) {
        let mut new_data = ArrayTrait::new();
        let mut found = false;
        let mut i = 0;
        
        while i < self.data.len() {
            let element = self.data.at(i);
            if !found && element == @station {
                found = true;
                // Skip this element (don't append it)
            } else {
                new_data.append(element.clone());
            }
            i += 1;
        };
        
        self.data = new_data;
    }
}