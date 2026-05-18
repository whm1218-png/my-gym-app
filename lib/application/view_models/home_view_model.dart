import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/epley_calculator.dart';

class HomeViewState {
  const HomeViewState({
    required this.subtitle,
    required this.sampleE1rm,
  });

  final String subtitle;
  final double sampleE1rm;
}

class HomeViewModel extends Notifier<HomeViewState> {
  @override
  HomeViewState build() {
    const sampleWeight = 80.0;
    const sampleReps = 5;
    return HomeViewState(
      subtitle: '점진적 과부하 · 로컬 기록 · 다크 모드',
      sampleE1rm: EpleyCalculator.estimatedOneRm(
        weightKg: sampleWeight,
        reps: sampleReps,
      ),
    );
  }
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeViewState>(HomeViewModel.new);
