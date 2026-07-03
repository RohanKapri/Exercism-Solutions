func protectSecret(_ secret: String, withPassword password: String) -> (String) -> String {
   { $0 == password ? secret : "Sorry. No hidden secrets here." }
}
func generateCombination(forRoom room: Int, usingFunction f: (Int) -> Int) -> (Int, Int, Int) {
   (f(room), f(f(room)), f(f(f(room))))
}