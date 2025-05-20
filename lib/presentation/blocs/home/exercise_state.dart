
import 'package:equatable/equatable.dart';

import '../../../domain/entities/exercise.dart';

abstract class ExerciseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExerciseInitial extends ExerciseState {

}

class ExercisesLoading extends ExerciseState {

}

class ExercisesLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final List<String> completedIds;
  ExercisesLoaded(this.exercises, {this.completedIds = const []});

  @override
  List<Object?> get props => [exercises, completedIds];
}

class ExercisesError extends ExerciseState {
  final String message;
  ExercisesError(this.message);
}