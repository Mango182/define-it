import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:define_it_v2/widgets/search_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Favorite Word
  void _favoriteWord() {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to favorites!')),
    );
  }

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
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const WordSearchbar(),
            ),

            // Word of the day
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Word of the Day',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Serendipity',
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'The occurrence and development of events by chance in a happy or beneficial way.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),

      // Favorite Button
      floatingActionButton: FloatingActionButton(
        onPressed: _favoriteWord,
        tooltip: 'Favorite',
        child: const Icon(Icons.favorite),
      ),
    );
  }
}