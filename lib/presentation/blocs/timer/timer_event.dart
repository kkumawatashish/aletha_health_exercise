

abstract class TimerEvent {
}

class StartTimer extends TimerEvent {
  final int durationInSeconds;

  StartTimer(this.durationInSeconds);
}

class Tick extends TimerEvent {
}

class CompleteTimer extends TimerEvent {}