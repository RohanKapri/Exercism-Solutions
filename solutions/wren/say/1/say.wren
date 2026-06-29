class Say {

  static speak(number) {
    var names = [
      null,
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine",
      "ten",
      "eleven",
      "twelve",
      "thirteen",
      "fourteen",
      "fifteen",
      "sixteen",
      "seventeen",
      "eighteen",
      "nineteen",
    ]

    var decades = [
      null,
      null,
      "twenty",
      "thirty",
      "forty",
      "fifty",
      "sixty",
      "seventy",
      "eighty",
      "ninety"
    ]

    var result = ""
    if (number >= 100) {
      var remainder = number % 100
      var hundreds = (number - remainder) / 100
      number = remainder
      result = names[hundreds] + " hundred "
    }

    if (number >= 20) {
      var remainder = number % 10
      var tens = (number - remainder) / 10
      number = remainder
      result = result + decades[tens]
      if (number > 0) {
        result = result + "-"
      } else {
        result = result + " "
      }
    }
    if (number > 0) {
      result = result + names[number] + " "
    }
    return result
  }

  static say(number) {
    if (number < 0 || number > 999999999999) {
      Fiber.abort("input out of range")
    }

    if (number == 0) {
      return "zero"
    }

    var result = ""
    var units = number % 1000
    number = (number - units) / 1000

    var thousands = number % 1000
    number = (number - thousands) / 1000

    var millions = number % 1000
    number = (number - millions) / 1000

    var billions = number % 1000
    if (billions != 0) {
      result = result + speak(billions) + "billion "
    }
    if (millions != 0) {
      result = result + speak(millions) + "million "
    }
    if (thousands != 0) {
      result = result + speak(thousands) + "thousand "
    }
    if (units != 0) {
      result = result + speak(units)
    }
    return result.trimEnd()
  }
}