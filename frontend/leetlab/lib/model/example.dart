class Example {
  final String input;
  final String output;
  final String explanation;

  Example({required this.input, required this.output, this.explanation = ''});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      input: json['input'] ?? '',
      output: json['output'] ?? '',
      // backend field is 'explanation' (with “a”)
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'input': input,
    'output': output,
    'explanation': explanation,
  };
}
