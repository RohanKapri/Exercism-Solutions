#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: ByteArray) -> Result<ByteArray, ByteArray> {
        if operation.len() == 0 {
            panic!("Operation cannot be an empty string");
        }

        if operation == "+" {
            Result::Ok(format!("{a} + {b} = {}", a + b))
        } else if operation == "*" {
            Result::Ok(format!("{a} * {b} = {}", a * b))
        } else if operation == "/" {
            if b == 0 {
                panic(array!['Division by zero is not allowed']);
            }
            Result::Ok(format!("{a} / {b} = {}", a / b))
        } else {
            Result::Err("Operation is out of range")
        }
    }
}