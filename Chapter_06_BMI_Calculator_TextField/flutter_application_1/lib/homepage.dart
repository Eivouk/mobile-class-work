import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  double bmi = 0.0;

  bool showBmi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ), // AppBar
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Height in CM",
              ), // InputDecoration
            ), // TextField
            const SizedBox(
              height: 20,
            ), // SizedBox
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Weight in KG",
              ), // InputDecoration
            ), // TextField
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double height = double.parse(heightController.text);
                  double weight = double.parse(weightController.text);
                  bmi = (weight / (height * height)) * 10000;
                  showBmi = true;
                });
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 30,
                ), // TextStyle
              ), // Text
            ), // ElevatedButton
            const SizedBox(height: 20),
            showBmi
                ? Text(
                    "bmi: ${bmi.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 30,
                    ), // TextStyle
                  )
                : const SizedBox(), // Text
          ],
        ), // Column
      ), // Container
    ); // Scaffold
  }
}
