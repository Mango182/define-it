class WordResult {
  final String word;
  final String definition;
  final String phonetic;
  final String audio_url;

  WordResult({required this.word, required this.definition, required this.phonetic, required this.audio_url});

  factory WordResult.fromJson(Map<String, dynamic> json) {
    final word = json['word'] ?? '';
    String definition = '';
    String phonetic = '';
    String audio_url = '';

    // Extract definition if available
    if (json['meanings'] != null && json['meanings'].isNotEmpty) {
      definition = json['meanings'][0]['definitions'][0]['definition'] ?? '';
    }

    // Extract phonetic if available
    if (json['phonetics'] != null && json['phonetics'].isNotEmpty) {
      phonetic = json['phonetics'][0]['text'] ?? '';
      audio_url = json['phonetics'][0]['audio'] ?? '';
    }

    return WordResult(
      word: word,
      definition: definition,
      phonetic: phonetic,
      audio_url: audio_url,
    );
  }
}
