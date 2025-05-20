

import 'package:aletha_health_exercise/domain/entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises();
}