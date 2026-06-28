type StopwatchState = 'ready' | 'running' | 'stopped'

export class SplitSecondStopwatch {
  private _state: StopwatchState = 'ready'
  private currentLapSeconds = 0
  private previousLapSeconds: number[] = []

  private static parseDuration(duration: string): number {
    const [hours, minutes, seconds] = duration.split(':').map(Number)
    return hours * 3600 + minutes * 60 + seconds
  }

  private static formatDuration(totalSeconds: number): string {
    const hours = Math.floor(totalSeconds / 3600)
    const minutes = Math.floor((totalSeconds % 3600) / 60)
    const seconds = totalSeconds % 60

    return [
      String(hours).padStart(2, '0'),
      String(minutes).padStart(2, '0'),
      String(seconds).padStart(2, '0'),
    ].join(':')
  }

  public get state(): string {
    return this._state
  }

  public get currentLap(): string {
    return SplitSecondStopwatch.formatDuration(this.currentLapSeconds)
  }

  public get total(): string {
    const totalSeconds =
      this.previousLapSeconds.reduce(
        (sum, lap) => sum + lap,
        0,
      ) + this.currentLapSeconds

    return SplitSecondStopwatch.formatDuration(totalSeconds)
  }

  public get previousLaps(): string[] {
    return this.previousLapSeconds.map(
      SplitSecondStopwatch.formatDuration,
    )
  }

  public start(): void {
    if (this._state === 'running') {
      throw new Error(
        'cannot start an already running stopwatch',
      )
    }

    this._state = 'running'
  }

  public stop(): void {
    if (this._state !== 'running') {
      throw new Error(
        'cannot stop a stopwatch that is not running',
      )
    }

    this._state = 'stopped'
  }

  public lap(): void {
    if (this._state !== 'running') {
      throw new Error(
        'cannot lap a stopwatch that is not running',
      )
    }

    this.previousLapSeconds.push(this.currentLapSeconds)
    this.currentLapSeconds = 0
  }

  public reset(): void {
    if (this._state !== 'stopped') {
      throw new Error(
        'cannot reset a stopwatch that is not stopped',
      )
    }

    this._state = 'ready'
    this.currentLapSeconds = 0
    this.previousLapSeconds = []
  }

  public advanceTime(duration: unknown): void {
    if (this._state !== 'running') {
      return
    }

    this.currentLapSeconds +=
      SplitSecondStopwatch.parseDuration(
        duration as string,
      )
  }
}