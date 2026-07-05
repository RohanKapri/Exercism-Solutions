component {

    function response(heyBob)
    {

        heyBob = rereplaceNoCase(heyBob, "\s", "", "ALL");

        if (heyBob == "") {
            return "Fine. Be that way!";
        }

        if (refind("[A-Z]", heyBob) > 0 && refind("[a-z]", heyBob) == 0) {
            if (right(heyBob, 1) == "?") {
                return "Calm down, I know what I'm doing!";
            } else {
                return "Whoa, chill out!";
            }

        }


        if (right(heyBob, 1) == "?") {
            return "Sure.";
        }
        return "Whatever.";


    }

}