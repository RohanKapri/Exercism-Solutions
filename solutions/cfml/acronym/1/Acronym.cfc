/**
* Your implementation of the Acronym exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function abbreviate( phrase ) {
		// Implement me here
        var words = phrase.replace("-", " ", "all").split(" ");
        var acronym = "";
         
        for (var word in words){        
            if (word.len() > 0) {
                acronym &= word.left(1);
            }
        }
        return acronym;
     }
	
}