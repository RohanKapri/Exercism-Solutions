component {
	
	function rebase(inputBase, digits, outputBase) {
		if (inputBase < 2 || outputBase < 2) { 
			return -1; 
		}
		var sum = 0;
		for (digit in digits) {
			if (digit < 0 || digit >= inputBase) {
				return -1;
			}
			sum = sum * inputBase + digit;
		}
        if (sum < 1) { return [0] }
		
		var result = [];
		var digit;
		while (sum > 0) {
			digit = sum % outputBase;
			ArrayInsertAt(result, 1, digit);
			sum = sum \ outputBase;
		}
		return result;
	}
	
}