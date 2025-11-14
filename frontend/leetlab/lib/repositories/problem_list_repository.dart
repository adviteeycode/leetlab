import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leetlab/model/brief_problem_detail.dart';
import 'package:leetlab/model/problem.dart';

class ProblemListRepository {
  final String baseUrl = "http://localhost:8080";

  Future<List<BriefProblemDetail>> getAllProblems() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/problems"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        print(response.body);
        return jsonList.map((data) {
          return BriefProblemDetail.fromJson(data);
        }).toList();
      } else {
        throw Exception("Failed to fetch problems: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching problems: $e");
      rethrow;
    }
  }

  Future<Problem> getProblem(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/problems/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final problem = Problem.fromJson(data);
        print("Fetched problem: ${problem.title}");
        return problem;
      } else {
        throw Exception("Failed to fetch problem: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching problem: $e");
      rethrow;
    }
  }
}
