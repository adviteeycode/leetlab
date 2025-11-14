import 'package:flutter/material.dart';
import 'package:leetlab/repositories/problem_list_repository.dart';
import 'package:leetlab/model/brief_problem_detail.dart';

class ProblemListProvider with ChangeNotifier {
  final _repository = ProblemListRepository();

  List<BriefProblemDetail> _allProblems = [];
  List<BriefProblemDetail> _visibleProblems = [];

  String _searchQuery = '';
  String _selectedDifficulty = 'All';
  bool _isLoading = false;
  String? _errorMessage;

  List<BriefProblemDetail> get problems => _visibleProblems;
  String get selectedDifficulty => _selectedDifficulty;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ProblemListProvider() {
    loadProblems();
  }

  /// 🔹 Fetch problems from backend
  Future<void> loadProblems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allProblems = await _repository.getAllProblems(); // now async
      _visibleProblems = List.from(_allProblems);
    } catch (e) {
      _errorMessage = "Failed to load problems: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔍 Search logic
  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// ⚙️ Difficulty filter
  void filterByDifficulty(String difficulty) {
    _selectedDifficulty = difficulty;
    _applyFilters();
  }

  /// 🎯 Topic filter
  void filterByTopic(String topic) {
    _searchQuery = topic.toLowerCase();
    _applyFilters();
  }

  /// 🧩 Combine search + filter logic
  void _applyFilters() {
    List<BriefProblemDetail> filtered = _allProblems.where((p) {
      bool matchesSearch = _searchQuery.isEmpty
          ? true
          : p.title.toLowerCase().contains(_searchQuery) ||
                p.topics.join(" ").toLowerCase().contains(_searchQuery) ||
                p.difficulty.toLowerCase().contains(_searchQuery);

      bool matchesDifficulty = _selectedDifficulty == 'All'
          ? true
          : p.difficulty.toLowerCase() == _selectedDifficulty.toLowerCase();

      return matchesSearch && matchesDifficulty;
    }).toList();

    _visibleProblems = filtered;
    notifyListeners();
  }
}
