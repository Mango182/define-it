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
                  ListTile(
                    title: Text('Dark Mode'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {
                        // Handle dark mode toggle
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Notifications'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // Handle notifications toggle
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}