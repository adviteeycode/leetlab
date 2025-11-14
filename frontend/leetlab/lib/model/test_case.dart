class TestCase {
  final String input;
  final String expectedOutput;
  final bool isHidden;
  String? actualOutput;
  bool? passed;

  TestCase({
    required this.input,
    required this.expectedOutput,
    this.isHidden = false,
    this.actualOutput,
    this.passed,
  });

  factory TestCase.fromJson(Map<String, dynamic> json) {
    return TestCase(
      input: json['input'] ?? '',
      expectedOutput: json['expectedOutput'] ?? '',
      isHidden: json['hidden'] ?? false, // backend field = hidden
      actualOutput: json['actualOutput'],
      passed: json['passed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'input': input,
    'expectedOutput': expectedOutput,
    'hidden': isHidden,
    if (actualOutput != null) 'actualOutput': actualOutput,
    if (passed != null) 'passed': passed,
  };
}
