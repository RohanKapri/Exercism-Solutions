/**
* Your implementation of the SecretHandshake exercise
*/
component {
	
	/**
	* @returns 
	*/
	function commands( number ) {
		// Implement me here
        var binary = [];
        var action = ["wink", "double blink", "close your eyes", "jump"];
        var n = number;
        for (var i = 1; i <= 5; i++) {
            if (n % 2 == 0) {
                binary.append(0);
            } else {
                binary.append(1);
            }
            n = int(n / 2);
        }
        var handshake = [];
        if(binary[5] == 0){
            for(var i = 1; i <= 4; i++){
                if(binary[i] == 1)
                    handshake.append(action[i]);
            }
        }
        else{
            for(var i = 4; i >= 1; i--){
                if(binary[i] == 1)
                    handshake.append(action[i]);
            }
        }
        return handshake;
	}
	
}