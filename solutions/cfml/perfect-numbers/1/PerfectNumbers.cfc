/**
* Your implementation of the PerfectNumbers exercise
*/
component {
	
	/**
	* @returns 
	*/
	function classify( number ) {
		// Implement me here
        if(number <= 0)
            throw "Classification is only possible for positive integers";
        if(number == 1)
            return "deficient";
        var sum = 1;
        for ( var i = 2; i * i <= number; i++ ) {
            if ( number % i == 0 ) {
                sum += i; 
                if ( i * i != number ) {
                    sum += ( number / i );
                }
            }
        }
        if (number > sum)
            return "deficient";
        else if (number == sum)
            return "perfect";
        else
            return "abundant";
	}
	
}