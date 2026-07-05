/**
* Your implementation of the WordCount exercise
*/
component {
	
	/**
	* @returns 
	*/
	function countwords( sentence ) {
        var result = {};
        var javaArray = sentence.split("[^a-zA-Z0-9']+|\\s+"); 
        
        for (var word in javaArray) {
            var cleanWord = trim(word);
            
            if (left(cleanWord, 1) == "'" && right(cleanWord, 1) == "'") {
                cleanWord = mid(cleanWord, 2, len(cleanWord) - 2);
            }
            
            var minWord = lCase(cleanWord);
            
            if ( len(minWord) > 0 ) {
                if ( structKeyExists( result, minWord ) ) {
                    result[ minWord ]++;
                } else {
                    result[ minWord ] = 1;
                }
            }
        }
        
        return result;
	}
	
}