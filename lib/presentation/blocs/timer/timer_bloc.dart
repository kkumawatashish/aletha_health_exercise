import 'dart:async' show Timer;

import 'package:aletha_health_exercise/presentation/blocs/timer/timer_event.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_state.dart';
import 'package:bloc/bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>(onStart);
    on<Tick>(onTick);
    on<CompleteTimer>(onComplete);
  }

  void onStart(StartTimer event, emit) {
    int seconds = event.durationInSeconds;
    emit(TimerRunning(seconds));
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds > 0) {
        add(Tick());
      } else {
        add(CompleteTimer());
      }
    });
  }

  void onTick(event, emit) {
    if (state is TimerRunning) {
      emit(TimerRunning((state as TimerRunning).secondsRemaining - 1));
    }
  }

  void onComplete(event, emit) {
    _timer?.cancel();
    emit(TimerCompleted());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

}
