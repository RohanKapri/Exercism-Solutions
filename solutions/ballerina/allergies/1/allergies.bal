class Allergies {
    private int score;

    function init(int score) {
        self.score = score;
    }

    function allergicTo(string candidate) returns boolean {
        map<int> allergens = {"eggs": 1, "peanuts": 2, "shellfish": 4, "strawberries": 8, "tomatoes": 16, "chocolate": 32, "pollen": 64, "cats": 128};
        return (self.score & allergens[candidate]) != 0;
    }

    function list() returns string[] {
        map<int> allergens = {"eggs": 1, "peanuts": 2, "shellfish": 4, "strawberries": 8, "tomatoes": 16, "chocolate": 32, "pollen": 64, "cats": 128};
        string[] result = [];
        foreach var [allergen, value] in allergens.entries() {
            if ((self.score & value) != 0) {
                result.push(allergen);
            }
        }
        return result;
    }
}