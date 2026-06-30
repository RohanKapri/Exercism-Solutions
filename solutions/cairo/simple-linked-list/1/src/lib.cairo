use core::array::ArrayTrait;

#[derive(Drop)]
pub struct SimpleLinkedList<T> {
    data: Array<T>,
}

#[generate_trait]
pub impl SimpleLinkedListImpl<T, +Drop<T>, +Copy<T>> of SimpleLinkedListTrait<T> {
    fn new() -> SimpleLinkedList<T> {
        SimpleLinkedList { data: ArrayTrait::new() }
    }

    fn is_empty(self: @SimpleLinkedList<T>) -> bool {
        self.len() == 0_usize
    }

    fn len(self: @SimpleLinkedList<T>) -> usize {
        self.data.len()
    }

    fn push(ref self: SimpleLinkedList<T>, element: T) {
        // We treat the *end* of `data` as the head of the list.
        self.data.append(element);
    }

    fn pop(ref self: SimpleLinkedList<T>) -> Option<T> {
        // Remove and return the last element (the head).
        let n = self.len();
        if n == 0_usize {
            Option::None
        } else {
            // Move the first n-1 items to a temporary buffer.
            let mut tmp: Array<T> = ArrayTrait::new();
            let mut moved: usize = 0_usize;
            loop {
                if moved + 1_usize >= n {
                    break ();
                }
                match self.data.pop_front() {
                    Option::Some(x) => { tmp.append(x); },
                    Option::None => { break (); },
                };
                moved = moved + 1_usize;
            };

            // The only remaining element in `self.data` is the last (the head).
            let ret = self.data.pop_front();

            // Restore the remaining elements back into `self.data` in order.
            loop {
                match tmp.pop_front() {
                    Option::Some(x) => { self.data.append(x); },
                    Option::None => { break (); },
                }
            };

            ret
        }
    }

    fn peek(self: @SimpleLinkedList<T>) -> Option<@T> {
        // Snapshot a reference to the head element without removing it.
        let n = self.len();
        if n == 0_usize {
            Option::None
        } else {
            // `at` on a snapshot returns `@T`.
            Option::Some(self.data.at(n - 1_usize))
        }
    }

    #[must_use]
    fn rev(mut self: SimpleLinkedList<T>) -> SimpleLinkedList<T> {
        // Build a new list by popping from `self` and pushing to the new list.
        let mut out = SimpleLinkedListImpl::<T>::new();
        loop {
            match self.pop() {
                Option::Some(x) => { out.push(x); },
                Option::None => { break (); },
            }
        };
        out
    }
}

impl ArrayIntoSimpleLinkedList<T, +Drop<T>, +Copy<T>> of Into<Array<T>, SimpleLinkedList<T>> {
    #[must_use]
    fn into(mut self: Array<T>) -> SimpleLinkedList<T> {
        // Given array [1,2,3,4], the list should pop as 4,3,2,1 (head = last).
        let mut list = SimpleLinkedListImpl::<T>::new();
        loop {
            match self.pop_front() {
                Option::Some(x) => { list.push(x); },
                Option::None => { break (); },
            }
        };
        list
    }
}

impl SimpleLinkedListIntoArray<T, +Drop<T>, +Copy<T>> of Into<SimpleLinkedList<T>, Array<T>> {
    #[must_use]
    fn into(self: SimpleLinkedList<T>) -> Array<T> {
        // Return the underlying array in insertion order.
        let SimpleLinkedList { data } = self;
        data
    }
}
   