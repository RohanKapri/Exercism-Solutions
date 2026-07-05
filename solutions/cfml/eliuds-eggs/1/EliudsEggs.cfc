/**
* Your implementation of the EliudsEggs exercise
*/
component {

	/**
	* @returns 
	*/
	function eggCount( number ) {
		// Implement me here
        var n = number;
        var count = 0;
        while(n > 0){
            if(n%2 != 0)
                count++;
            n = floor(n/2);
        }
        return count;
	}

}