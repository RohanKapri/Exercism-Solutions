let two_fer name_opt =
  match name_opt with
  | Some name -> "One for " ^ name ^ ", one for me."
  | None      -> "One for you, one for me."