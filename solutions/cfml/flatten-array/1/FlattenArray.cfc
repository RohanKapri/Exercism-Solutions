/**
* Your implementation of the FlattenArray exercise
*/
component {
	
	/**
	* @returns 
	*/
	function flatten( array ) {
        var risultato = [];

        for (var elemento in array) {
            
            if (isNull(elemento)) {
                continue;
            }
            
            if (isArray(elemento)) {
                risultato.addAll( flatten(elemento) );
            } 
            else {
                risultato.append(elemento);
            }
        }
        return risultato;
	}
	
}