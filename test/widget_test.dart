import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dashboard_mahasiswa/main.dart';

void main() {
  testWidgets('Menampilkan header dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Selamat Datang 👋'), findsOneWidget);
  });
}
