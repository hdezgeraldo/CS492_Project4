import 'package:flutter/material.dart';
import '../screens/new_entry.dart';
import '../widgets/single_entry.dart';
import '../widgets/settings_drawer.dart';
import '../models/journal_entry.dart';

class JournalEntryScreen extends StatelessWidget {
  static const routeName = 'journal_entry';
  final JournalEntry entry;

  const JournalEntryScreen({Key? key, required this.entry}) : super(key: key);

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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleEntry(title: entry.title, body: entry.body),
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
