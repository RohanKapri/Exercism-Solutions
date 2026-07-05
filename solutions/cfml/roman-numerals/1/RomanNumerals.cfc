/**
* Your implementation of the RomanNumerals exercise
*/
component {
	
	/**
	* @returns 
	*/
	function roman( number ) {
    var result = "";
    var n = number;

    var arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var romanLetters = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

    var totalValues = arabicValues.len();
    for (var i = 1; i <= totalValues; i++){
        
        while (n >= arabicValues[i]){
            result &= romanLetters[i];
            n -= arabicValues[i];
        }
        
    }
    return result;
}
	
}