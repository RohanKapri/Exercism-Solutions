import ballerina/io;

type EmployeeData record {|
    readonly string employeeId;
    int lastOdometerReading;
    int gasFillUpCount = 0;
    decimal totalFuelCost = 0;
    decimal totalGallons = 0;
    int totalMilesAccrued = 0;
|};

xmlns "http://www.so2w.org" as s;

function processFuelEvent(xml:Element fuelEvent, table<EmployeeData> key(employeeId) employeeTable) returns error? {
    string employeeId = check fuelEvent.employeeId;
    int odometerReading = check int:fromString((fuelEvent/<s:odometerReading>).data());
    decimal gallons = check decimal:fromString((fuelEvent/<s:gallons>).data());
    decimal gasPrice = check decimal:fromString((fuelEvent/<s:gasPrice>).data());

    if !employeeTable.hasKey(employeeId) {
        employeeTable.add({employeeId, lastOdometerReading: odometerReading});
    }

    EmployeeData data = employeeTable.get(employeeId);
    data.gasFillUpCount += 1;
    data.totalMilesAccrued += odometerReading - data.lastOdometerReading;
    data.lastOdometerReading = odometerReading;
    data.totalGallons += gallons;
    data.totalFuelCost += gasPrice * gallons;
}

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    xml<xml:Element|xml:Comment|xml:ProcessingInstruction|xml:Text> xmlResult = check io:fileReadXml(inputFilePath);
    table<EmployeeData> key(employeeId) employeeTable = table [];

    foreach var item in xmlResult/<s:FuelEvent> {
        check processFuelEvent(item, employeeTable);
    }

    var sortedTable = from EmployeeData e in employeeTable
        order by e.employeeId
        select e;

    xml:Element output = xml `<s:employeeFuelRecords xmlns:s="http://www.so2w.org"></s:employeeFuelRecords>`;
    var children = output.getChildren();

    foreach EmployeeData next in sortedTable {
        children += xml `<s:employeeFuelRecord employeeId="${next.employeeId}"><s:gasFillUpCount>${next.gasFillUpCount}</s:gasFillUpCount><s:totalFuelCost>${next.totalFuelCost}</s:totalFuelCost><s:totalGallons>${next.totalGallons}</s:totalGallons><s:totalMilesAccrued>${next.totalMilesAccrued}</s:totalMilesAccrued></s:employeeFuelRecord>`;
    }

    output.setChildren(children);
    check io:fileWriteXml(outputFilePath, output);
}