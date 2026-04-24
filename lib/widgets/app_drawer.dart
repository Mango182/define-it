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

  void _navigateTo(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    navigator.pop(); // close drawer
    if (currentRoute != route) {
      navigator.pushNamed(route);
    }
  }

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
          _drawerHeader(),
          _drawerItem(context, 'Home', Icons.home),
          _drawerItem(context, 'Favorites', Icons.favorite), // No destination for now
          _drawerItem(context, 'Settings', Icons.settings),
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