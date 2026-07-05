import ballerina/http;

service on new http:Listener(9090) {
    resource function post greeting(http:Caller caller, http:Request request) returns error? {
        // Extract payload content and append it with the content of the greeting message.
        // The greeting message should be in the following format:
        // "Hello, <payload>!"
        string payload = check request.getTextPayload();
        string greeting = "Hello, " + payload + "!";
        
        check caller->respond(greeting);
    }
}