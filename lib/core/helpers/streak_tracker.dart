import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StreakTracker {
  static const String _lastWorkoutDateKey = 'last_workout_date';
  static const String _streakKey = 'current_streak';

  static Future<int> updateStreak() async {
    final storage = FlutterSecureStorage();
    var lastDateStr = await storage.read(key: _lastWorkoutDateKey);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? lastDate =
        lastDateStr != null ? DateTime.tryParse(lastDateStr) : null;

    var currentStreakStr = await storage.read(key: _streakKey) ?? '0';
    var currentStreak = int.tryParse(currentStreakStr) ?? 0;

    if (lastDate == null ||
        lastDate.isBefore(today.subtract(const Duration(days: 1)))) {
      // first time or missed a day
      currentStreak = 1;
    } else if (lastDate.isAtSameMomentAs(
      today.subtract(const Duration(days: 1)),
    )) {
      // increase streak
      currentStreak++;
    } else if (lastDate.isAtSameMomentAs(today)) {
      // do nothing
      return currentStreak;
    }

    await storage.write(
      key: _lastWorkoutDateKey,
      value: today.toIso8601String(),
    );
    await storage.write(key: _streakKey, value: currentStreak.toString());

    return currentStreak;
  }

  static Future<int> getStreak() async {
    final storage = FlutterSecureStorage();
    final currentStreak = await storage.read(key: _streakKey) ?? '0';
    return int.tryParse(currentStreak) ?? 0;
  }
}
