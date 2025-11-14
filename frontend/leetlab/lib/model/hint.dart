class Hint {
  final String text;

  Hint({required this.text});

  factory Hint.fromJson(Map<String, dynamic> json) {
    return Hint(text: json['text'] ?? '');
  }

  Map<String, dynamic> toJson() => {'text': text};
}
