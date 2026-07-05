/**
* Your implementation of the ListOps exercise
*/
component {

	/**
	* @returns
	*/
	function append( list1, list2 ) {
		// Implement me here
        var list = [];
        for(var element in list1)
            list.append(element);
        for(var element in list2)
            list.append(element);
        return list;
	}

	/**
	* @returns
	*/
	function concat(lists) {
		// Implement me here
        var result = [];
        for (var item in lists){
            if (isArray(item)) {
                for (var subItem in item)
                    result.append(subItem);
            }
            else
                result.append(item);
        }

        return result;
    }    

	/**
	* @returns
	*/
	function filter( list, fn ) {
		// Implement me here
        var filtedList = [];
        for (var item in list){
            if(fn(item))
                filtedList.append(item);
        }
        return filtedList;
	}

	/**
	* @returns
	*/
	function length( list ) {
		// Implement me here
        return list.len();
	}

	/**
	* @returns
	*/
	function map( list, fn ) {
		// Implement me here
        var result = []
        for(var element in list){
            result.append(fn(element));
        }
        return result;
	}

	/**
	* @returns
	*/
	function foldl( list, fn, initial ) {
		// Implement me here
		var listAus = myIsList(list)?  listToArray(list) : duplicate(list);
    	for(item in listAus){
    	    initial = fn(initial,item);
    	}
    	return initial;
	}
	/**
	* @returns
	*/
	function foldr( list, fn, initial ) {
		// Implement me here
		var listAus = myIsList(list)?  listToArray(list) : duplicate(list);
    	for (i = length(listAus); i >= 1; i--) {
    	    initial = fn(initial,listAus[i]);
    	}
    	return initial;
	}

	/**
	* @returns
	*/
	function reverse( list ) {
		// Implement me here
        for(var i = 1; i <= int(list.len()/2); i++){
            var temp = list[list.len()-i+1];
            list[list.len()-i+1] = list[i];
            list[i] = temp;
        }
        return list;
	}
    function isString(val) {
    return isSimpleValue(val) and getMetaData(val).name eq "java.lang.String";
	}
	function myIsList(val) {
   	return isSimpleValue(val) and getMetaData(val).name eq "java.lang.String" and find(",", val) > 0;
	}
}