import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:define_it_v2/services/toast_service.dart';

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

  Widget _wordText() {
    return Text(
      word,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _definitionText() {
    return Text(
      definition,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _phoneticText() {
    return Text(
      phonetic,
      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
    );
  }

  Widget _audioButton() {
    return IconButton(
      onPressed: () async {
        if (audioUrl.isEmpty) {
          ToastService.showError('No audio available for "$word"');
          return;
        }

        ToastService.showToast('Playing pronunciation for "$word"');
        await onPlayAudio(audioUrl);
      },
      icon: const Icon(Icons.volume_up),
    );
  }

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

Future<void> _noopPlayAudio(String url) async {}
