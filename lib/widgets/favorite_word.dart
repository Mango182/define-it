import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widget_previews.dart';

class FavoriteWord extends StatefulWidget {
  final String word;
  const FavoriteWord({super.key, required this.word});

  @override
  State<FavoriteWord> createState() => _FavoriteWordState();
}

class _FavoriteWordState extends State<FavoriteWord> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: const Icon(Icons.bookmark),
      title: Text(widget.word),
      // subtitle: const Text('Tap to view definition'),
      onTap: () {
        Fluttertoast.showToast(
          msg: 'Viewing definition for "${widget.word}"',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            Fluttertoast.showToast(
              msg: '"${widget.word}" removed from bookmarks',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
            );
          });
        },
      ),
    );
  }
}

@Preview(name: "Bookmarked Word")
Widget bookmarkPreview() {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) {
          return const FavoriteWord(word: "Serendipity");
        },
      ),
    ),
  );
}