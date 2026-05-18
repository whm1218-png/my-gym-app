import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/workout_repository_impl.dart';
import '../../domain/repositories/workout_repository.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl();
});
