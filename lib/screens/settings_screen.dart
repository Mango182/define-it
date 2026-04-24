import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:define_it_v2/widgets/settings_toggle.dart';
import 'package:flutter/material.dart';

// Providers
import 'package:define_it_v2/providers/theme_provider.dart';
import 'package:provider/provider.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Widget _themePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.palette),
              SizedBox(width: 16),
              Text('Appearance', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeModeOption>(
            expandedInsets: EdgeInsets.zero, // fills full width
            segments: const [
              ButtonSegment(
                value: ThemeModeOption.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment(
                value: ThemeModeOption.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode),
              ),
              ButtonSegment(
                value: ThemeModeOption.system,
                label: Text('System'),
                icon: Icon(Icons.phone_android),
              ),
            ],
            selected: {context.watch<ThemeProvider>().themeMode},
            onSelectionChanged: (value) {
              context.read<ThemeProvider>().setTheme(value.first);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
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
                  _themePicker(),
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