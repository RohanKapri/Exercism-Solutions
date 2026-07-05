/**
* Your implementation of the PigLatin exercise
*/
component {
	
	/**
	* @returns 
	*/
	function translate( phrase ) {
		// Implement me here
        var parole = phrase.split(" ");
        var output = "";
        for(parola in parole){
            if(isVocal(parola.left(1)) || parola.left(2) == 'xr' || parola.left(2) == 'yt')
                output &= addAy(parola) & " ";
            else if(parola.contains("qu")){
                if(isConsonant(parola.left(1)))
                    output &= addAy(moveToEndConsonant(parola)) & " ";
            }
            else if(isConsonant(parola.left(1)) && parola.left(1) != 'y')
                output &= addAy(moveToEndConsonantButNoY(parola)) & " ";
            else if(isConsonant(parola.left(1)))
                output &= addAy(moveToEndConsonant(parola)) & " ";
        
        }
        return output.trim();            
	}
    function moveToEndConsonantButNoY( phrase ) {
        var piece = "";
        var p = phrase.listToArray("");
        
        while (p.len() > 0 && isConsonantButNoY(p[1])) {
            piece &= p[1];
            p.deleteAt(1);
        }
        var newPhrase = arrayToList(p, "") & piece;
        return newPhrase;
    }
    function moveToEndConsonant( phrase ) {
        var piece = "";
        var p = phrase.listToArray("");
        var q = false;
        while (p.len() > 0 && isConsonant(p[1])) {
            piece &= p[1];
            if(p[1] == 'q')
                q = true;
            p.deleteAt(1);
        }
        if(q && p[1] == 'u'){
            piece &= p[1];
            p.deleteAt(1);
        }
        var newPhrase = arrayToList(p, "") & piece;
        return newPhrase;
    }
	function addAy( phrase ) {
	    return phrase &= "ay";
	}
    function isConsonant(letter) {
        var consonant = "bcdfghjklmpqrstvwxyz";
        return consonant.contains(letter);
    }
    function isConsonantButNoY(letter) {
        var consonant = "bcdfghjklmpqrstvwxz";
        return consonant.contains(letter);
    }
    function isVocal(letter) {
        var vocal = "aeiou";
        return vocal.contains(letter);
    }
}