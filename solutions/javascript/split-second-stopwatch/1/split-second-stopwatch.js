export class SplitSecondStopwatch {
  constructor() {
    this._state = 'ready';
    this._currentLap = '00:00:00';
    this._previousLaps = [];
  }

  get state() {
    return this._state;
  }

  get currentLap() {
    return this._currentLap;
  }

  get total() {
    let [a, b, c] = this._currentLap.split(':');
    let tFirstThingy = Number(a);
    let tSecondThingy = Number(b);
    let tThirdThingy = Number(c);

    for (let k = 0; k < this._previousLaps.length; k++) {
      let [A, B, C] = this._previousLaps[k].split(':');
      let pFirstThingy = Number(A);
      let pSecondThingy = Number(B);
      let pThirdThingy = Number(C);
      
      tFirstThingy += pFirstThingy;
      tSecondThingy += pSecondThingy;
      tThirdThingy += pThirdThingy;
    }
    let array = [tFirstThingy, tSecondThingy, tThirdThingy];

    for (let i = 2; i >= 0; i--) {
      //making numbers less than 60
      if (array[i] >= 60) {
        array[i] %= 60;
        array[i - 1] += 1;
      }
      
      //adding zero at the start
      if (array[i] < 10) {
        array[i] = '0' + String(array[i]);
      }


    }
      
    return array.join(':');
  }

  get previousLaps() {
    return this._previousLaps;
  }

  start() {
    if (this._state === 'running') {
      throw new Error('cannot start an already running stopwatch');
    } else {
      this._state = 'running';
    }
  }

  stop() {
    if (this._state !== 'running') {
      throw new Error('cannot stop a stopwatch that is not running')
    } else {
      this._state = 'stopped';
    }
  }

  lap() {
    if (this._state !== 'running') {
      throw new Error('cannot lap a stopwatch that is not running')
    } else {
      this._previousLaps.push(this.currentLap);
      this._currentLap = '00:00:00';
    }
  }

  reset() {
    if (this._state !== 'stopped') {
      throw new Error('cannot reset a stopwatch that is not stopped')
    } else {
      this._state = 'ready';
      this._currentLap = '00:00:00';
      this._previousLaps = [];
    }
  }

  advanceTime(duration) {
    let [a, b, c] = this._currentLap.split(':');
    let [A, B, C] = duration.split(':');
    
    if (this._state !== 'stopped') {
      let tFirstThingy = Number(a);
      let tSecondThingy = Number(b);
      let tThirdThingy = Number(c);

      let dFirstThingy = Number(A);
      let dSecondThingy = Number(B);
      let dThirdThingy = Number(C);

      let fFirstThingy = tFirstThingy + dFirstThingy;
      let fSecondThingy = tSecondThingy + dSecondThingy;
      let fThirdThingy = tThirdThingy + dThirdThingy;

      let array = [fFirstThingy, fSecondThingy, fThirdThingy];

      for (let i = 0; i < 3; i++) {
        if (array[i] < 10) {
          array[i] = '0' + String(array[i]);
        }
      }
      
    this._currentLap = array.join(':');
    }
  }
}