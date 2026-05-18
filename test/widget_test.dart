import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:health_app/app.dart';

void main() {
  testWidgets('홈 화면이 렌더링된다', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: HealthApp()),
    );
    expect(find.text('Health App'), findsOneWidget);
    expect(find.text('운동 시작 (준비 중)'), findsOneWidget);
  });
}
