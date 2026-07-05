/**
* Your implementation of the NthPrime exercise
*/
component {
	
	/**
	* @returns 
	*/
	function prime( number ) {
		// Implement me here
        if (number == 0) {
            throw "there is no zeroth prime";
        }

        if (number == 1)
            return 2;
        var count = 1;
        var n = 1;
        while (number != count){
            n += 2;
            if (isPrime(n))
                count++; 
        }
        return n;    
	}

    function isPrime( n ){
        var limit = sqr(n);
        for (var i = 3; i <= limit; i+=2) {
            if(n%i == 0)
                return false;
        }
        return true;
    }
	
}