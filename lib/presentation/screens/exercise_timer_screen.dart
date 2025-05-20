import 'dart:async';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_bloc.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_state.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/exercise.dart';
import '../blocs/home/exercise_bloc.dart';
import '../blocs/home/exercise_event.dart' show MarkExerciseCompleted;
import 'package:go_router/go_router.dart';
import '../../core/routeconfig.dart';

class ExerciseTimerScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseTimerScreen({super.key, required this.exercise});

  @override
  State<ExerciseTimerScreen> createState() => _ExerciseTimerScreenState();
}

class _ExerciseTimerScreenState extends State<ExerciseTimerScreen> {
  late final TimerBloc _timerBloc;
  late final ExerciseBloc _exerciseBloc;

  @override
  void initState() {
    super.initState();
    _timerBloc = TimerBloc()..add(StartTimer(widget.exercise.duration));
    _exerciseBloc = context.read<ExerciseBloc>();
  }

  @override
  void dispose() {
    _timerBloc.close();
    super.dispose();
  }

  void _onCompleted() {
    _exerciseBloc.add(MarkExerciseCompleted(widget.exercise.id));
    AppRoute.refreshHomeScreen();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Exercise Complete!"),
        content: const Text("Great job! You've finished your workout."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("Go Home"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _timerBloc,
      child: Scaffold(
        appBar: AppBar(title: Text("In Progress - ${widget.exercise.name}")),
        body: BlocConsumer<TimerBloc, TimerState>(
          listener: (context, state) {
            if (state is TimerCompleted) {
              _onCompleted();
            }
          },
          builder: (context, state) {
            if (state is TimerRunning) {
              return Center(
                child: Text(
                  '${state.secondsRemaining}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
