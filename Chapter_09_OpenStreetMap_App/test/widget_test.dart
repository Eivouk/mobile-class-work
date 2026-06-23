import 'package:chapter_9_map_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Chapter 9 map app loads the OpenStreetMap page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Open Street Map in Flutter'), findsOneWidget);
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byType(TileLayer), findsOneWidget);
    expect(find.byType(MarkerLayer), findsOneWidget);
    expect(find.byIcon(Icons.location_pin), findsNWidgets(3));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
}
