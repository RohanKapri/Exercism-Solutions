public function speak(string? name = ()) returns string {
    if name is string {
        return "One for " + name + ", one for me.";
    } else {
        return "One for you, one for me.";
    }
}