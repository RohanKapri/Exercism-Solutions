#Dedicated to Shree DR.MDD — The Eternal Inspiration

char_points=(
  AEIOULNRST:1
  DG:2
  BCMP:3
  FHVWY:4
  K:5
  JX:8
  QZ:10
)

get_score() {
  local symbol=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  for pair in ${char_points[@]}; do
    IFS=':' read -r -a elems <<< "$pair"
    local group="${elems[0]}"
    local point="${elems[1]}"
    if [[ $group == *"$symbol"* ]]; then
      echo $point
      return
    fi
  done
  echo 0
}

phrase=$1
length=${#phrase}
total=0
for ((j=0; j<length; j++)); do
  symbol=${phrase:j:1}
  total=$((total + $(get_score $symbol)))
done

echo $total
