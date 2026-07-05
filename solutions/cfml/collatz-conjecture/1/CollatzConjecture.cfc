/**
* Your implementation of the CollatzConjecture exercise
*/
component {
	
	/**
	* @returns 
	*/
	function steps( number ) {
		// Implement me here
        var n = number;
        if(n <= 0)
            throw "Only positive integers are allowed";
        var steps = 0;
        while(n != 1){
            if(n%2==0)
                n = int(n/2);
            else
                n = (n*3)+1;
            steps++;
        }
        return steps;
	}
	
}