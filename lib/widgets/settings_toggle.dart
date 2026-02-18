import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';


class SettingsToggle extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggle({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

@Preview(name: "Settings Toggle")
Widget settingsTogglePreview() {
  return MaterialApp(
    home: Scaffold(
      body: SettingsToggle(
        title: "Dark Mode",
        value: true,
        onChanged: (value) {
          // Handle toggle change
        },
      ),
    ),
  );
}