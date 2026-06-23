import 'package:flutter_test/flutter_test.dart';

import 'package:sample_app_4/main.dart';

void main() {
  testWidgets('shows categories and opens a detail page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Select Food Category'), findsOneWidget);
    expect(find.text('Italian'), findsOneWidget);
    expect(find.text('French'), findsOneWidget);

    await tester.tap(find.text('Italian'));
    await tester.pumpAndSettle();

    expect(find.text('Lasagna'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });
}
