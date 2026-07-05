import ballerina/http;

const string AIRLINE_URL = "http://localhost:9091/airline";
const string HOTEL_URL = "http://localhost:9092/hotel";
const string CAR_URL = "http://localhost:9093/car";

final http:Client airlineReservationEP = check new (AIRLINE_URL);
final http:Client hotelReservationEP = check new (HOTEL_URL);
final http:Client carRentalEP = check new (CAR_URL);

service /travel on new http:Listener(9090) {
    resource function post arrangeTour(@http:Payload TourArrangement tour) returns http:Response|error? {
        Reservation reservation = {
            name: tour.name,
            arrivalDate: tour.arrivalDate,
            departureDate: tour.departureDate,
            preference: tour.preference.airline
        };

        var airlineReservationResult = makeReservation(airlineReservationEP, "/reserve", reservation, "airline");
        if (airlineReservationResult is error) {
            http:Response response = new ();
            response.statusCode = 400;
            response.setJsonPayload({message: airlineReservationResult.message()});
            return response;
        }

        reservation.preference = tour.preference.accomodation;
        var hotelReservationResult = makeReservation(hotelReservationEP, "/reserve", reservation, "accommodation");
        if (hotelReservationResult is error) {
            http:Response response = new ();
            response.statusCode = 400;
            response.setJsonPayload({message: hotelReservationResult.message()});
            return response;
        }

        reservation.preference = tour.preference.car;
        var carRentalResult = makeReservation(carRentalEP, "/rent", reservation, "car");
        if (carRentalResult is error) {
            http:Response response = new ();
            response.statusCode = 400;
            response.setJsonPayload({message: carRentalResult.message()});
            return response;
        }

        http:Response response = new ();
        response.statusCode = 201;
        response.setJsonPayload({message: "Congratulations! Your journey is ready!!"});
        return response;
    }
}

function makeReservation(http:Client clientEndpoint, string path, Reservation reservation, string preferenceType) returns error? {
    ServiceResponse serviceResponse = check clientEndpoint->post(path, reservation);
    if serviceResponse.status is FAILED {
        string errorMessage;
        if (preferenceType == "airline") {
            errorMessage = "Failed to reserve airline! Provide a valid 'preference' for 'airline' and try again";
        } else if (preferenceType == "accommodation") {
            errorMessage = "Failed to reserve hotel! Provide a valid 'preference' for 'accommodation' and try again";
        } else if (preferenceType == "car") {
            errorMessage = "Failed to rent car! Provide a valid 'preference' for 'car' and try again";
        } else {
            errorMessage = "Failed to make reservation! Provide a valid 'preference' and try again";
        }
        return error(errorMessage);
    }
}

# The payload type received from the tour arrangement service.
#
# + name - Name of the tourist
# + arrivalDate - The arrival date of the tourist
# + departureDate - The departure date of the tourist
# + preference - The preferences for the airline, hotel, and the car rental
type TourArrangement record {|
    string name;
    string arrivalDate;
    string departureDate;
    Preference preference;
|};

# The different prefenrences for the tour.
#
# + airline - The preference for airline ticket. Can be `First`, `Bussiness`, `Economy`
# + accomodation - The prefenerece for the hotel reservarion. Can be `delux` or `superior`
# + car - The preference for the car rental. Can be `air conditioned`, or `normal`
type Preference record {|
    string airline;
    string accomodation;
    string car;
|};

// Define a record type to send requests to the reservation services.
type Reservation record {|
    string name;
    string arrivalDate;
    string departureDate;
    string preference;
|};

// The response type received from the reservation services
type ServiceResponse record {|
    Status status;
|};

// Possible statuses of the reservation service responses
enum Status {
    SUCCESS = "Success",
    FAILED = "Failed"
}