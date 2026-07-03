let birthday: String = "Birthday"
let valentine: String = "Valentine's Day"
let anniversary: String = "Anniversary"
let space = " " as Character
let exclamation = "!" as Character
func buildSign(for occasion: String, name: String) -> String {
  return "Happy" + String(space) + "\(occasion)" +
    String(space) + "\(name)" + String(exclamation)
}
func graduationFor(name: String, year: Int) -> String {
  return "Congratulations" + String(space) +
    "\(name)" + String(exclamation) + "\n" + "Class of \(year)"
}
func costOf(sign: String) -> Int {
  return sign.count * 2 + 20
}