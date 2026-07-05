/**
* Your implementation of the Markdown exercise
*/
component {

	tagInList={
		"strong"="__",
		"em"="_",
	};
	ingorePharTags="<h|<ul|<li|<p";
	/**
	* @returns
	*/
	function parse(required string markdown) {
		var lines = listToArray( arguments.markdown, chr( 10 ) );
		var output = [];

		var isInList = false;

		for (var line in lines) {
			var matches = reMatchNoCase( "^[##]+(.*)", line);
			if ( matches.len() ) {
				var hLevel = reMatchNoCase( "[##]+", matches[1])[1];
				line = "<h#hLevel.len()#>" & trim( replace( matches[1], hLevel, "" ) ) & "</h#hLevel.len()#>";
			}

			matches = reMatchNoCase( "\*(.*)", line);
			if ( matches.len() ) {
				if ( !isInList ) {
					isInList = true;
					for(key in structKeyArray(tagInList)){
						matches[1] = addTag(tagInList[key],matches[1],key)
					}

					line = "<ul><li>" & trim( replace( matches[1], "*", "", "all" ) ) & "</li>";

				} 
				else {

					for(key in structKeyArray(tagInList)){
						matches[1] = addTag(tagInList[key],matches[1],key)
					}

					line = "<li>" & trim( replace( matches[1], "*", "", "all" ) ) & "</li>";

				}
			} 
			else {
				if ( isInList ) {
					line = "</ul>" & line;
					isInList = false;
				}
			}

			if ( !reMatchNoCase(ingorePharTags, line ).len() ) {
				line = "<p>#line#</p>";
			}

			for(key in structKeyArray(tagInList)){
				line = addTag(tagInList[key],line,key)
			}
			
			output.append( line );
		}
		var html = arrayToList( output, "" );
		if ( isInList ) {
			html &= "</ul>";
		}

		return html;
	}

	function addTag(spacer,line,tagName){

		var matches = reFindNoCase( "(.*)#spacer#(.*)#spacer#(.*)", line, 0, true );
		if ( matches.len[1] ) {
			var match1 = mid(line, matches.pos[2], matches.len[2]);
			var match2 = mid(line, matches.pos[3], matches.len[3]);
			var match3 = mid(line, matches.pos[4], matches.len[4]);
			line = match1 & "<#tagName#>" & match2 & "</#tagName#>" & match3;
		}
		return line;
	}

}