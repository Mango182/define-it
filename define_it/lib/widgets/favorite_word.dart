import 'package:flutter/material.dart';
import 'package:define_it_v2/services/toast_service.dart';
import 'package:flutter/widget_previews.dart';

class FavoriteWord extends StatefulWidget {
  final String word;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const FavoriteWord({
    super.key,
    required this.word,
    this.onDelete,
    this.onTap,
  });

  @override
  State<FavoriteWord> createState() => _FavoriteWordState();
}

class _FavoriteWordState extends State<FavoriteWord> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: const Icon(Icons.bookmark),
      title: Text(widget.word),
      // subtitle: const Text('Tap to view definition'),
      onTap: () {
        widget.onTap?.call();
        ToastService.showToast('Viewing details for "${widget.word}"');
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          widget.onDelete?.call();
          ToastService.showToast('Removed "${widget.word}" from favorites');
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