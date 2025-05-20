

import 'package:aletha_health_exercise/domain/entities/exercise.dart';
import 'package:aletha_health_exercise/domain/repositories/exercise_repository.dart';

class GetExercises {
  final ExerciseRepository repository;

  GetExercises(this.repository);

  Future<List<Exercise>> call() async {
    return repository.getExercises();
  }
}