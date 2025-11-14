import 'package:flutter/material.dart';
import 'package:leetlab/model/test_case.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';

class TestCasePanel extends StatefulWidget {
  final List<TestCase> testCases;

  const TestCasePanel({super.key, required this.testCases});

  @override
  State<TestCasePanel> createState() => _TestCasePanelState();
}

class _TestCasePanelState extends State<TestCasePanel> {
  int selectedTestCase = 0;
  late bool hideTestCases;

  @override
  void initState() {
    super.initState();
    hideTestCases = false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GlassMorphism(
      borderRadius: 12,
      borderWidth: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Testcases: ',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildTestCaseTabs(context)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      hideTestCases = !hideTestCases;
                    });
                  },
                  child: GlassMorphism(
                    borderRadius: 8,
                    child: Icon(
                      (hideTestCases)
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            if (!hideTestCases)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _buildTestCaseContent(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCaseTabs(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.testCases.where((t) => !t.isHidden).length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final testCase = widget.testCases
              .where((t) => !t.isHidden)
              .toList()[index];
          final isSelected = selectedTestCase == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTestCase = index;
              });
            },
            child: GlassMorphism(
              borderWidth: isSelected ? 2.5 : 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'Case ${index + 1}',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                    ),
                    if (testCase.passed != null) ...[
                      const SizedBox(width: 6),
                      Icon(
                        testCase.passed! ? Icons.check_circle : Icons.cancel,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTestCaseContent() {
    final visibleTestCases = widget.testCases
        .where((t) => !t.isHidden)
        .toList();
    if (visibleTestCases.isEmpty) {
      return Center(child: Text('No test cases available'));
    }

    final testCase = visibleTestCases[selectedTestCase];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Input: ', testCase.input, context),
          const SizedBox(height: 12),
          _buildSection('Expected Output: ', testCase.expectedOutput, context),
          if (testCase.actualOutput != null) ...[
            const SizedBox(height: 12),
            _buildSection('Your Output: ', testCase.actualOutput!, context),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    //  {Color? color}
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(width: 8),
        Expanded(
          child: GlassMorphism(
            borderWidth: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [Text(content, textAlign: TextAlign.start)]),
            ),
          ),
        ),
      ],
    );
  }
}
