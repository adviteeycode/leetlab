import 'package:flutter/material.dart';

final Color colorForEasy = const Color(0xFF00C853);
final Color colorForMedium = Colors.orangeAccent;
final Color colorForHard = Colors.redAccent;

Color? getDifficultyColor(String difficulty) {
  difficulty = difficulty.toUpperCase();
  switch (difficulty) {
    case 'HARD':
      return colorForHard;
    case 'MEDIUM':
      return colorForMedium;
    case 'EASY':
      return colorForEasy;
  }
  return null;
}
