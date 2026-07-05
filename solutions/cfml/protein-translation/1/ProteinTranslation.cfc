/**
* Your implementation of the ProteinTranslation exercise
*/
component {

	/**
	* @returns 
	*/
	function proteins( strand ) {
		// Implement me here
        var aminoCodonMap = {
            "Methionine" : ["AUG"],
            "Phenylalanine" : ["UUU","UUC"],
            "Leucine" : ["UUA", "UUG"],
            "Serine" : ["UCU","UCC","UCA","UCG"],
            "Tyrosine" : ["UAU", "UAC"],
            "Cysteine" : ["UGU","UGC"],
            "Tryptophan" : ["UGG"],
            "STOP" : ["UAA","UAG","UGA"]
        }
        
        var codons = [];
        for(var i = 1; i <= strand.len(); i+=3){
            codons.append(mid(strand,i,3));
        }
        
        var result = [];
        for(var codon in codons){
            var found = false;
            for(var aminoacid in aminoCodonMap){
                if(aminoCodonMap[aminoacid].contains(codon)){
                    found = true;
                    if(aminoacid == "STOP")
                        return result;
                    result.append(aminoacid);
                }                  
            }
            if(!found)
                    throw "Invalid codon";  
        }
        return result;
	}

}