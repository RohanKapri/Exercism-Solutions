/**
* Your implementation of the ScrabbleScore exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function score( word ) {
		// Implement me here
         var OneValue = ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"];
         var TwoValue = ["d", "g"];
         var ThreeValue = ["b", "c", "m", "p"];
         var FourValue = ["f", "h", "v", "w", "y"];
         var FiveValue = ["k"];
         var EightValue = ["j", "x"];
         var TenValue = ["q", "z"];

        var arrayWord = word.lCase().listToArray("");
        var score = 0;
        for (var letter in arrayWord){
            if(OneValue.contains(letter))
                score+=1;
            if(TwoValue.contains(letter))
                score+=2;
            if(ThreeValue.contains(letter))
                score+=3;
            if(FourValue.contains(letter))
                score+=4;
            if(FiveValue.contains(letter))
                score+=5;
            if(EightValue.contains(letter))
                score+=8;
            if(TenValue.contains(letter))
                score+=10;
        }
         return score;
	}
	
}