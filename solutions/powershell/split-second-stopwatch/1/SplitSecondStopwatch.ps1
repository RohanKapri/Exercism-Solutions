<#
.SYNOPSIS
Build a stopwatch to keep precise track of lap times
.DESCRIPTION
Implement a stopwatch with these four commands (start, stop, lap, and reset) to keep track of:
    1. The current lap's tracked time
    2. Previously recorded lap times
The stopwatch also should able to report infomation about : current lap, total time and time of previous laps.

.NOTES
Input and comparison in test suite using string in the format of "HH:MM:SS" for ease of reading.
However implementation should use Timespan as suggested.
#>

Enum States { Ready; Running; Stopped }

class ClockWrapper {
    <#
    This class act as a simple timeprovider for the stopwatch
    DO NOT DELETE THIS CLASS
    #>
    [datetime]$Now
    ClockWrapper() { $this.Now = [datetime]::new(0) }

    [void] Advance([string]$span) { $this.Now += [TimeSpan]::Parse($span) }
}

class SplitSecondStopwatch {
    [States]$State = [States]::Ready
    [TimeSpan[]]$PreviousLaps = @()
    [ClockWrapper] hidden $clock
    [datetime] hidden $startTime
    [TimeSpan] hidden $tracking = [TimeSpan]::Zero

    SplitSecondStopwatch([ClockWrapper]$clock) { $this.clock = $clock }

    [TimeSpan] GetCurrentLap() {
        return $this.tracking + (($this.State -eq [States]::Running) ? ($this.clock.Now - $this.startTime) : [TimeSpan]::Zero)
    }

    [TimeSpan] GetTotal() {
        $previousLapsTotal = ($this.PreviousLaps | ForEach-Object { $_.TotalMilliseconds } | Measure-Object -Sum).Sum
        return $this.GetCurrentLap() + [TimeSpan]::FromMilliseconds($previousLapsTotal)
    }

    [void] Start() {
        if ($this.State -eq [States]::Running) { throw "Invalid operation" }
        $this.startTime = $this.clock.Now
        $this.State = [States]::Running
    }

    [void] Stop() {
        if ($this.State -ne [States]::Running) { throw "Invalid operation" }
        $this.tracking = $this.clock.Now - $this.startTime
        $this.State = [States]::Stopped
    }

    [void] Lap() {
        if ($this.State -ne [States]::Running) { throw "Invalid operation" }
        $this.PreviousLaps += $this.GetCurrentLap()
        $this.startTime = $this.clock.Now
    }

    [void] Reset() {
        if ($this.State -ne [States]::Stopped) { throw "Invalid operation" }
        $this.State = [States]::Ready
        $this.PreviousLaps = @()
        $this.tracking = [TimeSpan]::Zero
    }
}