import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});

  /// Builds the header of the drawer with the app name and icon
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

  /// Navigates to the specified route if it's not the current route, and closes the drawer
  void _navigateTo(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    navigator.pop(); // close drawer
    if (currentRoute != route) {
      navigator.pushReplacementNamed(route); // replace current route with new route
    }
  }

  /// Builds a drawer item with the given title and icon, and sets up navigation path
  Widget _drawerItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // navigation functionality
        title == 'Home' ? _navigateTo(context, '/') : _navigateTo(context, '/${title.toLowerCase()}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),                                    // Drawer header with app name and icon
          _drawerItem(context, 'Home', Icons.home),           // Home route
          _drawerItem(context, 'Favorites', Icons.favorite),  // Favorites route
          _drawerItem(context, 'Settings', Icons.settings),   // Settings route
        ]
      )
    );
  }
}

// Preview for AppDrawer widget
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