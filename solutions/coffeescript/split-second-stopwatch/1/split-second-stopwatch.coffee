class SplitSecondStopwatch
  constructor: ->
    @_state = 'ready'
    @_totalSeconds = 0
    @_currentSeconds = 0
    @_previousLaps = []

  state: -> @_state

  currentLap: -> @_timestamp @_currentSeconds

  total: -> @_timestamp @_totalSeconds

  previousLaps: -> @_previousLaps.map @_timestamp

  start: ->
    if @_state is 'running'
      throw new Error 'cannot start an already running stopwatch'
    @_state = 'running'

  stop: ->
    if @_state isnt 'running'
      throw new Error 'cannot stop a stopwatch that is not running'
    @_state = 'stopped'

  lap: ->
    if @_state isnt 'running'
      throw new Error 'cannot lap a stopwatch that is not running'
    @_previousLaps.push @_currentSeconds
    @_currentSeconds = 0

  reset: ->
    if @_state isnt 'stopped'
      throw new Error 'cannot reset a stopwatch that is not stopped'
    @_state = 'ready'
    @_totalSeconds = 0
    @_currentSeconds = 0
    @_previousLaps = []

  advanceTime: (amount) ->
    seconds = @_asSeconds(amount)
    if @_state is 'running'
      @_currentSeconds += seconds
      @_totalSeconds += seconds

  _asSeconds: (duration) ->
    [h, m, s] = duration.split(':').map Number
    h * 3600 + m * 60 + s

  _timestamp: (seconds) ->
    h = Math.floor seconds / 3600
    m = Math.floor (seconds % 3600) / 60
    s = seconds % 60
    
    padded = (num) ->
      str = num.toString()
      if str.length < 2 then "0#{str}" else str
    
    "#{padded h}:#{padded m}:#{padded s}"

module.exports = SplitSecondStopwatch