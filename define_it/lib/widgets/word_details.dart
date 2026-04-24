import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class WordDetails extends StatelessWidget {
  final String word;
  final String definition;
  final String phonetic;

  const WordDetails({
    super.key,
    required this.word,
    required this.definition,
    required this.phonetic,
  });

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
          onPressed: () {},
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
  );
}