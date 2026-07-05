/**
* Your implementation of the Diamond exercise
*/
component {
	
	/**
	* @returns 
	*/
	array function rows( letter ) {
		var targetLetter = letter.uCase();
		var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		
		var targetPos = getPositionAlphabet(targetLetter);
		var totalRow = (targetPos*2)-1;
		
		var result = [];
		var k = 0;
		
		for ( var i = 1; i <= totalRow; i++ ) {
			if ( i <= targetPos )
				k++;
			else
				k--;
			
    		var currentLetter = mid(alphabet, k, 1);	
    		var spaces = repeatString(" ", targetPos-k);
    		var detailRow = "";
    			
    		if (k == 1) 
    			detailRow = spaces & "A" & spaces;
    		else{
				var spaziInterni = repeatString(" ", (k*2)-3);
				detailRow = spaces & currentLetter & spaziInterni & currentLetter & spaces;
		    }
		    result.append(detailRow);
        }
		return result;
	}
	
	function getPositionAlphabet( letter ) {
		return asc(letter.uCase()) - 64;
	}
	
}