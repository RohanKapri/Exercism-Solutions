/**
* Your implementation of the Strain exercise
*/
component {
	
	/**
	* @returns 
	*/
	function keep(list, predicate) {
		// Implement me here
        var result = [];
        for (var item in list){
            if(predicate(item))
                result.append(item);
        }
        return result;
	}

	/**
	* @returns 
	*/
	function discard(list, predicate) {
		// Implement me here
	    var result = [];
        for (var item in list){
            if(!predicate(item))
                result.append(item);
        }
        return result;
    }
}