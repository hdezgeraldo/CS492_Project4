import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/new_entry.dart';
import 'screens/journal_entry.dart';
import 'screens/journal_entry_list.dart';
import 'db/database_manager.dart';

class App extends StatefulWidget {

  static final routes = {
    NewEntry.routeName: (context) => NewEntry(),
    JournalEntries.routeName: (context) => JournalEntries(),
  };

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  late bool lights = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Journal',
      theme: getThemeValue(),
      routes: App.routes,
    );
  }

  void initState() {
    super.initState();
    lights = false;
    _boolLightValue();
  }

  _boolLightValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lights = prefs.getBool('lightValue') ?? false;
    });
  }

  ThemeData getThemeValue() {
    if(lights) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  Future toggleTheme() async {
    setState(() {
      lights = !lights;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightValue', lights);
  }
}