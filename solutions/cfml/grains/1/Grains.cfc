/**
* Your implementation of the Grains exercise
*/
component {
	
	function square( input ) {
		// Implement me here
        if (input > 64 || input <= 0)
            return -1;
        var output = 1;
        var j = 1
        if (input == 1)
            return 1;
        for(var i = 2; i <= input; i++){
            j = j*2
        }
        return j;
	}
	
	function total( input ) {
		// Implement me here
        var output = 1;
        var j = 1;
        for(var i = 2; i <= 64; i++){
            j = j*2;
            output += j;
        }
        return output;
        
	}
	
}