/// 운동 세션 엔티티 (`.planning/04-data-model.md`와 정합).
class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    this.note,
  });

  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? note;

  bool get isActive => endedAt == null;
}
