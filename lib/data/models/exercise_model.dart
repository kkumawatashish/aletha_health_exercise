import 'package:aletha_health_exercise/domain/entities/exercise.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.duration,
    required super.difficulty,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      difficulty: json['difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'duration' : duration,
      'difficulty' : difficulty
    };
  }
}
