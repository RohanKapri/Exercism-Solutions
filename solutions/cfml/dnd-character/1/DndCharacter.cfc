/**
* Your implementation of the Dnd Character exercise
*/
component {
	// Implement strength, dexterity, constitution, wisdom, charisma, hitpoints
	this.strength = ability();
	this.dexterity = ability();
	this.constitution = ability();
	this.intelligence = ability();
	this.wisdom = ability();
	this.charisma = ability();
		
	this.hitpoints = 10 + abilityModifier(this.constitution);
		
	function abilityModifier( score ) {
		// Implement me here
        return floor((score - 10) / 2);
	}
	
	function ability() {
		// Implement me here
        var diceThrows = [];
        for (var i = 1; i <= 4; i++)
            diceThrows.append(randRange(1,6));
        
        diceThrows.sort("numeric")
        return diceThrows["2"] + diceThrows["3"] + diceThrows["4"];
	}

}