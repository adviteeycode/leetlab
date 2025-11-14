class BriefProblemDetail {
  final int id;
  final String title;
  final String difficulty;
  final List<String> topics;
  final int likes;

  BriefProblemDetail(
    this.id,
    this.title,
    this.difficulty,
    this.topics,
    this.likes,
  );

  factory BriefProblemDetail.fromJson(Map<String, dynamic> json) {
    return BriefProblemDetail(
      json['id'],
      json['title'],
      json['difficulty'],
      List<String>.from(json['topics']),
      json['likes'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'difficulty': difficulty,
    'topics': topics,
    'likes': likes,
  };
}
