/**
* Your implementation of the Queen Attack exercise
*/
component {
	
	/**
	* @returns
	*/
	function create(row, col) {
		// Implement me here
        if (row < 0 || row > 7 || col < 0 || col > 7)
            return false;
        return {
            "row": row,
            "col": col
        };;
	}

	function canAttack(queen1, queen2) {
		// Implement me here
        if(queen1["row"] == queen2["row"])
            return true;
        if(queen1["col"] == queen2["col"])
            return true;
        if (abs(queen1["col"] - queen2["col"]) == abs(queen1["row"] - queen2["row"]))
            return true;
        return false;
	}

}