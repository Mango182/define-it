class WordResult {
  final String word;
  final String definition;
  final String phonetic;

  WordResult({required this.word, required this.definition, required this.phonetic});

  factory WordResult.fromJson(Map<String, dynamic> json) {
    final word = json['word'] ?? '';
    String definition = '';
    String phonetic = '';

    // Extract definition if available
    if (json['meanings'] != null && json['meanings'].isNotEmpty) {
      definition = json['meanings'][0]['definitions'][0]['definition'] ?? '';
    }

    // Extract phonetic if available
    if (json['phonetics'] != null && json['phonetics'].isNotEmpty) {
      phonetic = json['phonetics'][0]['text'] ?? '';
    }

    return WordResult(
      word: word,
      definition: definition,
      phonetic: phonetic,
    );
  }
}
