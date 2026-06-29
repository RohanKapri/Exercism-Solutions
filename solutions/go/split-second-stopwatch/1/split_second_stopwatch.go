package splitsecondstopwatch

import "fmt"

type SplitSecondStopwatch struct {
	state        string
	currentLap   int64
	total        int64
	previousLaps []int64
}

func formattedTime(time int64) string {
	hours := time / 3600000
	minutes := (time % 3600000) / 60000
	seconds := (time % 60000) / 1000

	return fmt.Sprintf("%02d:%02d:%02d", hours, minutes, seconds)
}

func timeFromString(s string) int64 {
	var hours, minutes, seconds int64
	fmt.Sscanf(s, "%02d:%02d:%02d", &hours, &minutes, &seconds)
	return hours*3600000 + minutes*60000 + seconds*1000
}

func (sss *SplitSecondStopwatch) Start() error {
	if sss.state == "running" {
		return fmt.Errorf("cannot start an already running stopwatch")
	}

	sss.state = "running"

	return nil
}

func (sss *SplitSecondStopwatch) Stop() error {
	if sss.state != "running" {
		return fmt.Errorf("cannot stop a stopwatch that is not running")
	}

	sss.state = "stopped"

	return nil
}

func (sss *SplitSecondStopwatch) Reset() error {
	if sss.state == "ready" || sss.state == "running" {
		return fmt.Errorf("cannot reset a stopwatch that is not stopped")
	}

	sss.state = "ready"
	sss.total = 0
	sss.currentLap = 0
	sss.previousLaps = nil

	return nil
}

func (sss *SplitSecondStopwatch) Lap() error {
	if sss.state != "running" {
		return fmt.Errorf("cannot lap a stopwatch that is not running")
	}

	sss.previousLaps = append(sss.previousLaps, sss.currentLap)
	sss.currentLap = 0

	return nil
}

func (sss *SplitSecondStopwatch) AdvanceTime(by string) {
	if sss.state != "running" {
		return
	}

	time := timeFromString(by)
	sss.currentLap += time
	sss.total += time
}

func (sss *SplitSecondStopwatch) State() string {
	return sss.state
}

func (sss *SplitSecondStopwatch) CurrentLap() string {
	return formattedTime(sss.currentLap)
}

func (sss *SplitSecondStopwatch) Total() string {
	return formattedTime(sss.total)
}

func (sss *SplitSecondStopwatch) PreviousLaps() []string {
	laps := make([]string, len(sss.previousLaps))
	for i, lap := range sss.previousLaps {
		laps[i] = formattedTime(lap)
	}
	return laps
}

func NewSplitSecondStopwatch() *SplitSecondStopwatch {
	return &SplitSecondStopwatch{state: "ready"}
}