import '../entities/workout_session.dart';

/// 데이터 레이어가 구현할 계약 (의존성 역전).
abstract interface class WorkoutRepository {
  Future<List<WorkoutSession>> listSessions();

  Future<WorkoutSession?> getActiveSession();

  Future<void> saveSession(WorkoutSession session);
}
