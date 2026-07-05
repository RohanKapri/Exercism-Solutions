/**
* Your implementation of the CircularBuffer exercise
*/
component {

	/**
	* @returns
	*/
	function init( capacity ) {
		// Implement me here
        variables.buffer = [];
        variables.capacity = capacity;
        return this;
	}

	/**
	* @returns
	*/
	function read() {
		// Implement me here
        if(variables.buffer.len() == 0)
            throw "Empty buffer";
        var r = variables.buffer[1];
        variables.buffer.deleteAt(1);
        return r;
	}

	/**
	* @returns
	*/
	function write( value ) {
		// Implement me here
        if(variables.buffer.len() >= variables.capacity)
            throw "Full buffer";
        variables.buffer.append(value);
	}

	/**
	* @returns
	*/
	function overwrite( value ) {
		// Implement me here
        if(variables.buffer.len() >= variables.capacity){
            variables.buffer.deleteAt(1);
            variables.buffer.append(value);    
        }
        else
            write(value);
        
	}

	/**
	* @returns
	*/
	function clear() {
		// Implement me here
        variables.buffer = [];
	}
}