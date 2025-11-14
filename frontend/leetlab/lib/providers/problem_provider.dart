import 'package:flutter/material.dart';
import 'package:leetlab/repositories/problem_repository.dart';
import 'package:leetlab/model/problem.dart';

class ProblemProvider extends ChangeNotifier {
  final _repository = ProblemRepository();

  Problem? _problem;
  bool _isLoading = false;
  String? _errorMessage;

  Problem? get problem => _problem;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ProblemProvider(int id) {
    loadProblem(id);
  }

  Future<void> loadProblem(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedProblem = await _repository.getProblem(id);
      _problem = fetchedProblem;
    } catch (e) {
      _errorMessage = "Failed to load problem: $e";
      _problem = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
