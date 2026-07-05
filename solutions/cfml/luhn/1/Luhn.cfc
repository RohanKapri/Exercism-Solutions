/**
* Your implementation of the Luhn exercise
*/
component {
	
	/**
	* @returns 
	*/
	function valid( value ) {
		// Implement me here
        var cleanValue = replace(value, " ", "", "all");
        if (len(cleanValue) <= 1) {
            return false;
        }
        
        if (reFind("[^0-9]", cleanValue)) {
            return false;
        }
    
        var numberArray = cleanValue.listToArray("").map(function(n) {
            return val(n);
        });
    
        var countFromRight = 1;
        for (var i = numberArray.len(); i >= 1; i--) {
            if (countFromRight % 2 == 0) {
                var doubled = numberArray[i] * 2;
                if (doubled > 9) {
                    doubled -= 9;
                }
                numberArray[i] = doubled;
            }
            countFromRight++;
        }
    
        var sum = 0;
        for (var i = 1; i <= numberArray.len(); i++) {
            sum += numberArray[i];
        }

        return (sum%10 == 0);
	}
	
}