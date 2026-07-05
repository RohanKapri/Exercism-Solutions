component {
	public string function toRNA( required string DNA ) {
		var dict = {
			"G" = "C",
			"C" = "G",
			"T" = "A",
			"A" = "U"
		};
		var splitStrand = DNA.split("");
		var r = "";
		for(var c in splitStrand){
			if (structKeyExists(dict, c)){
				r = r & dict[c];
			}
		}
		return r;
	}
}