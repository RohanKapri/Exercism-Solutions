class Robot
  @@available_names = ('AA000'..'ZZ999').to_a.shuffle

  def initialize
    @name = nil
  end

  def self.forget
    @@available_names = ('AA000'..'ZZ999').to_a.shuffle
  end

  def name
    return @name if @name
    @name = @@available_names.pop
  end

  def reset
    @name = nil
  end

end