import 'package:flutter/material.dart';
import 'package:leetlab/util/color.dart';
import 'package:leetlab/model/brief_problem_detail.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';

Widget buildProblemCard(BriefProblemDetail problem, VoidCallback onTap) {
  return GlassMorphism(
    borderWidth: 1,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            ProblemIdBadge(id: problem.id),
            const SizedBox(width: 10),
            ProblemInfo(title: problem.title, topics: problem.topics),
            const SizedBox(width: 8),
            ProblemLikes(likes: problem.likes),
            const SizedBox(width: 8),
            DifficultyBadge(difficulty: problem.difficulty),
            const SizedBox(width: 8),
            SolvedIcon(solved: true),
          ],
        ),
      ),
    ),
  );
}

class ProblemIdBadge extends StatelessWidget {
  final int id;
  const ProblemIdBadge({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      borderWidth: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text('#$id', style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class ProblemInfo extends StatelessWidget {
  final String title;
  final List<String> topics;
  const ProblemInfo({super.key, required this.title, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelLarge,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: topics.map((topic) {
              return Text(
                "#$topic",
                style: Theme.of(context).textTheme.labelMedium,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ProblemLikes extends StatelessWidget {
  final int likes;
  const ProblemLikes({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, size: 18),
        const SizedBox(width: 3),
        Text('$likes'),
      ],
    );
  }
}

class DifficultyBadge extends StatelessWidget {
  final String difficulty;
  const DifficultyBadge({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      borderRadius: 10,
      borderWidth: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          difficulty,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: getDifficultyColor(difficulty),
          ),
        ),
      ),
    );
  }
}

class SolvedIcon extends StatelessWidget {
  final bool solved;
  const SolvedIcon({super.key, required this.solved});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.done_all,
      color: solved ? Theme.of(context).colorScheme.primary : null,
    );
  }
}
