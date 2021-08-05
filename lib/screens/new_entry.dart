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
