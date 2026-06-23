import 'package:flutter_test/flutter_test.dart';
import 'package:sample_app_3/main.dart';

void main() {
  testWidgets('shows contact list screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('List View Sample'), findsOneWidget);
    expect(find.text('James'), findsOneWidget);
    expect(find.text('Mary'), findsOneWidget);
  });
}
