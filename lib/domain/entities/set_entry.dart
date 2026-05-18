class SetEntry {
  const SetEntry({
    required this.id,
    required this.weightKg,
    required this.reps,
    this.completed = true,
  });

  final String id;
  final double weightKg;
  final int reps;
  final bool completed;
}
