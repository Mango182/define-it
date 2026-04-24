import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:define_it_v2/services/audio_service.dart';

class WordDetails extends StatelessWidget {
  final String word;
  final String definition;
  final String phonetic;
  final String audioUrl;

  WordDetails({
    super.key,
    required this.word,
    required this.definition,
    required this.phonetic,
    required this.audioUrl,
  });

  final AudioService _audioService = AudioService();

  Widget _wordText() {
    return Text(
      word,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _definitionText() {
    return Text(
      definition,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _phoneticRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          phonetic,
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement audio playback for pronunciation
            _audioService.playAudio(audioUrl);
          },
          icon: Icon(Icons.volume_up),
        )
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _wordText(),
            SizedBox(height: 8),
            _phoneticRow(),
            SizedBox(height: 16),
            _definitionText(),
          ],
        ),
      ),
    );
  }
}

@Preview(name: 'Word Details')
Widget wordDetailsPreview() {
  return WordDetails(
    word: "example",
    definition: "A thing characteristic of its kind or illustrating a general rule.",
    phonetic: "----",
    audioUrl: "https://example.com/audio.mp3",
  );
}