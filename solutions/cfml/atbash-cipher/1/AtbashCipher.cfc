/**
* Your implementation of the AtbashCipher exercise
*/
component {
	function encode( phrase ) {
		var plain  = "abcdefghijklmnopqrstuvwxyz";
		var cipher = "zyxwvutsrqponmlkjihgfedcba";
		var digits = "0123456789";
	
		var cleanPhrase = phrase.lCase();
		var encoded = "";
		var counter = 0;
		
		for(var i = 1; i <= len( cleanPhrase ); i++){
			var letter = mid(cleanPhrase, i, 1);
			var position = find(letter, plain);
			
			if(position > 0){
				if(counter > 0 && counter % 5 == 0) 
                    encoded &= " ";
				
				encoded &= mid(cipher, position, 1);
				counter++;
			} 
			else if (find( letter, digits ) > 0){
				if(counter > 0 && counter % 5 == 0)
                    encoded &= " "; 
				encoded &= letter;
				counter++;
			}
		}
		return encoded;
	}
	
	function decode( phrase ) {
		var plain  = "abcdefghijklmnopqrstuvwxyz";
		var cipher = "zyxwvutsrqponmlkjihgfedcba";
		var digits = "0123456789";
		
		var cleanPhrase = phrase.lCase();
		var decoded = "";
		
		for(var i = 1; i <= len(cleanPhrase); i++){
			var letter = mid(cleanPhrase, i, 1);
			
			var position = find(letter, cipher);
			
			if(position > 0)
				decoded &= mid(plain, position, 1);
			else if (find(letter, digits) > 0)
				decoded &= letter;
		}
		return decoded;
	}
}