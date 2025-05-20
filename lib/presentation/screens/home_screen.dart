import 'package:aletha_health_exercise/presentation/blocs/home/exercise_bloc.dart';
import 'package:aletha_health_exercise/presentation/blocs/home/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/helpers/streak_tracker.dart';

class HomeScreen extends StatelessWidget {
  //final Key? screenKey;
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Builder(
        builder: (context) {
          return BlocConsumer<ExerciseBloc, ExerciseState>(
              listener: (BuildContext context, ExerciseState state) {
                if (state is ExercisesError) {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is ExercisesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ExercisesLoaded) {
                  return Column(
                    children: [
                      _buildStreakTracker(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = state.exercises[index];
                            final isCompleted = state.completedIds.contains(exercise.id);
                            return ListTile(
                              title: Text(exercise.name),
                              subtitle: Text('Duration: ${exercise.duration} sec'),
                              trailing: Icon(
                                isCompleted ? Icons.check_circle : Icons.arrow_forward_ios,
                                color: isCompleted ? Colors.green : Colors.grey,
                              ),
                              onTap: () {
                                context.push('/exerciseDetail', extra: state.exercises[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
          );
        }
      ),
    );
  }
}

Widget _buildStreakTracker() {
  return FutureBuilder<int>(
    future: StreakTracker.getStreak(),
    builder: (context, snapshot) {
      final streak = snapshot.data ?? 0;
      return Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange),
            const SizedBox(width: 12),
            Text(
              '$streak-day streak!',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    },
  );
}