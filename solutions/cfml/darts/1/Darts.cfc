/**
* Your implementation of the Darts exercise
*/
component {
	
	/**
	* @returns 
	*/
	function score( x, y ) {
		// Implement me here
        var distance = sqr((x * x) + (y * y));
        if (distance <= 1) 
            return 10; 
        if (distance <= 5)
            return 5; 
        if (distance <= 10)
            return 1; 
        return 0;
	}
}