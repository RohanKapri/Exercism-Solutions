pub fn response(name: Option<ByteArray>) -> ByteArray {
    format!("One for {}, one for me.", 
        match name {
            Option::Some(n) => n,
            Option::None => "you"
        }
    )
}