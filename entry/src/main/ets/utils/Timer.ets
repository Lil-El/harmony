type TimerType = "TIMEOUT" | "INTERVAL";

export interface TimerData {
  name: TimerType
  ID: number
}

export default class Timer {
  private static _timers: TimerData[] = [];

  public static get timers(): TimerData[] {
    return Timer._timers;
  }

  static createTimeout(callback: Function, delay: number = 0) {
    const timerID = setTimeout(callback, delay);
    const timerData: TimerData = {
      name: "TIMEOUT",
      ID: timerID
    }

    Timer._timers.push(timerData);
    return timerData;
  }

  static createInterval(callback: Function, delay: number = 0) {
    const timerID = setInterval(callback, delay);
    const timerData: TimerData = {
      name: "INTERVAL",
      ID: timerID
    }

    Timer._timers.push(timerData);
    return timerData;
  }

  static clear(data: TimerData, index?: number) {
    index = index || Timer._timers.indexOf(data);

    if (index >= 0) {
      if (data.name === "TIMEOUT") {
        clearTimeout(data.ID);
      } else {
        clearInterval(data.ID);
      }

      Timer._timers.splice(index, 1);
    }
  }

  static clearAll() {
    Timer._timers.reduceRight((_, data, index) => {
      Timer.clear(data, index);

      return data;
    })
  }
}