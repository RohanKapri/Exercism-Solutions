/**
* Your implementation of the Hamming exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function distance( strand1, strand2 ) {
		// Implement me here
         if(strand1.len() != strand2.len())
             throw "left and right strands must be of equal length";
         var s1 = strand1.split("");
         var s2 = strand2.split("");
         var difference = 0;
         for (var i = 1; i <= s1.len(); i++){
             if(s1[i] != s2[i])
                 difference++;
         }
         return difference;
	}
	
}