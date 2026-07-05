/**
* Your implementation of the BinarySearch exercise
*/
component {
	
	/**
	* @returns 
	*/
	function find( array, value ) {
		// Implement me here
        var found = false;
        var max = array.len();
        var min = 1;
        while (min <= max) {
            var mid = int((min+max)/2);
            if(value == array[mid]){
                return mid;
            }
            else if(value > array[mid]){
                min = mid+1;
            }
            else{
                max = mid-1;
            }
        }
        throw "value not in array";
	}
	
}