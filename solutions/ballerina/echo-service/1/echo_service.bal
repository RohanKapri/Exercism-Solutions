import ballerina/http;

service / on new http:Listener(8080) {

    // This resource should accept a GET request at the path `/echo` and have a query param `sound`
    resource function get echo(http:Caller caller, http:Request req) returns error? {
        string? sound = req.getQueryParamValue("sound");
        check caller->respond(sound ?: "No sound provided");
    }

    // This resource should accept a GET request at the path `/echo/definition`
    resource function get echo/definition(http:Caller caller) returns error? {
        string definition = "A sound or series of sounds caused by the reflection of sound waves from a surface back to the listener.";
        check caller->respond(definition);
    }
}