/**
* Your implementation of the SquareRoot exercise
*/
component {
	
	/**
	* @returns 
	*/
	function squareRoot( radicand ) {
		// Implement me here
        for(var i = 1; i <= int(radicand/2); i++){
            if(radicand / i == i)
                return i;
        }
        return 1;
	}
	
}