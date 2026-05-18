/// ADR-0003: Epley 기반 예상 1RM.
abstract final class EpleyCalculator {
  static double estimatedOneRm({
    required double weightKg,
    required int reps,
  }) {
    if (weightKg <= 0 || reps <= 0) return 0;
    return weightKg * (1 + reps / 30);
  }

  /// 세션 내 여러 세트 중 대표 e1RM = 최댓값.
  static double sessionBestE1rm(Iterable<({double weightKg, int reps})> sets) {
    return sets
        .map((s) => estimatedOneRm(weightKg: s.weightKg, reps: s.reps))
        .fold<double>(0, (a, b) => a > b ? a : b);
  }
}
