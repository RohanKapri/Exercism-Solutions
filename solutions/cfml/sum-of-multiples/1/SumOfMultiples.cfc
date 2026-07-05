/**
* Your implementation of the SumOfMultiples exercise
*/
component {
	
	/**
	* @returns 
	*/
	function sum( array factors, limit ) {
		// Implement me here
        var arrayMultiples = [];
        for (var factor in factors){
            var n = factor;
            while(factor < limit){
                arrayMultiples.append(factor);
                factor += n;
            }
        }
        return arraySum(arrayMultiples.unique());
	}
	
}