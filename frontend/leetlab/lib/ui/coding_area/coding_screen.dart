import 'package:flutter/material.dart';
import 'package:leetlab/providers/problem_provider.dart';
import 'package:provider/provider.dart';
import 'package:leetlab/util/color.dart';
import 'package:leetlab/model/problem.dart';
import 'package:leetlab/ui/coding_area/code_editor.dart';
import 'package:leetlab/ui/coding_area/test_case_panel.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';
import 'package:leetlab/ui/widgets/theme_toggle_button.dart';

class CodingScreen extends StatefulWidget {
  final int problemId;

  const CodingScreen({super.key, required this.problemId});

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProblemProvider(widget.problemId),
      child: Consumer<ProblemProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.errorMessage != null) {
            return Scaffold(body: Center(child: Text(provider.errorMessage!)));
          }

          final problem = provider.problem;
          if (problem == null) {
            return const Scaffold(
              body: Center(child: Text("No problem found")),
            );
          }

          return _buildMainLayout(context, problem);
        },
      ),
    );
  }

  Widget _buildMainLayout(BuildContext context, Problem problem) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(problem.title),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [ThemeToggleButton(), SizedBox(width: 10)],
      ),
      body: size.width > 900
          ? Row(
              children: [
                Expanded(flex: 2, child: _buildProblemDescription(problem)),
                Expanded(flex: 3, child: _buildCodingPanel(problem)),
              ],
            )
          : _buildCodingPanel(problem),
    );
  }

  // ---------------- DESCRIPTION PANEL ----------------
  Widget _buildProblemDescription(Problem problem) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4, bottom: 8),
      child: Column(
        children: [
          GlassMorphism(
            borderWidth: 1,
            child: Row(
              children: [
                _buildTab('Description', 0),
                _buildTab('Solutions', 1),
                _buildTab('Submissions', 2),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildTabContent(problem)),
        ],
      ),
    );
  }

  int _selectedTab = 0;

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).highlightColor : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(Problem problem) {
    return GlassMorphism(
      blurSigma: 30,
      opacity: 0.15,
      borderRadius: 12,
      borderWidth: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _selectedTab == 0
            ? _buildDescriptionContent(problem)
            : _selectedTab == 1
            ? _buildSolutionsContent()
            : _buildSubmissionsContent(),
      ),
    );
  }

  // ---------------- DESCRIPTION CONTENT ----------------
  Widget _buildDescriptionContent(Problem problem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "#${problem.id} ${problem.title}",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(width: 8),
                      _buildDifficultyTag(problem.difficulty),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: problem.topics
                        .map(
                          (topic) => Text(
                            "#$topic",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${problem.likes}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),
        Text(
          problem.description,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),

        // Examples
        Text("Examples", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            problem.examples.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GlassMorphism(
                borderWidth: 1,
                child: _buildExample(
                  index: index + 1,
                  input: problem.examples[index].input,
                  output: problem.examples[index].output,
                  explanation: problem.examples[index].explanation,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Constraints
        Text('Constraints', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: problem.constraints
              .map((c) => _buildConstraint(c.text, c.isNumberConstraint))
              .toList(),
        ),

        const SizedBox(height: 24),

        // Hints
        if (problem.hints.isNotEmpty) ...[
          Text("Hints", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          ...List.generate(
            problem.hints.length,
            (index) => _buildHintCard(problem.hints[index].text, index + 1),
          ),
        ],
      ],
    );
  }

  // ---------------- CODE PANEL ----------------
  Widget _buildCodingPanel(Problem problem) {
    final String starterCode = problem.starterCodes.isNotEmpty
        ? problem.starterCodes.first.code
        : '';

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8, bottom: 8),
      child: Column(
        children: [
          Expanded(child: CodeEditor(code: starterCode)),
          const SizedBox(height: 8),
          TestCasePanel(testCases: problem.testcases),
        ],
      ),
    );
  }

  // ---------------- UI ELEMENTS ----------------
  Widget _buildDifficultyTag(String difficulty) {
    Color? color = getDifficultyColor(difficulty);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        difficulty,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildExample({
    required int index,
    required String input,
    required String output,
    String? explanation,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Example $index:',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Input: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: input),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Output: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: output),
              ],
            ),
          ),
          if (explanation != null && explanation.trim().isNotEmpty)
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Explanation: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: explanation),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConstraint(String text, bool isNumConstraint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 8),
          const SizedBox(width: 8),
          isNumConstraint
              ? GlassMorphism(
                  borderWidth: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                )
              : Text(text, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }

  Widget _buildHintCard(String hint, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GlassMorphism(
        borderWidth: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hint $index: ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(hint, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSolutionsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lightbulb_outline, size: 64),
          const SizedBox(height: 16),
          Text(
            'Solutions Coming Soon',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Solve the problem to unlock community solutions',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history, size: 64),
          const SizedBox(height: 16),
          Text(
            'No Submissions Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Your submission history will appear here',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
