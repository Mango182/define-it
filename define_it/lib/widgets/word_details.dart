import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:define_it/services/toast_service.dart';

class WordDetails extends StatelessWidget {
  final String word;
  final String definition;
  final String phonetic;
  final String audioUrl;
  final Future<void> Function(String) onPlayAudio;

  const WordDetails({
    super.key,
    required this.word,
    required this.definition,
    required this.phonetic,
    required this.audioUrl,
    required this.onPlayAudio,
  });

/// Builds the word text widget
  Widget _wordText() {
    // Text for the Word (as a title)
    return Text(
      word,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  /// Builds the definition text widget
  Widget _definitionText() {
    // Text for the Definition
    return Text(
      definition,
      style: const TextStyle(fontSize: 16),
    );
  }

  /// Builds the phonetic text widget
  Widget _phoneticText() {
    // phonetic spelling of the word
    return Text(
      phonetic.isNotEmpty ? phonetic : 'Not available',
      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
    );
  }

  /// Builds the audio button which plays the pronunciation when pressed
  Widget _audioButton() {
    // Button to play the audio pronunciation
    return IconButton(
      onPressed: () async {
        // If no audio URL is available, show an error toast instead of trying to play
        if (audioUrl.isEmpty) {
          ToastService.showError('No audio available for "$word"');
          return;
        }

        // Show a toast indicating that the audio is playing
        ToastService.showToast('Playing pronunciation for "$word"');
        await onPlayAudio(audioUrl);
      },
      icon: const Icon(Icons.volume_up),
    );
  }

  /// Builds a row containing the phonetic text and the audio button
  Widget _phoneticRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _phoneticText(),
        const SizedBox(width: 8),
        _audioButton(),
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
            const SizedBox(height: 8),
            _phoneticRow(),
            const SizedBox(height: 16),
            _definitionText(),
          ],
        ),
      ),
    );
  }
}

// Preview for WordDetails widget
Future<void> _noopPlayAudio(String url) async {}

@Preview(name: 'Word Details')
Widget wordDetailsPreview() {
  return const WordDetails(
    word: "example",
    definition: "A thing characteristic of its kind or illustrating a general rule.",
    phonetic: "----",
    audioUrl: "",
    onPlayAudio: _noopPlayAudio,
  );
}
