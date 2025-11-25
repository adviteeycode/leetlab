import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leetlab/model/problem.dart';

class ProblemRepository {
  final String baseUrl = "http://127.0.0.1:8080";

  Future<Problem> getProblem(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/problems/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("Fetched Problem: ${data['title']}");
        return Problem.fromJson(data);
      } else {
        throw Exception("Failed to fetch problem: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching problem: $e");
      rethrow;
    }
  }
}
