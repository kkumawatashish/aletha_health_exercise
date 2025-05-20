

import 'package:aletha_health_exercise/core/dio_client.dart';
import 'package:aletha_health_exercise/data/repositories/exercise_repository_impl.dart';
import 'package:aletha_health_exercise/domain/usecases/get_exercises.dart';
import 'package:aletha_health_exercise/presentation/blocs/timer/timer_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/repositories/exercise_repository.dart';

class GetDependencies {
  final getIt = GetIt.instance;

  GetDependencies() {
    getIt.registerSingleton<Dio>(DioClient().instance);
    getIt.registerFactory<ExerciseRepository>(() => ExerciseRepositoryImpl(getIt.get<Dio>()));
    getIt.registerFactory(() => GetExercises(getIt.get<ExerciseRepository>()));
  }
}