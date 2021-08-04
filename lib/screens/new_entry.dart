import 'package:flutter/material.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/settings_drawer.dart';

class NewEntry extends StatelessWidget {
  static const routeName = 'new_entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Journal Entry'),
      ),
      body: JournalEntryForm(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NewEntry.routeName);
          },
          child: Icon(Icons.add)
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
