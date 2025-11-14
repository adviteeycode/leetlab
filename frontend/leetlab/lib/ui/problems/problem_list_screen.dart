import 'package:flutter/material.dart';
import 'package:leetlab/util/app_theme.dart';
import 'package:leetlab/util/color.dart';
import 'package:leetlab/model/brief_problem_detail.dart';
import 'package:leetlab/providers/problem_list_provider.dart';
import 'package:leetlab/ui/coding_area/coding_screen.dart';
import 'package:leetlab/ui/widgets/custom_search_bar.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';
import 'package:leetlab/ui/problems/problem_card.dart';
import 'package:leetlab/ui/widgets/theme_toggle_button.dart';
import 'package:provider/provider.dart';

class ProblemListScreen extends StatefulWidget {
  const ProblemListScreen({super.key});

  @override
  State<ProblemListScreen> createState() => _ProblemListScreenState();
}

class _ProblemListScreenState extends State<ProblemListScreen> {
  String currentSearch = "All";

  @override
  Widget build(BuildContext context) {
    ProblemListProvider provider = Provider.of<ProblemListProvider>(context);
    List<BriefProblemDetail> problems = provider.problems;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('LeetLab', style: theme.textTheme.displayLarge),
        centerTitle: true,
        actions: [ThemeToggleButton(), SizedBox(width: 10)],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: getResponsivePadding(context),
          right: getResponsivePadding(context),
          top: 16,
        ),
        child: Column(
          children: [
            CustomSearchBar(
              hintText: "Search problems...",
              onChanged: (value) {
                currentSearch = value;
                provider.search(currentSearch);
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: ['All', 'Easy', 'Medium', 'Hard'].map((
                        difficulty,
                      ) {
                        final isSelected = currentSearch == difficulty;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onHover: (value) {
                              setState(() {
                                if (value) {
                                  currentSearch = difficulty;
                                } else {
                                  difficulty = currentSearch;
                                }
                              });
                            },

                            onTap: () {
                              setState(() {
                                currentSearch = difficulty;
                                provider.filterByDifficulty(currentSearch);
                              });
                            },
                            child: GlassMorphism(
                              borderRadius: isSelected ? 20 : 20,
                              borderWidth: isSelected ? 1.75 : 1,
                              borderColor: (isSelected)
                                  ? getDifficultyColor(difficulty)
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                child: Text(
                                  difficulty,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: isSelected
                                        ? getDifficultyColor(difficulty)
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Expanded(
              child: problems.isEmpty
                  ? Center(
                      child: Text(
                        'No problems found',
                        style: theme.textTheme.headlineLarge,
                      ),
                    )
                  : ListView.separated(
                      itemCount: problems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final p = problems[i];
                        return buildProblemCard(p, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CodingScreen(problemId: p.id),
                            ),
                          );
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
