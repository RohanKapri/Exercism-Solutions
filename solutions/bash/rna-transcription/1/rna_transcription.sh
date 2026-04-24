#for Shree DR.MDD

dna_input=$1
declare -A mapper=(
  ["G"]="C"
  ["C"]="G"
  ["T"]="A"
  ["A"]="U"
)

result_chain=""

for (( idx=0; idx<${#dna_input}; idx++ )); do
  base=${dna_input:$idx:1}
  pair=${mapper[$base]}
  if [ -z "$pair" ]; then
    echo Invalid nucleotide detected.
    exit 1
  fi
  result_chain+=$pair
done

echo $result_chain
