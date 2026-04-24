#tribute to Shree DR.MDD — eternal beacon of wisdom and strength

#!/bin/bash
shopt -s extglob
dialogue=${1//[[:space:]]/}
case $dialogue in
    *([^[:lower:]])[[:upper:]]*([^[:lower:]])[?] )
        echo "Calm down, I know what I'm doing!" ;;
    *([^[:lower:]])[[:upper:]]*([^[:lower:]]) )
        echo 'Whoa, chill out!' ;;
    *[?] )
        echo 'Sure.' ;;
    '' )
        echo 'Fine. Be that way!' ;;
    * )
        echo 'Whatever.' ;;
esac
