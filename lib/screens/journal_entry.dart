import 'package:flutter/material.dart';
import '../screens/new_entry.dart';
import '../screens/journal_entry_list.dart';
import '../widgets/settings_drawer.dart';

class JournalEntry extends StatelessWidget {
  static const routeName = 'journal_entry';
  final String title;
  final String body;
  final String rating;
  final DateTime dateTime;

  const JournalEntry({Key? key, required this.title, required this.body, required this.rating, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '$title',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '$dateTime',
                ),
              ],
            ),
          ],

        ),
      ),
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
