import 'package:leetlab/model/constraint.dart';
import 'package:leetlab/model/example.dart';
import 'package:leetlab/model/hint.dart';
import 'package:leetlab/model/starter_code.dart';
import 'package:leetlab/model/test_case.dart';

class Problem {
  final int id;
  final String title;
  final String description;
  final String difficulty;
  final List<String> topics;
  final List<StarterCode> starterCodes;
  final List<Example> examples;
  final List<Constraint> constraints;
  final List<Hint> hints;
  final List<TestCase> testcases;
  final int likes;

  Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.topics,
    required this.starterCodes,
    required this.examples,
    required this.constraints,
    required this.hints,
    required this.testcases,
    required this.likes,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      topics:
          (json['topics'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      starterCodes:
          (json['starterCodes'] as List<dynamic>?)
              ?.map((e) => StarterCode.fromJson(e))
              .toList() ??
          [],
      examples:
          (json['examples'] as List<dynamic>?)
              ?.map((e) => Example.fromJson(e))
              .toList() ??
          [],
      constraints:
          (json['constraints'] as List<dynamic>?)
              ?.map((e) => Constraint.fromJson(e))
              .toList() ??
          [],
      hints:
          (json['hints'] as List<dynamic>?)
              ?.map((e) => Hint.fromJson(e))
              .toList() ??
          [],
      testcases:
          (json['testcases'] as List<dynamic>?)
              ?.map((e) => TestCase.fromJson(e))
              .toList() ??
          [],
      likes: json['likes'] ?? 0,
    );
  }
}
