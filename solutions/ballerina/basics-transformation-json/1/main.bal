import ballerina/io;

type FillUpEntry record {|
    int employeeId;
    int odometerReading;
    decimal gallons;
    decimal gasPrice;
|};

type EmployeeResult record {|
    readonly int employeeId;
    int gasFillUpCount;
    decimal totalFuelCost;
    decimal totalGallons;
    int totalMilesAccrued;
|};

// Process the entries for a single employee
function processEmployee(FillUpEntry[] employeeEntries) returns EmployeeResult {
    var odometerReadings = employeeEntries.map(entry => entry.odometerReading).sort("ascending");

    return {
        employeeId: employeeEntries[0].employeeId,
        gasFillUpCount: employeeEntries.length(),
        totalFuelCost: employeeEntries.reduce(function(decimal total, FillUpEntry entry) returns decimal => (entry.gallons * entry.gasPrice) + total, 0),
        totalGallons: employeeEntries.reduce(function(decimal total, FillUpEntry entry) returns decimal => entry.gallons + total, 0),
        totalMilesAccrued: odometerReadings.pop() - odometerReadings.shift()
    };
}

// Group the entries by employeeId
function groupBy(FillUpEntry[] entries) returns map<FillUpEntry[]> {
    map<FillUpEntry[]> groups = {};

    foreach var entry in entries {
        var employeeId = entry.employeeId.toString();
        if !groups.hasKey(employeeId) {
            groups[employeeId] = [entry];
            continue;
        }
        groups.get(employeeId).push(entry);
    }

    return groups;
}

// Process the fuel records from the input file and write the results to the output file
function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    json entriesJson = check io:fileReadJson(inputFilePath);
    FillUpEntry[] entries = check entriesJson.cloneWithType();
    var entriesById = groupBy(entries);

    var results = from var employeeResult in entriesById.map(processEmployee).toArray()
        order by employeeResult.employeeId
        select employeeResult;

    check io:fileWriteJson(outputFilePath, results.toJson());
}