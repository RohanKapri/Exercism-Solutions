/**
* Your implementation of the NucleotideCount exercise
*/
component {
	
	/**
	* @returns 
	*/
	function nucleotideCounts( strand ) {
		// Implement me here
        var count = {
            'A' : 0,
            'C' : 0,
            'G' : 0,
            'T' : 0
        }
        
        var array = strand.uCase().listToArray("");
        for(var n in array){
            if (structKeyExists( count, n )) {
                count[n]++;
            }
            else
                throw "Invalid nucleotide in strand";
        }
        return count;
	}
	
}