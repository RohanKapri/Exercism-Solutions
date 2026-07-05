/**
* Your implementation of the Raindrops exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function convert( number ) {
		// Implement me here
         var output = "";
         if (number % 3 == 0)
             output &= "Pling";
         if (number % 5 == 0)
             output&= "Plang";
         if (number % 7 == 0)
             output&= "Plong";
         if(output == "")
             output = number;
         return output;
         
	}
	
}