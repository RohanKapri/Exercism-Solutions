import Extra

open Extra

namespace ReverseList

@[csimp]
theorem custom_reverse_eq_spec_reverse : @custom_reverse = @List.reverse := by
  funext _ xs
  induction xs with
  | nil           => rfl
  | cons _ _ hr => simpa [custom_reverse, List.reverse_cons] using hr

end ReverseList