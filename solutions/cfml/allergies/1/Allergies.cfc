/**
* Your implementation of the Allergies exercise
*/
component {

	/**
	* @returns 
	*/
	public function init( score ) {
        variables.myScore = score;
        
        variables.allergyList = [
            { "name": "eggs", "value": 1 },
            { "name": "peanuts", "value": 2 },
            { "name": "shellfish", "value": 4 },
            { "name": "strawberries", "value": 8 },
            { "name": "tomatoes", "value": 16 },
            { "name": "chocolate", "value": 32 },
            { "name": "pollen", "value": 64 },
            { "name": "cats", "value": 128 }
        ];
        
        return this;
    }

    function allergicTo( item ) {
        var allergenValue = 0;
        
        for (var allergy in variables.allergyList) {
            if (allergy.name == item) {
                allergenValue = allergy.value;
                break;
            }
        }
        
        if (allergenValue == 0) {
            return false;
        }
        return bitAnd(variables.myScore, allergenValue) == allergenValue;
    }
	
    /**
    */
    function list() {
        var result = [];
        
        for (var allergy in variables.allergyList) {
            if (bitAnd( variables.myScore, allergy.value ) == allergy.value) {
                result.append(allergy.name);
            }
        }
        return result;
    }
	
}