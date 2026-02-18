import 'package:define_it_v2/screens/bookmark_screen.dart';
import 'package:define_it_v2/screens/home_screen.dart';
import 'package:define_it_v2/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});

  Widget _drawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: 
      Column(
        children: [
          Text(
            'Define It',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            )
          ),
          Icon(
            Icons.book,
            color: Colors.white,
            size: 48,
          ),
      ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, IconData icon, Widget? destination) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        final navigator = Navigator.of(context);
        // Close the drawer
        navigator.pop();

        // navigation functionality
        if (destination != null) {
          navigator.push(
            MaterialPageRoute(builder: (context) => destination)
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(context, 'Home', Icons.home, HomePage(title: "home")),
          _drawerItem(context, 'Favorites', Icons.favorite, BookmarkPage(title: "Favorites")), // No destination for now
          _drawerItem(context, 'Settings', Icons.settings, SettingsPage(title: "Settings")),
        ]
      )
    );
  }
}

@Preview(name: 'App Drawer')
Widget appDrawerPreview() {
  return MaterialApp(
    home: Scaffold(
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scaffold.of(context).openDrawer();
          });
          return const Center(child: Text("Drawer Preview Mode"));
        },
      ),
    ),
  );
}