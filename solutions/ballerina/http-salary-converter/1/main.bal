import ballerina/http;

// Define the API URL as a configurable variable
configurable string apiUrl = "http://localhost:8080";

// Create a new HTTP client for the exchange rate API
final http:Client exchangeClient = check new (string `${apiUrl}/rates`);

// Define a record type for the API response
type Response readonly & record {|
    string base; // The base currency
    map<decimal> rates; // The conversion rates for other currencies
|};

// Function to convert a salary from one currency to another
public function convertSalary(decimal salary, string sourceCurrency, string localCurrency) returns decimal|error {
    // Make a GET request to the API for the source currency
    Response|error res = exchangeClient->get(string `/${sourceCurrency}`);

    // If the API request fails, return an error
    if res is error {
        return error("currency not found");
    } else {
        // If the API request is successful, find the conversion rate for the local currency
        decimal? cur = res.rates[localCurrency];
        // If there's no conversion rate for the local currency, return an error
        if cur is null {
            return error("no currency for conversion");
        } else {
            // If there's a conversion rate for the local currency, multiply it by the salary and return the result
            return cur * salary;
        }
    }
}