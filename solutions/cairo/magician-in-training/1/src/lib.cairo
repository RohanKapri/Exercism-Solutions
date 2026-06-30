pub fn insert_top(mut stack: Array<u32>, card: u32) -> Array<u32> {
    stack.append(card);
    stack
}

pub fn remove_top_card(stack: Array<u32>) -> Array<u32> {
    if stack.len() == 0 {
        return stack;
    }

    let mut span = stack.span();
    span.pop_back();

    let mut result = ArrayTrait::new();

    while let Option::Some(value) = span.pop_front() {
        result.append(*value);
    }

    result
}

pub fn insert_bottom(stack: Array<u32>, card: u32) -> Array<u32> {
    let mut result = ArrayTrait::new();
    result.append(card);

    let mut span = stack.span();
    while let Option::Some(value) = span.pop_front() {
        result.append(*value);
    }

    result
}

pub fn remove_bottom_card(stack: Array<u32>) -> Array<u32> {
    if stack.len() == 0 {
        return stack;
    }

    let mut span = stack.span();
    span.pop_front();

    let mut result = ArrayTrait::new();

    while let Option::Some(value) = span.pop_front() {
        result.append(*value);
    }

    result
}

pub fn check_size_of_stack(stack: Array<u32>, target: u32) -> bool {
    stack.len() == target
}