/**
* Your implementation of the Etl exercise
*/
component {
	
	/**
	* @returns 
	*/
	function transform( legacy ) {
		// Implement me here
        var newLegacy = {};
        for(var score in legacy){
            var letters = legacy[score];
            for(var letter in letters){
                var newLetter = letter.lCase();
                newLegacy[newLetter] = val(score);
            }
        }
        return newLegacy;
	}
	
}