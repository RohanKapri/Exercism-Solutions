import ballerina/http;
import ballerina/io;

final http:Client brainyQuoteClient = check new ("http://localhost:9095/brainyquote");

public function main() {

    // Invoke the HTTP client and try to retrieve a quote. This result should be a union type consisting `string` and `error`.
    string|error result = brainyQuoteClient->/;

    // If an `error` has occurred, print the error message to the console.
    if result is error {
        return io:println(result.message());
    }

    // If the quote is received, print it to the console (using `io:println()`).
    io:println(result);
}