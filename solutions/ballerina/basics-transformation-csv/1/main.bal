import ballerina/io;
import ballerina/log;

type EmployeeData record {
    readonly int employee_id;
    int gas_fill_up_count = 0;
    int last_odometer_reading;
    int total_miles_accrued =0;
    decimal total_fuel_cost = 0;
    decimal total_gallons = 0;
};

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    string[][] input = check io:fileReadCsv(inputFilePath);
    table<EmployeeData> key(employee_id) employeeTable = table [];

    foreach var data in input {
        int employee_id;
        int odometer_reading;
        decimal gallons;
        decimal gas_price;

        var employee_id_result = int:fromString(data[0].trim());
        if (employee_id_result is int) {
            employee_id = employee_id_result;
        } else {
            log:printError("Error parsing employee_id", employee_id_result);
            continue;
        }

        var odometer_reading_result = int:fromString(data[1].trim());
        if (odometer_reading_result is int) {
            odometer_reading = odometer_reading_result;
        } else {
            log:printError("Error parsing odometer_reading", odometer_reading_result);
            continue;
        }

        var gallons_result = decimal:fromString(data[2].trim());
        if (gallons_result is decimal) {
            gallons = gallons_result;
        } else {
            log:printError("Error parsing gallons", gallons_result);
            continue;
        }

        var gas_price_result = decimal:fromString(data[3].trim());
        if (gas_price_result is decimal) {
            gas_price = gas_price_result;
        } else {
            log:printError("Error parsing gas_price", gas_price_result);
            continue;
        }

        if !employeeTable.hasKey(employee_id) {
            employeeTable.add({employee_id, last_odometer_reading: odometer_reading});
        }

        var employee = employeeTable.get(employee_id);
        employee.gas_fill_up_count += 1;
        employee.total_miles_accrued += odometer_reading - employee.last_odometer_reading;
        employee.last_odometer_reading = odometer_reading;
        employee.total_fuel_cost += gallons * gas_price;
        employee.total_gallons += gallons;
    }

    string[][] output = from var data in employeeTable
                            order by data.employee_id
                            select [
            data.employee_id.toString(),
            data.gas_fill_up_count.toString(),
            data.total_fuel_cost.toString(),
            data.total_gallons.toString(),
            data.total_miles_accrued.toString()
        ];

    check io:fileWriteCsv(outputFilePath, output);
}