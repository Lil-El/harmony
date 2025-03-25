type TimerType = "TIMEOUT" | "INTERVAL";

interface TimerData {
  name: TimerType
  ID: number
}

export default class Timer {
  timers: TimerData[] = [];

  createTimeout(callback: Function, delay: number = 0) {
    const timerID = setTimeout(callback, delay);
    const timerData: TimerData = {
      name: "TIMEOUT",
      ID: timerID
    }

    this.timers.push(timerData);
    return timerData;
  }

  createInterval(callback: Function, delay: number = 0) {
    const timerID = setTimeout(callback, delay);
    const timerData: TimerData = {
      name: "INTERVAL",
      ID: timerID
    }

    this.timers.push(timerData);
    return timerData;
  }

  clear(data: TimerData, index?: number) {
    if (data.name === "TIMEOUT") {
      clearTimeout(data.ID);
    } else {
      clearInterval(data.ID);
    }

    index = index || this.timers.indexOf(data);
    this.timers.splice(index, 1);
  }

  clearAll() {
    this.timers.reduceRight((_, data, index) => {
      this.clear(data, index);
      
      return data;
    })
  }
}