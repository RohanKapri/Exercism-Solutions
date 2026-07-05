/**
* Your implementation of the TwoFer exercise
*/
component {
	
	/**
	* @returns 
	*/
	function twoFer( name ) {
		// Implement me here
        if(isNull(name))
            return "One for you, one for me.";
        else
            return "One for " & name & ", one for me."
	}
	
}