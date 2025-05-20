

abstract class TimerState {}

class TimerInitial extends TimerState {
}

class TimerRunning extends TimerState {
  final int secondsRemaining;
  TimerRunning(this.secondsRemaining);
}

class TimerCompleted extends TimerState {}