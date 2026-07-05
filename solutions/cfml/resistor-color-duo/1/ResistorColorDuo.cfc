/**
* Your implementation of the ResistorColorDuo exercise
*/
component {
	
	/**
	* @returns 
	*/
     variables.colorList = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"];
	function value( colors ) {
		// Implement me here
        var output = ""
        for(var i = 1; i <= 2; i++){
            output &= variables.colorList.find(colors[i])-1
        }
        return output;
            
    }
	
}