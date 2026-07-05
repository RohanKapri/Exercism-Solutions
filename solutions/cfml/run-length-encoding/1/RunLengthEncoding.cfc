/**
* Your implementation of the Run Length Encoding exercise
*/
component {
	
	/**
	* @returns
	*/
	function encode(input) {
		// Implement me here
        if(input == '')
            return "";
        var arrayInput = input.listToArray("");
        var letter = arrayInput[1];
        var encoded = "";
        var count = 0;
        for(var i = 1; i <= arrayInput.len(); i++){
            if(letter != arrayInput[i]){
                if(count == 1)
                    encoded &= letter;
                else
                    encoded &= count & letter;
                letter = arrayInput[i]
                count = 1;
            }
            else{
                count++;
            }
        }
            if(count == 1)
                encoded &= letter
            else{
                encoded &= count & letter;    
        }
        
        
        return encoded;
	}
	
	/**
	* @returns
	*/
	function decode(input) {
		// Implement me here
        if(input == '')
            return "";
        var arrayInput = input.listToArray("");
        var count = 0;
        var decoded = "";
        for(var i = 1; i <= arrayInput.len(); i++){
            if (isNumeric(arrayInput[i])){
                if(count == 0)
                    count += arrayInput[i];
                else
                    count = count*10 + arrayInput[i];
            }
            else{
                if(count != 0)
                {
                    for(var j = 0; j < count; j++){
                        decoded &= arrayInput[i];
                    }
                    count = 0;
                }
                else{
                    decoded &= arrayInput[i];
                }
            }
        }
        for(var j = 0; j < count; j++){
            decoded &= arrayInput[arrayInput.len()];
        }
        
        return decoded;
	}
	
}