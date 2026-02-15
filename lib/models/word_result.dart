class WordResult {
  final String word;
  final String definition;

  WordResult({required this.word, required this.definition});

  factory WordResult.fromJson(Map<String, dynamic> json) {
    return WordResult(
      word: json['word'] ?? '',
      definition: json['definition'] ?? '',
    );
  }
}