/**
* Your implementation of the ResistorColor exercise
*/
component {

    variables.colorList = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"];
	/**
	* @returns 
	*/
	function colorCode( color ) {
		// Implement me here
        return variables.colorList.find(color)-1;
	}
	
	/**
	* @returns 
	*/	
	function colors() {
		// Implement me here
        return variables.colorList;
	}
}