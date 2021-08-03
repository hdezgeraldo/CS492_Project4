import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';

class DarkThemeSwitch extends StatefulWidget {

  DarkThemeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkThemeSwitch> createState() => _DarkThemeSwitchState();
}

class _DarkThemeSwitchState extends State<DarkThemeSwitch> {
  late bool isDark;

  void initState() {
    super.initState();
    isDark = false;
    _boolLightValue();
  }

  _boolLightValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('lightValue') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppState? appState = context.findAncestorStateOfType<AppState>();

    return SwitchListTile(
      title: Text('Dark Mode'),
      value: isDark,
      onChanged: (value) {
        setState(() {
          isDark = value;
          appState!.toggleTheme();
        });
      },
      secondary: const Icon(Icons.lightbulb_outline),
    );
  }
}
