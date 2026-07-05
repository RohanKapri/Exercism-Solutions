import ballerina/lang.'string;

# Encodes the input text using the rotational cipher technique
#
# + text - the text to encode
# + shiftKey - the number of positions to shift each alphabetic character
# + return - the encoded text
public function rotate(string text, int shiftKey) returns string {
    string result = "";
    int textLength = text.length();
    
    int i = 0;
    while (i < textLength) {
        string ch = text.substring(i, i + 1);
        byte[] bytes = ch.toBytes();
        int charCode = bytes[0];

        if (charCode >= 97 && charCode <= 122) {
            // Lowercase letters
            byte shiftedByte = <byte>((((charCode - 97) + shiftKey) % 26) + 97);
            result = result + checkpanic string:fromBytes([shiftedByte]);
        } else if (charCode >= 65 && charCode <= 90) {
            // Uppercase letters
            byte shiftedByte = <byte>((((charCode - 65) + shiftKey) % 26) + 65);
            result = result + checkpanic string:fromBytes([shiftedByte]);
        } else {
            // Non-alphabetic characters
            result = result + ch;
        }
        
        i = i + 1;
    }
    
    return result;
}