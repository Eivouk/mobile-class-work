import 'package:flutter_test/flutter_test.dart';

import 'package:sample_app_2_restaurant/main.dart';

void main() {
  testWidgets('restaurant home screen shows lecture content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Food Menu'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Salad'), findsOneWidget);
    expect(find.text('Recommendation for Diet'), findsOneWidget);
    expect(find.text('Honey Pancake'), findsOneWidget);
    expect(find.text('View'), findsWidgets);
  });
}
