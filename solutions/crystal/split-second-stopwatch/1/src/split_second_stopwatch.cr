class SplitSecondStopwatch
  def initialize
    @state = "ready"
    @current_lap = 0
    @total = 0
    @previous_laps = [] of Int32
  end

  def state
    @state
  end

  def start
    raise ArgumentError.new if @state == "running"

    @state = "running"
  end

  def stop
    raise ArgumentError.new unless @state == "running"

    @state = "stopped"
  end

  def lap
    raise ArgumentError.new unless @state == "running"

    @previous_laps << @current_lap
    @current_lap = 0
  end

  def reset
    raise ArgumentError.new unless @state == "stopped"

    initialize
  end

  def current_lap
    render_time(@current_lap)
  end

  def advance_time(time)
    if @state == "running"
      seconds = seconds_from_time_string(time)
      @total += seconds
      @current_lap += seconds
    end
  end

  def total
    render_time(@total)
  end

  def previous_laps
    @previous_laps.map { |lap| render_time(lap) }
  end

  private def render_time(elapsed_seconds)
    hours = elapsed_seconds / 3600
    minutes = (elapsed_seconds % 3600) / 60
    seconds = elapsed_seconds % 60

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  private def seconds_from_time_string(time_string)
    parts = time_string.split(":").map(&.to_i)
    hours = parts[0]
    minutes = parts[1]
    seconds = parts[2]

    (hours * 3600) + (minutes * 60) + seconds
  end
end