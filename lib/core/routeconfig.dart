import 'package:aletha_health_exercise/domain/entities/exercise.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_bloc.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_event.dart';
import 'package:aletha_health_exercise/presentation/screens/exercise_detail_screen.dart';
import 'package:aletha_health_exercise/presentation/screens/exercise_timer_screen.dart';
import 'package:aletha_health_exercise/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart' show BuildContext, ValueKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static String _homeScreenKeyValue = 'home_screen_initial';
  
  static void refreshHomeScreen() {
    _homeScreenKeyValue = 'home_screen_${DateTime.now().millisecondsSinceEpoch}';
  }

  static final appRoute = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen(screenKey: ValueKey(_homeScreenKeyValue));
        },
      ),
      GoRoute(
        path: '/exerciseDetail',
        builder: (BuildContext context, GoRouterState state) {
          return ExerciseDetailScreen(exercise: state.extra as Exercise);
        },
      ),
      GoRoute(
        path: '/exerciseTimer',
        builder: (BuildContext context, GoRouterState state) {
          return ExerciseTimerScreen(exercise: state.extra as Exercise);
        },
      ),
    ],
  );
}
