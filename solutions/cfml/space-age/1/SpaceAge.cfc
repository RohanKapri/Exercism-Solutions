/**
* Your implementation of the SpaceAge exercise
*/
component {
	
	/**
	* @returns 
	*/
	 function age( planet, seconds ) {
		// Implement me here
         switch (planet){
            case "Mercury":
                 return round(seconds / 0.2408467 / 31557600, 2);
            case "Venus":
                 return round(seconds / 0.61519726 / 31557600, 2);
            case "Earth":
                 return round(seconds / 31557600, 2);
            case "Mars":
                 return round(seconds / 1.8808158 / 31557600, 2);
            case "Jupiter":
                 return round(seconds / 11.862615 / 31557600, 2);
            case "Saturn":
                 return round(seconds / 29.447498 / 31557600, 2);
            case "Uranus":
                 return round(seconds / 84.016846 / 31557600, 2);
            case "Neptune":
                 return round(seconds / 164.79132 / 31557600, 2);
            case "Mercury":
                 return round(seconds / 0.2408467 / 31557600, 2);
                 
         }
	}
	
}