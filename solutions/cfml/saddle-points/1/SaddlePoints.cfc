/**
* Your implementation of the SaddlePoints exercise
*/
component {
	
	/**
	* @returns 
	*/
	function saddlePoints( matrix ) {
		// Implement me here
		size = len(matrix);
		res = [];
		for(i=1;i<=size;i++){
			if(len(matrix[size])==0){
				break;
			}
 			for(j=1;j<=size;j++){
 			  	tallest= true;
 				smallest = true;
 				// writeOutput("<br>"&input[i][j]&" b")
 				//writeOutput("<br> <br>")
 				for(var h=1;h<=size;h++){
 				   if(h!=j&&matrix[i][j]<matrix[i][h]){
 			       tallest = false;
 			       break;
 			   	   }
 			    }
			
			
 			  	for(var h=1;h<=size;h++){
 			   		//writeOutput(input[h][j]&" i")
 			  		if(h!=i&&matrix[i][j]>matrix[h][j]){
 			       		smallest = false;
 			       		break;
 			   		}
 			  	}
 			  	//writeOutput("<br>")
			
 			  	if(smallest&&tallest){
 			   		res.append({"row":i-1,"column":j-1});
 			  	}
 			}
 		}
		return res;

	}
	
}