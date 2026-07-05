/**
* Your implementation of the Isogram exercise
*/
component {
	
	/**
	* @returns 
	*/
	function isIsogram( input ) {
		// Implement me here
        letters = input.uCase()
						.listToArray('')
						.filter(function(c) { return c >= 'A' && c <= 'Z'})
						.toList()
		uniques = letters.listRemoveDuplicates()
		return len(uniques) == len(letters)
    }
	
}