import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/homepage.dart';

void main() {
  testWidgets('BMI calculator calculates and displays BMI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BMICalculator(),
      ),
    );

    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('bmi: 19.03'), findsNothing);

    await tester.enterText(find.byType(TextField).at(0), '170');
    await tester.enterText(find.byType(TextField).at(1), '55');
    await tester.tap(find.text('Calculate'));
    await tester.pump();

    expect(find.text('bmi: 19.03'), findsOneWidget);
  });
}
