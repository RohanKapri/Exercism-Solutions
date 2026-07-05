/**
* Your implementation of the Triangle exercise
*/
component {
	
	function equilateral( array sides ) {
		// Implement me here
        if(!isTriangle(sides))
            return false;
        var a = sides[1];
        var b = sides[2];
        var c = sides[3];
        if (a == b && a == c && b == c)
            return true;
        return false;
	}
	
	function isosceles( array sides ) {
		// Implement me here
        if(!isTriangle(sides))
            return false;
        var a = sides[1];
        var b = sides[2];
        var c = sides[3];
        if (a == b || a == c || b == c)
            return true;
        return false
	}
	
	function scalene( array sides ) {
		// Implement me here
        if(!isTriangle(sides))
            return false;
	    var a = sides[1];
        var b = sides[2];
        var c = sides[3];
        if (a != b && a != c && b != c)
            return true;
        return false;
    }
	function isTriangle(array sides) {
        var a = sides[1];
        var b = sides[2];
        var c = sides[3];
	    if(a == 0 && b == 0 && c == 0)
            return false;
        if (a + b < c || b + c < a || a + c < b)
            return false;
        return true;
	}
}