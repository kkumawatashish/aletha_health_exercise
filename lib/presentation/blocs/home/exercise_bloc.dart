import 'package:aletha_health_exercise/core/error/failure.dart';
import 'package:aletha_health_exercise/core/helpers/streak_tracker.dart';
import 'package:aletha_health_exercise/domain/usecases/get_exercises.dart';
import 'package:aletha_health_exercise/presentation/blocs/home/exercise_event.dart';
import 'package:aletha_health_exercise/presentation/blocs/home/exercise_state.dart';
import 'package:bloc/bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExercises getExercises;
  final List<String> _completedIds = [];
  final String instanceId = DateTime.now().millisecondsSinceEpoch.toString();

  ExerciseBloc(this.getExercises) : super(ExerciseInitial()) {
    on<LoadExercises>(_loadExerciseHandler);
    on<MarkExerciseCompleted>(_onMarkCompleted);
  }

  void _loadExerciseHandler(
    ExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(ExercisesLoading());
    try {
      final exercises = await getExercises();
      emit(ExercisesLoaded(exercises, completedIds: _completedIds));
    } on Failure catch (e) {
      emit(ExercisesError(e.message));
    } catch (e) {
      emit(ExercisesError('Failed to fetch exercises with $e'));
    }
  }

  void _onMarkCompleted(ExerciseEvent event,
      Emitter<ExerciseState> emit) async {
    if (event is MarkExerciseCompleted) {
      _completedIds.add(event.exerciseId);
      await StreakTracker.updateStreak();
    }
    if (state is ExercisesLoaded) {
      final loadedState = state as ExercisesLoaded;
      emit(ExercisesLoaded(loadedState.exercises, completedIds: List<String>.from(_completedIds)));
    }
  }
}
