module LineUp
  def self.format(name : String, number : Int32) : String
    "#{name}, you are the #{ordinal(number)} customer we serve today. Thank you!"
  end

  private def self.ordinal(n)
    suffix =
      case n % 100
      when 11, 12, 13
        "th"
      else
        case n % 10
        when 1
          "st"
        when 2
          "nd"
        when 3
          "rd"
        else
          "th"
        end
      end

    "#{n}#{suffix}"
  end
end