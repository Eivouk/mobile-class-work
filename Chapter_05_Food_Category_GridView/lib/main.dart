import 'package:flutter/material.dart';
import 'package:sample_app_4/screens/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Food Menu App',
      home: MenuPage(),
    );
  }
}
