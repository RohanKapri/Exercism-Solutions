/**
* Your implementation of the RobotSimulator exercise
*/
component {

	/**
	* @returns 
	*/
	function init( required x, required y, required direction ){
		// Implement me here
        variables.x = x;
        variables.y = y;
        variables.direction = direction;
        return this;
	}
	
	/**
	* @returns 
	*/
	function move( commands ){
		// Implement me here
        var directions = ["north","east","south","west"];
        var arrayCommands = commands.uCase().listToArray("");
        for(var command in arrayCommands){
             if(command == "A"){
                 if(variables.direction == "north")
                     variables.y++;
                 if(variables.direction == "east")
                     variables.x++;
                 if(variables.direction == "south")
                     variables.y--;
                 if(variables.direction == "west")
                     variables.x--;
             }
            else if(command == "R"){
                var d = directions.find(variables.direction);
                d++;
                if(d>4)
                    d = 1;
                variables.direction = directions[d];
            }
            else if(command == "L"){
                var d = directions.find(variables.direction);
                d--;
                if(d<1)
                    d = 4;
                variables.directions = directions[d];
            }
            else
                throw "Incorrect command";
        }
	}
    function getx() {
        return variables.x;
    }

    function gety() {
        return variables.y;
    }

    function getdirection() {
        return variables.direction;
    }

}