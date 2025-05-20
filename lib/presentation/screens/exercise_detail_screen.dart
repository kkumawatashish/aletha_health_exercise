
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/exercise.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Description", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(exercise.description, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                Text("Duration: ${exercise.duration} seconds", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text("Difficulty: ${exercise.difficulty}", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.push('/exerciseTimer', extra: exercise);
                  },
                  child: const Text("Start Exercise", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}