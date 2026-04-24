class WordResult {
  final String word;
  final String definition;
  final String phonetic;
  final String audioUrl;

  WordResult({required this.word, required this.definition, required this.phonetic, required this.audioUrl});

  /// Factory constructor to create a WordResult instance from a JSON response
  factory WordResult.fromJson(Map<String, dynamic> json) {
    // Extract the word, definition, phonetic, and audio URL from the JSON response
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

    // Return a new WordResult instance with the extracted data
    return WordResult(
      word: word,
      definition: definition,
      phonetic: phonetic,
      audioUrl: audioUrl,
    );
  }
}
