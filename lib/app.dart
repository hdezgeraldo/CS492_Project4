import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/new_entry.dart';
import '../screens/new_entry.dart';
import '../screens/journal_entries.dart';
import '../widgets/dark_switch.dart';

class App extends StatefulWidget {

  // static final routes = {
  //   Welcome.routeName: (context) => Welcome(),
  //   NewEntry.routeName: (context) => NewEntry()
  // };

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
      // routes: App.routes,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Welcome'),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            body: Center(
                // child: JournalEntriesScreen()
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(NewEntry.routeName);
                },
                child: Icon(Icons.add)
            ),
            endDrawer: Drawer(

              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Settings'),
                  ),
                  Container(
                      child: DarkThemeSwitch()
                  )
                  // SettingsDrawer(),
                ],
              ),
            ),
            endDrawerEnableOpenDragGesture: false,
          );
        },
      },
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