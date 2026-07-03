// Write your code for the 'TwoFer' exercise in this file.

func twoFer(name nom : String = "") -> String {

    let dialogue: String  = nom.isEmpty ? "One for you, one for me." : "One for \(nom), one for me."

    return dialogue

}