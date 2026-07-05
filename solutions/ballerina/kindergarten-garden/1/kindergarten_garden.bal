import ballerina/regex as re;

class KindergartenGarden {
    string[] names = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"];
    map<string> plantNames = { "G": "grass", "C": "clover", "R": "radishes", "V": "violets" };
    map<string[]> garden = {};

    function init(string diagram) {
        self.garden = self.parseDiagram(diagram);
    }

    function parseDiagram(string diagram) returns map<string[]> {
        string[] rows = re:split(diagram, "\n");
        map<string[]> gardenMap = {};
        int studentIndex = 0;

        foreach var i in 0..<rows[0].length() / 2 {
            string student = self.names[studentIndex];
            string[] plants = [
                self.plantNames[rows[0].substring(i * 2, i * 2 + 1)] ?: "unknown",
                self.plantNames[rows[0].substring(i * 2 + 1, i * 2 + 2)] ?: "unknown",
                self.plantNames[rows[1].substring(i * 2, i * 2 + 1)] ?: "unknown",
                self.plantNames[rows[1].substring(i * 2 + 1, i * 2 + 2)] ?: "unknown"
            ];
            gardenMap[student] = plants;
            studentIndex += 1;
        }
        return gardenMap;
    }

    function plants(string student) returns string[] {
        return self.garden[student] ?: [];
    }
}