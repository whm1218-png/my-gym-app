import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/view_models/home_view_model.dart';
import '../theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health App'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오직 성장에만 집중',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF94A3B8),
                  ),
            ),
            const SizedBox(height: 32),
            Text('예시 e1RM (Epley)', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(
              '${state.sampleE1rm.toStringAsFixed(1)} kg',
              style: AppTheme.statNumber(context),
            ),
            const SizedBox(height: 8),
            Text(
              '80kg × 5회 기준 추정값',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {},
                child: const Text('운동 시작 (준비 중)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
