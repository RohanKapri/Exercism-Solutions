class BafflingBirthdays
  def self.shared_birthday(birthdates : Array(Time)) : Bool
    birthdays = birthdates.map(&.to_s("%m-%d"))
    Set(String).new(birthdays).size < birthdays.size
  end

  def self.random_birthdates(size : Int) : Array(Time)
    Array.new(size) do
      Time.utc(1999, 1, 1) + rand(0..364).days
    end
  end

  def self.estimated_probability_of_shared_birthday(size : Int) : Float
    trials = 10000
    shared_count = (1..trials).count do
      shared_birthday(random_birthdates(size))
    end
    (shared_count.to_f / trials) * 100
  end
end