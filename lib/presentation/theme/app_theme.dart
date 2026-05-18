import 'package:flutter/material.dart';

/// 헬스장 시인성을 위한 다크 모드 기본 테마 (`.planning/00-vision.md`).
abstract final class AppTheme {
  static const _seed = Color(0xFF22C55E);

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.dark,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      textTheme: base.textTheme.apply(
        bodyColor: const Color(0xFFE2E8F0),
        displayColor: Colors.white,
      ),
    );
  }

  static TextStyle statNumber(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        );
  }
}
