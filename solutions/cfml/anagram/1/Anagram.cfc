component {

    function anagrams(string subject, array candidates)
    {
        r = [];
        sorted = listSort(lcase(subject), "text", "asc", "");

        for (i = 1; i <= arraylen(candidates); ++i){
            if (sorted == listSort(lcase(candidates[i]), "text", "asc", "") && lcase(subject) != lcase(candidates[i])){
                arrayAppend(r, candidates[i]);
            }
        }

        return r;

    }

}