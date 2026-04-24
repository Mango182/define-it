class WordResult {
  final String word;
  final String definition;
  final String phonetic;
  final String audioUrl;

  WordResult({required this.word, required this.definition, required this.phonetic, required this.audioUrl});

  factory WordResult.fromJson(Map<String, dynamic> json) {
    final word = json['word'] ?? '';
    String definition = '';
    String phonetic = '';
    String audioUrl = '';

    // Extract definition if available
    if (json['meanings'] != null && json['meanings'].isNotEmpty) {
      definition = json['meanings'][0]['definitions'][0]['definition'] ?? '';
    }

    // Extract phonetic if available
    if (json['phonetics'] != null && json['phonetics'].isNotEmpty) {
      phonetic = json['phonetics'][0]['text'] ?? '';
      audioUrl = json['phonetics'][0]['audio'] ?? '';
    }

    return WordResult(
      word: word,
      definition: definition,
      phonetic: phonetic,
      audioUrl: audioUrl,
    );
  }
}
