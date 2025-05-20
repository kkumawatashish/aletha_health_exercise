import 'package:aletha_health_exercise/core/routeconfig.dart';
import 'package:aletha_health_exercise/core/utils/app_theme.dart';
import 'package:aletha_health_exercise/presentation/blocs/home/exercise_bloc.dart';
import 'package:aletha_health_exercise/presentation/blocs/home/exercise_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/get_dependencies.dart';
import 'domain/usecases/get_exercises.dart';

void main() {
  GetDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ExerciseBloc(GetIt.instance.get<GetExercises>())
                ..add(LoadExercises()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Aletha Health Exercise',
        theme: AppTheme.lightTheme,
        routerConfig: AppRoute.appRoute,
      ),
    );
  }
}
