import '../../domain/entities/workout_session.dart';
import '../../domain/repositories/workout_repository.dart';

/// drift/SQLite 연동 전 인메모리 스텁.
class WorkoutRepositoryImpl implements WorkoutRepository {
  final List<WorkoutSession> _sessions = [];

  @override
  Future<List<WorkoutSession>> listSessions() async =>
      List.unmodifiable(_sessions);

  @override
  Future<WorkoutSession?> getActiveSession() async {
    for (final s in _sessions) {
      if (s.isActive) return s;
    }
    return null;
  }

  @override
  Future<void> saveSession(WorkoutSession session) async {
    final i = _sessions.indexWhere((s) => s.id == session.id);
    if (i >= 0) {
      _sessions[i] = session;
    } else {
      _sessions.add(session);
    }
  }
}
