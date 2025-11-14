import 'package:flutter/material.dart';
import '../ui/problems/problem_list_screen.dart';
import '../ui/home/home_screen.dart';

class AppRoutes {
  static const home = '/';
  static const problems = '/problems';
  static const coding = '/coding';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => const HomeScreen(),
    problems: (_) => const ProblemListScreen(),
  };
}
