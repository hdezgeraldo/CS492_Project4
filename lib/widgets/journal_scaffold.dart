import 'package:flutter/material.dart';
import 'settings_drawer.dart';
import '../screens/new_entry.dart';

class JournalScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const JournalScaffold({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: child,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NewEntry.routeName);
          },
          child: Icon(Icons.add)
      ),
      endDrawer: SettingsDrawer(),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
