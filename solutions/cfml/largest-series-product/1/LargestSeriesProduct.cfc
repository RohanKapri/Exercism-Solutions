/**
* Your implementation of the LargestSeriesProduct exercise
*/
component {
	
	/**
	* @returns 
	*/
	function largestProduct( digits, span ) {
		// Implement me here
        if (span < 0) {
            return -1;
        }
		
		if (span == 0) {
			return 1;
		}
		
		var lenDigits = len(digits);
		if (span > lenDigits) {
			return -1;
		}
		
		if (reFind("[^0-9]", digits)) {
			return -1;
		}
		
		var numArray = digits.listToArray("").map(function(item) {
			return val(item);
		});
		
		var maxProduct = 0;
		var limit = lenDigits - span + 1;
		
		for (var i = 1; i <= limit; i++) {
			var currentProduct = 1;
			
			for (var j = 0; j < span; j++) {
				currentProduct *= numArray[i + j];
			}
			
			if (i == 1 || currentProduct > maxProduct) {
				maxProduct = currentProduct;
			}
		}
		
		return maxProduct;
	}
	
}