import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:define_it_v2/widgets/settings_toggle.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            // Settings Toggles
            Expanded(
              child: ListView(
                children: [
                  SettingsToggle(title: 'Dark Mode', value: false, onChanged: (value) {
                    final messanger = ScaffoldMessenger.of(context);
                    if (value) {
                      messanger.showSnackBar(
                        const SnackBar(content: Text('Dark mode enabled!')),
                      );
                    } else {
                      messanger.showSnackBar(
                        const SnackBar(content: Text('Dark mode disabled!')),
                      );
                    }                    
                  }),
                  SettingsToggle(title: 'Notifications', value: false, onChanged: (value) { }),
                  TextButton(
                    onPressed: () {
                    // Handle reset settings logic
                    }, 
                    child: const Text('Reset Settings',
                      style: TextStyle(color: Colors.red)
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}