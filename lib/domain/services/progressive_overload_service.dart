enum OverloadStatus { progress, maintain, regress, unknown }

/// 직전 세션 대비 중량·반복 비교 (`.planning/04-data-model.md`).
abstract final class ProgressiveOverloadService {
  static OverloadStatus compare({
    required double currentWeightKg,
    required int currentReps,
    required double? previousWeightKg,
    required int? previousReps,
  }) {
    if (previousWeightKg == null || previousReps == null) {
      return OverloadStatus.unknown;
    }
    if (currentWeightKg > previousWeightKg) return OverloadStatus.progress;
    if (currentWeightKg == previousWeightKg && currentReps > previousReps) {
      return OverloadStatus.progress;
    }
    if (currentWeightKg == previousWeightKg && currentReps == previousReps) {
      return OverloadStatus.maintain;
    }
    return OverloadStatus.regress;
  }
}
