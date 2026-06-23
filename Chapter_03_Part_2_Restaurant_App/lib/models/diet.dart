import 'package:flutter/material.dart';

class DietModel {
  final String name;
  final String iconPath;
  final String level;
  final String duration;
  final String calorie;
  final Color boxColor;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
  });

  static List<DietModel> getDiets() {
    List<DietModel> diets = [];

    diets.add(
      DietModel(
        name: "Honey Pancake",
        iconPath: "assets/images/honey-pancake.jpg",
        level: "Easy",
        duration: "30mins",
        calorie: "180kcal",
        boxColor: const Color(0xff92A3FD),
      ),
    );

    diets.add(
      DietModel(
        name: "Canai Bread",
        iconPath: "assets/images/canai-bread.jpg",
        level: "Medium",
        duration: "45mins",
        calorie: "230kcal",
        boxColor: const Color(0xffC58BF2),
      ),
    );

    return diets;
  }
}
