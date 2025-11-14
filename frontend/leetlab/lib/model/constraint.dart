class Constraint {
  final String text;
  final bool isNumberConstraint;

  Constraint({required this.text, required this.isNumberConstraint});

  factory Constraint.fromJson(Map<String, dynamic> json) {
    return Constraint(
      text: json['text'] ?? '',
      // your backend field is 'valueConstraint'
      isNumberConstraint: json['valueConstraint'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'valueConstraint': isNumberConstraint,
  };
}
