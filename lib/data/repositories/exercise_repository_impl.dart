import 'package:aletha_health_exercise/core/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:aletha_health_exercise/domain/entities/exercise.dart';
import 'package:aletha_health_exercise/domain/repositories/exercise_repository.dart';

import '../models/exercise_model.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final Dio dio;

  ExerciseRepositoryImpl(this.dio);

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      final response = await dio.get('/workouts');
      if (response.statusCode == 200) {
        final data = response.data as List;
        final exercises =
            data.map((json) => ExerciseModel.fromJson(json)).toList();
        return exercises;
      } else {
        return [];
      }
    } catch (e, s) {
      throw Failure('Failed to load exercises with $e');
    }
  }
}
