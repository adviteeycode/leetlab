class StarterCode {
  final int languageCode;
  final String language;
  final String code;
  final String method;

  StarterCode({
    required this.languageCode,
    required this.language,
    required this.code,
    required this.method,
  });

  factory StarterCode.fromJson(Map<String, dynamic> json) {
    return StarterCode(
      languageCode: json['languageId'] ?? 0, // matches Java StarterCodeDto
      language: json['language'] ?? '',
      code: json['code'] ?? '',
      method: json['method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'languageId': languageCode,
    'language': language,
    'code': code,
    'method': method,
  };
}
