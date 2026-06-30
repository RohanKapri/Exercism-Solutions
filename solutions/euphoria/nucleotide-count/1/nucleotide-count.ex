include std/map.e

constant nucleotide_map_template = {{'A',0},{'C',0},{'G',0},{'T',0}}

public function counts(sequence nucleotide_sequence)
  map:map nucleotide_counts = map:new_from_kvpairs(nucleotide_map_template)

  for i = 1 to length(nucleotide_sequence) do
    integer current_nucleotide = nucleotide_sequence[i]
    if not map:has(nucleotide_counts, current_nucleotide) then
        return 0
    end if
    map:put(nucleotide_counts, current_nucleotide, 1, map:ADD)
  end for

  return nucleotide_counts
end function