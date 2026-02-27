import 'package:define_it_v2/widgets/favorite_word.dart';
import 'package:flutter/material.dart';
import 'package:define_it_v2/widgets/app_drawer.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key, required this.title});
  final String title;

  @override
  State<BookmarkPage> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Bookmark Items
            Expanded(
              child: ListView(
                children: [
                  FavoriteWord(word: "Serendipity"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}