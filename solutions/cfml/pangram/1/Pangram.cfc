/**
* Your implementation of the Pangram exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function isPangram( sentence ) {
		// Implement me here
        var s = replace(sentence.lCase(), " ", "", "all");
    
        var alfabeto = "abcdefghijklmnopqrstuvwxyz".listToArray("");
        
        var countAlfa = [];
        for (var i = 1; i <= 26; i++) {
            countAlfa.append(0);
        }
        
        var arrayS = s.listToArray("");
        
        for (var i = 1; i <= arrayS.len(); i++) {
            for (var j = 1; j <= 26; j++) {
                if (arrayS[i] == alfabeto[j]) {
                    countAlfa[j]++;
                    break;
                }
            }
        }
        return (!countAlfa.contains(0));
	}
	
}