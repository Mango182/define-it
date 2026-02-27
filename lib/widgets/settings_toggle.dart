import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';




class SettingsToggle extends StatefulWidget {
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
  State<SettingsToggle> createState() => _SettingsToggleState();
}


class _SettingsToggleState extends State<SettingsToggle> {
  late bool _isSwitched;
  @override
  void initState() {
    super.initState();
    _isSwitched = widget.value;
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: Switch(
        value: _isSwitched,
        onChanged: (value) {
          setState(() {
            _isSwitched = value;
          });
          widget.onChanged(value);
        },
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
        onChanged: (value) {},
      ),
    ),
  );
}